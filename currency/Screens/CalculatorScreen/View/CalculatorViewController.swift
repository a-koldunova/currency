//
//  CalculatorViewController.swift
//  currency
//
//  Created by Anastasia Koldunova on 14.03.2022.
//

import UIKit

class CalculatorViewController: MainViewController<CalculatorPresenterProtocol>, CalculatorProtocol {
    
    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            setTextField(userTextField)
            //            textField.backgroundColor = UIColor(red: 0.879, green: 0.942, blue: 0.881, alpha: 1)
            
        }
    }
    @IBOutlet weak var buyTextField: UITextField! {
        didSet {
            setTextField(buyTextField)
        }
    }
    @IBOutlet weak var sellTextField: UITextField! {
        didSet {
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
    var action : CalculatorAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = presenter.title
    }
    
    // MARK: IBActions
    @IBAction func CalculatorButtonPressed(_ sender: UIButton) {
        if 0 ... 9 ~= sender.tag {
            switch action {
            case .userNumber:
                userNumberAction(sender.tag)
            case .buy:
                buyAction(sender.tag)
            case .sell:
                sellAction(sender.tag)
            case .none:
                break
            }
        } else if sender.tag == 11 {
            clearTextField()
            presenter.clearUserTF = true
            presenter.clearBuyTF = true
            presenter.clearSellTF = true
        } else {
            
        }
    }
    // MARK: Fuctions
    func clearTextField() {
        userTextField.text = ""
        sellTextField.text = "0"
        buyTextField.text = "0"
    }
    
    func addCaracterToTextField(_ textField : UITextField, character : Int) {
        let str = textField.text ?? ""
        textField.text = str + character.description
    }
    
    func setTextField(_ textField : UITextField) {
        textField.inputAccessoryView = UIView()
        textField.inputView = UIView()
        textField.delegate = self
        textField.setViewShadow()
    }
    
    func userNumberAction(_ tag : Int) {
        if presenter.clearUserTF {
            presenter.clearUserTF = false
            userTextField.text = tag.description
        } else {
            addCaracterToTextField(userTextField, character: tag)
        }
        buyTextField.text = presenter.convert(value: (userTextField.text! as NSString).doubleValue, to: presenter.buy, from: 1)
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
        return false
    }
    
}
