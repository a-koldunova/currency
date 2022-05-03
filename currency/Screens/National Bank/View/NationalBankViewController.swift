//
//  NationalBankViewController.swift
//  currency
//
//  Created by Tanya Koldunova on 14.03.2022.
//

import UIKit

class NationalBankViewController: MainViewController<NationalBankPresneterProtocol> {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nationalBankTableView: UITableView! {
        didSet {
            nationalBankTableView.delegate = self
            nationalBankTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = L10n.TabBar.Item.NatBank.title
        presenter.getNationalBankApi()
        initRefreshControl()
        refreshControl!.addTarget(self, action: #selector(self.updateTableView), for: .valueChanged)
        nationalBankTableView.addSubview(refreshControl!)
    }
     
    @objc func updateTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.refreshControl?.endRefreshing()
        }
    }

}

extension NationalBankViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.nationalBankModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nationalBank", for: indexPath)
        cell.selectionStyle = .none
        guard let nationalBankModel = presenter.nationalBankModel else {return UITableViewCell()}
        var content = cell.defaultContentConfiguration()
        let attributedText = NSAttributedString(string: nationalBankModel[indexPath.row].txt, attributes: [.font : UIFont(name: "Cabin-Regular", size: 16)!, .foregroundColor: MainColors.fontColor.color])
        let attributedSecondaryText = NSAttributedString(string: String(format: "%f", nationalBankModel[indexPath.row].rate), attributes: [.font : UIFont(name: "Cabin-Regular", size: 16)!, .foregroundColor: MainColors.fontColor.color])
        content.attributedText = attributedText
        content.secondaryAttributedText = attributedSecondaryText
        content.image = FlagUtils.emojiToImage(emoji: FlagUtils.getflagByName(country: nationalBankModel[indexPath.row].cc))
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}

extension NationalBankViewController: NationalBankViewProtocol {
    func endRefreshing() {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.nationalBankTableView.reloadData()
        }
    }
    
    func activityIndicatorStartAnimating() {
        DispatchQueue.main.async {
            if !self.refreshControl!.isRefreshing {
            self.activityIndicator.startAnimating()
            }
        }
    }
   
    func activityIndicatorStopAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}
