//
//  CalculatorView.swift
//  currency
//
//  Created by Anastasia Koldunova on 23.03.2022.
//

import UIKit
import Lottie

class CalculatorView: UIView {
    
    @IBOutlet weak var gotButton: UIButton! {
        didSet {
            gotButton.layer.cornerRadius = 10
            gotButton.setViewShadow()
        }
    }
    @IBOutlet weak var swipeAnimation: AnimationView!
    @IBOutlet weak var titleLabel: UILabel!
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
        view.clipsToBounds = true
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func printDJJD() {
        
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: CalculatorView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
