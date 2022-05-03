//
//  ChartView.swift
//  currency
//
//  Created by Anastasia Koldunova on 27.03.2022.
//

import UIKit

class ChartView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstViewHeightContraint: NSLayoutConstraint! {
        didSet {
//            firstViewHeightContraint.constant = 0
        }
    }
    @IBOutlet weak var secondViewConstraint: NSLayoutConstraint! {
        didSet {
//            secondViewConstraint.constant = 0
        }
    }
    @IBOutlet weak var thirdViewContraint: NSLayoutConstraint! {
        didSet {
//            thirdViewContraint.constant = 0
        }
    }
    @IBOutlet weak var bottomViewTralingConstraint: NSLayoutConstraint! {
        didSet {
            bottomViewTralingConstraint.constant = self.bounds.width
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
//        view.layer.cornerRadius = 20.0
        view.layer.masksToBounds = false
        view.clipsToBounds = false
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func setView(id : Int?) {
        firstViewHeightContraint.constant = 0
        secondViewConstraint.constant = 0
        thirdViewContraint.constant = 0
        bottomViewTralingConstraint.constant = self.bounds.width
        imageTopConstraint.constant = 100
        imageView.isHidden = true
        imageView.image = (id == -1) ? AppImage.arrow_down.image : (id == 0) ? AppImage.arrow_static.image : AppImage.arrow_up.image 
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: ChartView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func animate(id : Int) {
        
        switch id  {
        case 1 : startAnimation(firstViewContraint: 50, secondViewConstraint: 86, thirdViewContraint: 130)
        case 0 : startAnimation(firstViewContraint: 86, secondViewConstraint: 86, thirdViewContraint: 86)
        case -1 : startAnimation(firstViewContraint: 130, secondViewConstraint: 85, thirdViewContraint: 50)
        default : break
        }
    }
    
    
    func startAnimation(firstViewContraint : CGFloat, secondViewConstraint : CGFloat, thirdViewContraint : CGFloat) {
        UIView.animate(withDuration: 1) {
            self.bottomViewTralingConstraint.constant = 0
            self.layoutIfNeeded()
        } completion: { isFinished in
            if isFinished {
                UIView.animate(withDuration: 1) {
                    self.firstViewHeightContraint.constant = firstViewContraint
//                    (id == 1) ? 50 : (id == 0) ?
                     self.layoutIfNeeded()
                } completion: { isFin in
                    if isFin {
                    UIView.animate(withDuration: 1) {
                        self.secondViewConstraint.constant = secondViewConstraint
                        self.layoutIfNeeded()
                    } completion: { isStopped in
                        if isStopped {
                            UIView.animate(withDuration: 1) {
                                self.thirdViewContraint.constant = thirdViewContraint
                                    self.layoutIfNeeded()
                            } completion: { finished in
                                if finished {
                                    UIView.animate(withDuration: 1) {
                                    self.imageView.isHidden = false
                                    self.imageTopConstraint.constant = 0
                                    self.layoutIfNeeded()
                                    }
                                }
                            }
                        }
                    }
                }
                }
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
}
