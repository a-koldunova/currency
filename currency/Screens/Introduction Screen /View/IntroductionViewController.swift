import UIKit
import AVFoundation
import CoreLocation
import Lottie

class IntroductionViewController: MainViewController<IntroductionPresenterProtocol>, IntroductionProtocol {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var calculatorAnimation: AnimationView!
    @IBOutlet weak var mapAnimation: AnimationView!
    @IBOutlet weak var exchangeAnimation: AnimationView! {
        didSet {
            startAnimation(animationSpeed: 1, exchangeAnimation)
        }
    }
    @IBOutlet weak var view1TitleLabel: UILabel! {
        didSet {
            view1TitleLabel.text = L10n.Introduction.View1.Label.title
        }
    }
    @IBOutlet weak var view2TitleLabel: UILabel! {
        didSet {
            view2TitleLabel.text = L10n.Introduction.View2.Label.title
        }
    }
    @IBOutlet weak var view3TitleLabel: UILabel! {
        didSet {
            view3TitleLabel.text = L10n.Introduction.View3.Label.title
        }
    }
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }

    @IBOutlet weak var firstNextButton: UIButton! {
        didSet {
            firstNextButton.layer.cornerRadius = 10
            firstNextButton.setViewShadow()
            firstNextButton.setTitle(L10n.Introduction.Button.title, for: .normal)
        }
    }
    @IBOutlet weak var secondNextButton: UIButton! {
        didSet {
            secondNextButton.layer.cornerRadius = 10
            secondNextButton.setViewShadow()
        }
    }
    @IBOutlet weak var thirdNextButton: UIButton! {
        didSet {
            thirdNextButton.layer.cornerRadius = 10
            thirdNextButton.setViewShadow()
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            activityIndicator.style = .medium
        } else {
            activityIndicator.style = .whiteLarge
        }
        let frame = view.frame
        widthConstraint.constant =  frame.width
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        activityIndicator.stopAnimating()
    }

    private func scrollToIndex(index: Int) {
        scrollView.scrollRectToVisible(CGRect(x: CGFloat(index) * widthConstraint.constant,
                                              y: 0,
                                              width: view.frame.width,
                                              height: view.frame.height), animated: true)
    }
    
    private func startAnimation ( animationSpeed : CGFloat, _ animation : AnimationView) {
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.animationSpeed = animationSpeed
        animation.play()
    }


    @IBAction func nextButton1Pressed(_ sender: Any) {
        exchangeAnimation.stop()
        startAnimation(animationSpeed: 1, mapAnimation)
        scrollToIndex(index: 1)
    }

    @IBAction func nextButton2Pressed(_ sender: Any) {
        mapAnimation.stop()
        startAnimation(animationSpeed: 1, calculatorAnimation)
        scrollToIndex(index: 2)
    }

    @IBAction func nextButton3Pressed(_ sender: Any) {
        calculatorAnimation.stop()
        presenter.goToTabbar()
    }

  
}

extension IntroductionViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
