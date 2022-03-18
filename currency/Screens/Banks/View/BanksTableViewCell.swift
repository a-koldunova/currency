//
//  BanksTableViewCell.swift
//  currency
//
//  Created by Tanya Koldunova on 11.03.2022.
//

import UIKit

class BanksTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var bankView: UIView! {
        didSet {

            bankView.layer.masksToBounds = false
            bankView.layer.backgroundColor = UIColor(red: 0.98, green: 1, blue: 0.976, alpha: 1).cgColor
            bankView.layer.cornerRadius = 16
            bankView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            bankView.layer.shadowOpacity = 1
            bankView.layer.shadowRadius = 4
            bankView.layer.shadowOffset = CGSize(width: 0, height: 4)
            bankView.layer.bounds = bankView.bounds
            bankView.layer.position = bankView.center
        }
    }
    @IBOutlet weak var bankImageView: UIImageView!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var buyLabel: UILabel!
    @IBOutlet weak var sellLabel: UILabel!
    
    var link: String?
    var id: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ model: BankFullInfoModel) {
        bankLabel.text = model.exchange.name
        buyLabel.text = model.exchange.b
        sellLabel.text = model.exchange.s
        link = model.link
        id = model.id
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
