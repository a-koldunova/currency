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

     //   let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
      //  bluredView.contentView.addSubview(visualEffect)

     //   visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = view.frame

        view.insertSubview(bluredView, at: 0)
        view.backgroundColor = MainColors.bottomSheetColor.color
        phoneButton.backgroundColor = MainColors.selectedColor.color
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
        bankNameLabel.text = model.title
        adressLabel.text = model.address
        phoneButton.setTitle(model.phone.description, for: .normal)
    }
    
    
}
