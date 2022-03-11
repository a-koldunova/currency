//
//  BlackMarket.swift
//  currency
//
//  Created by Anastasia Koldunova on 11.03.2022.
//

import UIKit

class BlackMarketView: UIView {

    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var buyLabel: UILabel!
    @IBOutlet weak var sellLabel: UILabel!
    @IBOutlet weak var buyView: UIView! {
        didSet {
            buyView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var sellView: UIView! {
        didSet {
            sellView.layer.cornerRadius = 10
        }
    }
    var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    private func configureView() {
        guard let view = loadViewFromNib() else { return }
        
        view.frame = bounds
        view.layer.cornerRadius = 20.0
        view.layer.masksToBounds = false
//        view.clipsToBounds = true
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: BlackMarketView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    func configure(sellText : String, buyText : String, image : CoinImage) {
        sellLabel.text = sellText
        buyLabel.text = buyText
        coinImage.image = image.image
        
    }

}
