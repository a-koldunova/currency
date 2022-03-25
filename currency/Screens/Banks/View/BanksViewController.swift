//
//  BanksViewController.swift
//  currency
//
//  Created by Tanya Koldunova on 11.03.2022.
//

import UIKit

class BanksViewController: MainViewController<BanksPresenterProtocol> {
    @IBOutlet weak var banksSegmentControl: UISegmentedControl!
    @IBOutlet weak var banksTableView: UITableView! {
        didSet {
            banksTableView.delegate = self
            banksTableView.dataSource = self
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = L10n.TabBar.Item.Banks.title
        presenter.getBanks()
        initRefreshControl()
        refreshControl!.addTarget(self, action: #selector(self.updateTableView), for: .valueChanged)
        banksTableView.addSubview(refreshControl!)
    }
    @IBAction func changeBankSegmentControl(_ sender: Any) {
        reloadData()
    }
    
    func configureAlert(title: String, message: String, link: String, id: Int, buy : Double, sell : Double, titleCalc: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action1 = UIAlertAction(title: L10n.Alert.Action.Map.title, style: .default) { action in
            self.presenter.goToMapViewController(bankId: id)
        }
        let action2 = UIAlertAction(title: L10n.Alert.Action.Site.title, style: .default) { action in
            self.presenter.goToTheSite(for: link)
        }
        let action3 = UIAlertAction(title: L10n.Alert.Action.Calculator.title, style: .default) { action in
            self.presenter.goToCalculatorVC(self, buy: buy, sell: sell, title: titleCalc)
        }
        let cancelAction = UIAlertAction(title: L10n.Alert.Action.Cancel.title, style: .destructive, handler: { (action) -> Void in })
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK : @objc function
    @objc func updateTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.refreshControl!.endRefreshing()
        }
    }
    
}

extension BanksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getArray(banksSegmentControl.selectedSegmentIndex).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "banks", for: indexPath) as! BanksTableViewCell
        cell.configure(presenter.getArray(banksSegmentControl.selectedSegmentIndex)[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! BanksTableViewCell
        let model = presenter.getArray(banksSegmentControl.selectedSegmentIndex)[indexPath.row]
        let buy = (model.exchange.b as NSString).doubleValue
        let sell = (model.exchange.s as NSString).doubleValue
        configureAlert(title: cell.bankLabel.text!, message: "", link: cell.link ?? "", id: cell.id, buy: buy, sell: sell, titleCalc: model.exchange.name)
        tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
    }
    
}

extension BanksViewController: BanksViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.banksTableView.reloadData()
        }
    }
    func activityIndicatorStartAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    func activityIndicatorStopAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}
