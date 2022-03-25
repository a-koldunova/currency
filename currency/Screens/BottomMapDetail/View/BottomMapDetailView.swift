//
//  BottomMapDetailView.swift
//  currency
//
//  Created by Tanya Koldunova on 16.03.2022.
//

import UIKit

class BottomMapDetailView: UIView {
    @IBOutlet weak var detailView: UIView! {
        didSet {
            detailView.layer.cornerRadius = 6
        }
    }
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton! {
        didSet {
            phoneButton.layer.cornerRadius = 6
        }
    }
    @IBOutlet weak var usdRateView: BlackMarketView! {
        didSet {
            usdRateView.buyView.backgroundColor = .clear
            usdRateView.sellView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var eurRateView: BlackMarketView! {
        didSet {
            eurRateView.buyView.backgroundColor = .clear
            eurRateView.sellView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var usdViewHeight: NSLayoutConstraint!
    @IBOutlet weak var eurViewHeight: NSLayoutConstraint!
    
    var contenView: UIView?
    var presenter: BottomMapDetailPresenterProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    private func configureView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        //view.backgroundColor = MainColors.bottomSheetColor.color
        view.layer.cornerRadius = 16.0
        view.layer.masksToBounds = false
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let blurEffect = UIBlurEffect.init(style: .light)

        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)

        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = view.frame

        view.insertSubview(bluredView, at: 0)
        view.backgroundColor = MainColors.bottomSheetColor.color
        phoneButton.backgroundColor = .clear
//        MainColors.selectedColor.color
        addSubview(view)
        contenView = view
    }
    
    func setFrame() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.allowUserInteraction], animations: {
            self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-380, width: UIScreen.main.bounds.width, height: 400)
        })
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: BottomMapDetailView.self), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    
  
    @IBAction func phoneNumberButton(_ sender: Any) {
        presenter.callByCurrentNumber(phoneButton.titleLabel?.text)
    }
    
    
}

extension BottomMapDetailView: BottomMapDetailViewProtocol {
    func configure(_ model: BankMapAnnotation) {
        usdRateView.isHidden = true
        eurRateView.isHidden = true
        usdViewHeight.constant = 0
        eurViewHeight.constant = 0
        bankNameLabel.text = model.title
        adressLabel.text = model.address
        phoneButton.setTitle(model.phone.description, for: .normal)
        guard let exchangeModel = model.exchangeModel else {return}
        for model in exchangeModel {
            if model.name == "usd" {
                usdRateView.configure(sellText: model.s, buyText: model.b, image: AppImage.dollarImage)
                usdRateView.isHidden = false
                usdViewHeight.constant = 32
            } else if model.name == "eur" {
                eurRateView.configure(sellText:model.s, buyText: model.b, image: AppImage.euroImage)
                eurRateView.isHidden = false
                eurViewHeight.constant = 32
            }
            
        }
        eurRateView.separator.isHidden = true
        usdRateView.separator.isHidden = true
    }
    
    
}
