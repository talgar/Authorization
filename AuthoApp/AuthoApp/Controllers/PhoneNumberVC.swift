//
//  PhoneVerificationVC.swift
//  AuthoApp
//
//  Created by admin on 26.12.2020.
//

import UIKit

class PhoneNumberVC: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var sendBTN: UIButton!
    @IBOutlet weak var signInWithBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBTN.layer.cornerRadius = 8
        signInWithBTN.layer.cornerRadius = 8
        hideKeyboardWhenTappedAround()
        phoneNumberTextField.becomeFirstResponder()
    }

    //MARK: - send number
    @IBAction func sendAct(_ sender: Any) {
        let number = phoneNumberTextField.text
        if number != "" {
            verification(number: number!)
        } else {
            showAlert(title: "Notice", message: "Please enter your phone number!")
        }
    }
    
    //MARK: - sign in with (backBTN)
    @IBAction func signInWithAct(_ sender: Any) {
        mainViewSegue()
    }
}

