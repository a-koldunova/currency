import UIKit
import Lottie


class BlackMarketViewController: MainViewController<BlackMarketPresenterProtocol> {
    
    @IBOutlet weak var chartView: ChartView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.layer.cornerRadius = 16
            tableView.setViewShadow()
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    @IBOutlet weak var anView: UIView! {
        didSet {
            anView.setViewShadow()
            anView.backgroundColor = UIColor(red: 0.98, green: 1, blue: 0.976, alpha: 1)
            anView.layer.cornerRadius = 16
        }
    }
    let animationView = AnimationView(name: "chartView")
    let chartUpAnimation = AnimationView(name: "chart_up")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = L10n.TabBar.Item.BlackMarket.title
        initRefreshControl()
        refreshControl!.addTarget(self, action: #selector(self.updateScrollView), for: .valueChanged)
        scrollView.addSubview(refreshControl!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setChartView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let id = presenter.blackMarketModel?.forecast {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.setAnimationStart(id: id)
            }
        }

    }
    
    func setAnimationView(_ view : UIView) {
        view.isHidden = true
        if view === chartUpAnimation {
        view.frame = CGRect(x: 0, y: anView.bounds.height/2 - anView.bounds.width/2, width: 300, height: anView.bounds.width)
        } else {
            view.frame = CGRect(x: 0, y: 0, width: anView.bounds.width, height: anView.bounds.height)
        }
        view.contentMode = .scaleAspectFit

        anView.addSubview(view)
    }
    
    @objc func updateScrollView() {
        presenter.getBlackMarket()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension BlackMarketViewController : BlackMarketProtocol {
    func setAnimationStart(id : Int) {
        DispatchQueue.main.async {
            self.chartView.animate(id: id)
        }
    }
    
    func tableViewReloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func activityIndictorStartAnimating() {
        DispatchQueue.main.async {
            if !self.refreshControl!.isRefreshing {
            self.activityIndicator.startAnimating()
            }
        }
    }
    
    func activityIndictorStopAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func endRefreshing() {
        DispatchQueue.main.async {
                self.refreshControl!.endRefreshing()
        }
    }
    func setChartView() {
        DispatchQueue.main.async {
            self.chartView.setView(id: self.presenter.blackMarketModel?.forecast)
        }
        
    }
}

extension BlackMarketViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if let model = presenter.blackMarketModel {
                return model.UAHrates.count
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "buy_sell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "blackMarket_cell", for: indexPath) as! BlackMarketTableViewCell
            guard let data = presenter.blackMarketModel?.UAHrates[indexPath.row] else { return UITableViewCell() }
            let imageData = presenter.blackImage[indexPath.row]
            cell.blackMarketView.configure(sellText: String(format: (indexPath.row == 2) ? "%.3f" : "%.2f", data.sell), buyText: String(format: (indexPath.row == 2) ? "%.3f" : "%.2f", data.buy), image: imageData)
            cell.blackMarketView.separator.isHidden = indexPath.row == 2
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let data = presenter.blackMarketModel?.UAHrates[indexPath.row] else { return }
            let title = (indexPath.row == 0) ? "USD" : (indexPath.row == 1) ? "EURO" : "RUB"
            let sell = data.sell
            let buy = data.buy
            presenter.goToCalculator(self, buy: buy, sell: sell, title: title)
            tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
}
