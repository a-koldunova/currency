//
//  BlackMarketViewController.swift
//  currency
//
//  Created by Anastasia Koldunova on 11.03.2022.
//

import UIKit

class BlackMarketViewController: MainViewController<BlackMarketPresenterProtocol>, BlackMarketProtocol {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            stackView.layer.cornerRadius = 16
            stackView.setViewShadow()
        }
    }
    @IBOutlet weak var rubleView: BlackMarketView! {
        didSet {
            rubleView.configure(sellText: "30.00", buyText: "30.00", image: .rubleImage)
            rubleView.separator.isHidden = true 
        }
    }
    @IBOutlet weak var euroView: BlackMarketView! {
        didSet {
            euroView.configure(sellText: "30.00", buyText: "30.00", image: .euroImage)
        }
    }
    @IBOutlet weak var dollarView: BlackMarketView! {
        didSet {
            dollarView.configure(sellText: "30.00", buyText: "30.00", image: .dollarImage)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Черный рынок"
        initRefreshControl()
        refreshControl!.addTarget(self, action: #selector(self.updateScrollView), for: .valueChanged)
        scrollView.addSubview(refreshControl!)
    }
    
    
    @objc func updateScrollView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshControl!.endRefreshing()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
