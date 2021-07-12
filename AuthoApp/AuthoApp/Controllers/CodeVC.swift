//
//  CodeVC.swift
//  AuthoApp
//
//  Created by admin on 26.12.2020.
//

import UIKit

class CodeVC: UIViewController {

    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var logInBTN: UIButton!
    @IBOutlet weak var backBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInBTN.layer.cornerRadius = 8
        backBTN.layer.cornerRadius = 8
        hideKeyboardWhenTappedAround()
        codeTextField.becomeFirstResponder()
    }
    
    //MARK: - login with phone number (code)
    @IBAction func logInAct(_ sender: Any) {
        let code = codeTextField.text
        if code != "" {
            authorization(code: code!)
        } else {
            showAlert(title: "Notice", message: "Please enter the code!")
        }
    }
    
    //MARK: - backBTN
    @IBAction func backAct(_ sender: Any) {
        phoneViewSegue()
    }
}
