//
//  CalculatorViewController.swift
//  currency
//
//  Created by Anastasia Koldunova on 14.03.2022.
//

import UIKit

class CalculatorViewController: MainViewController<CalculatorPresenterProtocol>, CalculatorProtocol {

    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.inputAccessoryView = UIView()
            textField.inputView = UIView()
            textField.delegate = self
            textField.setViewShadow()
            
        }
    }
    @IBOutlet weak var currencyView: UIView! {
        didSet {
            currencyView.layer.cornerRadius = 16
            currencyView.setViewShadow()
        }
    }
    @IBOutlet weak var dataView: BlackMarketView! {
        didSet {
            dataView.separator.isHidden = true
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func CalculatorButtonPressed(_ sender: UIButton) {
        if 0 ... 9 ~= sender.tag {
            let str = textField.text ?? ""
            textField.text = str + sender.tag.description
        } else if sender.tag == 11 {
            textField.text = ""
        } else {
           
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
        return false
    }
}
