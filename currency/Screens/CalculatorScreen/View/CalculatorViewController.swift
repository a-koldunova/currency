//
//  CalculatorViewController.swift
//  currency
//
//  Created by Anastasia Koldunova on 14.03.2022.
//

import UIKit

class CalculatorViewController: MainViewController<CalculatorPresenterProtocol>, CalculatorProtocol {
    
    @IBOutlet weak var sellLabel: UILabel! {
        didSet {
            sellLabel.text = L10n.Calculator.Sell.title
        }
    }
    @IBOutlet weak var buyLabel: UILabel! {
        didSet {
            buyLabel.text = L10n.Calculator.Buy.title
        }
    }
    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            setTextField(userTextField)
            //            textField.backgroundColor = UIColor(red: 0.879, green: 0.942, blue: 0.881, alpha: 1)
            let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(userTextFieldGesture(gesture:)))
            userTextField.addGestureRecognizer(swipeRecognizer)
            //            userTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingDidBegin)
            
        }
    }
    @IBOutlet weak var buyTextField: UITextField! {
        didSet {
            let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(buyTextFieldGesture(gesture:)))
            buyTextField.addGestureRecognizer(swipeRecognizer)
            setTextField(buyTextField)
        }
    }
    @IBOutlet weak var sellTextField: UITextField! {
        didSet {
            let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(sellTextFieldGesture(gesture:)))
            sellTextField.addGestureRecognizer(swipeRecognizer)
            setTextField(sellTextField)
        }
    }
    
    @IBOutlet var calculatorButtons: [UIButton]! {
        didSet {
            for (i, button) in calculatorButtons.enumerated() {
                button.tag = i
                button.setTitle(i.description, for: .normal)
                button.layer.cornerRadius = 0.5 * button.bounds.size.width
                button.layer.borderColor = UIColor(red: 0.658, green: 0.658, blue: 0.658, alpha: 1).cgColor
                button.layer.borderWidth = 1
            }
            calculatorButtons[10].setTitle(".", for: .normal)
            calculatorButtons[11].setTitle("C", for: .normal)
        }
    }
    
    let overlay = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    let calculatorView = CalculatorView(frame: CGRect(x: 127, y: 248, width: 250, height: 250))
    var action : CalculatorAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = presenter.title
        if UserDefaultsValues.isViewShown {
            UserDefaultsValues.isViewShown = false
            setUpCalculatorView()
        }
    }
    
    // MARK: IBActions
    @IBAction func CalculatorButtonPressed(_ sender: UIButton) {
        if 0 ... 9 ~= sender.tag {
            switch action {
            case .userNumber: userNumberAction(sender.tag)
            case .buy: buyAction(sender.tag)
            case .sell: sellAction(sender.tag)
            case .none: break
            }
        } else if sender.tag == 11 {
            clearTextField()
            presenter.clearUserTF = true
            presenter.clearBuyTF = true
            presenter.clearSellTF = true
        } else {
            switch action {
            case .userNumber : addDot(userTextField)
            case .buy : addDot(buyTextField)
            case .sell : addDot(sellTextField)
                print("")
            case .none : break
            }
        }
    }
    // MARK: Fuctions
    
    func setUpCalculatorView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.addSubview(self.overlay)
            self.calculatorView.center.y = self.view.center.y
            self.calculatorView.center.x = self.view.center.x
            self.calculatorView.swipeAnimation.loopMode = .loop
            self.calculatorView.swipeAnimation.play()
            self.view.addSubview(self.calculatorView)
            self.calculatorView.gotButton.addTarget(self, action: #selector(self.removeView), for: .touchUpInside)
            self.animateIn()
        }
    }
    func animateIn() {
        calculatorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        calculatorView.alpha = 0
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
        UIView.animate(withDuration: 0.4) {
            self.calculatorView.alpha = 1
            self.calculatorView.transform = CGAffineTransform.identity
            self.overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.4) {
            self.calculatorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.calculatorView.alpha = 0
            self.overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
        } completion: { (_) in
            self.calculatorView.removeFromSuperview()
            self.overlay.removeFromSuperview()
        }
    }
    
    func addDot(_ textField : UITextField) {
        if let str = textField.text {
            if str.last != "." && !str.contains(".") && !str.isEmpty {
                textField.text = str + "."
            }
        }
    }
    
    func clearTextField() {
        userTextField.text = ""
        sellTextField.text = "0"
        buyTextField.text = "0"
    }
    
    func addCaracterToTextField(_ textField : UITextField, character : Int) {
        let char = character.description
        let str = textField.text == "0" ? "" : textField.text
        textField.text = (str ?? "") + char
    }
    
    func setTextField(_ textField : UITextField) {
        textField.inputAccessoryView = UIView()
        textField.inputView = UIView()
        textField.delegate = self
        textField.setViewShadow()
    }
    func deleteChacterFromTextField(_ textField : UITextField) {
        if textField.text != nil {
            if !textField.text!.isEmpty {
                textField.text!.removeLast()
            }
        }
        if textField.text?.isEmpty ?? true {
            textField.text = "0"
        }
    }
    func userNumberAction(_ tag : Int) {
        if presenter.clearUserTF {
            presenter.clearUserTF = false
            userTextField.text = tag.description
        } else {
            addCaracterToTextField(userTextField, character: tag)
        }
        var str = userTextField.text!
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        str = regex.stringByReplacingMatches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, str.count), withTemplate: "")
        buyTextField.text = presenter.convert(value: (str as NSString).doubleValue, to: presenter.buy, from: 1)
        sellTextField.text = presenter.convert(value: (userTextField.text! as NSString).doubleValue, to: presenter.sell, from: 1)
    }
    
    func buyAction(_ tag : Int) {
        if presenter.clearBuyTF {
            presenter.clearBuyTF = false
            buyTextField.text = tag.description
        } else {
            addCaracterToTextField(buyTextField, character: tag)
        }
        userTextField.text = presenter.convert(value: (buyTextField.text! as NSString).doubleValue, to: 1, from: presenter.buy)
        sellTextField.text = presenter.convert(value: (userTextField.text! as NSString).doubleValue, to: presenter.sell, from: 1)
    }
    
    func sellAction(_ tag : Int) {
        if presenter.clearSellTF {
            presenter.clearSellTF = false
            sellTextField.text = tag.description
        } else {
            addCaracterToTextField(sellTextField, character: tag)
        }
        userTextField.text = presenter.convert(value: (sellTextField.text! as NSString).doubleValue, to: 1, from: presenter.sell)
        buyTextField.text = presenter.convert(value: (userTextField.text! as NSString).doubleValue, to: presenter.buy, from: 1)
    }
    
    // MARK: objc functions
    
    //    @objc func myTextFieldDidChange(_ textField: UITextField) {
    //
    //        if let amountString = textField.text?.currencyInputFormatting() {
    //            textField.text = amountString
    //        }
    //    }
    
    @objc func removeView() {
        calculatorView.swipeAnimation.stop()
        animateOut()
    }
    
    @objc func userTextFieldGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            deleteChacterFromTextField(userTextField)
            buyTextField.text = presenter.convert(value: (userTextField.text! as NSString).doubleValue, to: presenter.buy, from: 1)
            sellTextField.text = presenter.convert(value: (userTextField.text! as NSString).doubleValue, to: presenter.sell, from: 1)
        }
    }
    @objc func buyTextFieldGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            deleteChacterFromTextField(buyTextField)
            userTextField.text = presenter.convert(value: (buyTextField.text! as NSString).doubleValue, to: 1, from: presenter.buy)
            sellTextField.text = presenter.convert(value: (userTextField.text! as NSString).doubleValue, to: presenter.sell, from: 1)
        }
    }
    @objc func sellTextFieldGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            deleteChacterFromTextField(sellTextField)
            userTextField.text = presenter.convert(value: (sellTextField.text! as NSString).doubleValue, to: 1, from: presenter.sell)
            buyTextField.text = presenter.convert(value: (userTextField.text! as NSString).doubleValue, to: presenter.buy, from: 1)
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

extension CalculatorViewController : UITextFieldDelegate {
    
    private func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //        self.view.endEditing(true)
        if textField == userTextField {
            action = .userNumber
            userTextField.backgroundColor = UIColor(red: 0.879, green: 0.942, blue: 0.881, alpha: 1)
            buyTextField.backgroundColor = .white
            sellTextField.backgroundColor = .white
            presenter.clearUserTF = true
        } else if textField == buyTextField {
            action = .buy
            buyTextField.backgroundColor = UIColor(red: 0.879, green: 0.942, blue: 0.881, alpha: 1)
            userTextField.backgroundColor = .white
            sellTextField.backgroundColor = .white
            presenter.clearBuyTF = true
        } else if textField == sellTextField {
            action = .sell
            sellTextField.backgroundColor = UIColor(red: 0.879, green: 0.942, blue: 0.881, alpha: 1)
            buyTextField.backgroundColor = .white
            userTextField.backgroundColor = .white
            presenter.clearSellTF = true
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("hello")
        return false
    }
    
}
