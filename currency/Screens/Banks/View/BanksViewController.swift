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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
    }
    @IBAction func changeBankSegmentControl(_ sender: Any) {
        reloadData()
    }
    
}

extension BanksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getArray(banksSegmentControl.selectedSegmentIndex).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "banks", for: indexPath) as! BanksTableViewCell
        cell.configure(presenter.getArray(banksSegmentControl.selectedSegmentIndex)[indexPath.row], currecy: presenter.getCurrency(banksSegmentControl.selectedSegmentIndex))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
}

extension BanksViewController: BanksViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.banksTableView.reloadData()
        }
    }
}
