//
//  SignUpVC.swift
//  AuthoApp
//
//  Created by admin on 24.12.2020.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpVC: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var signUpBTN: UIButton!
    @IBOutlet weak var signInWithBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpBTN.layer.cornerRadius = 8
        signInWithBTN.layer.cornerRadius = 8
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: - sign up
    @IBAction func signUpAct(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showAlert(title: "Notice", message: error!)
        } else {
            let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email!, password: password!) { (result, error) in
                if error != nil {
                    self.showAlert(title: "Notice", message: "Error creating user")
                }
                else {
                    let dataBase = Firestore.firestore()
                    dataBase.collection("users").addDocument(data: ["firstname" : firstName!,
                                                                    "lastname" : lastName!,
                                                                    "uid" : result!.user.uid]){(error) in
                        if error != nil {
                            self.showAlert(title: "Notice", message: "Error saving data")
                        }
                    }
                    self.homeViewSegue()
                }
            }
        }
    }
    
    //MARK: - sign up func
    func validateFields() -> String? {
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        //Check if the password is secure
        let cleanedPassword = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }
        return nil
    }
    
    //MARK: - sign in with (backBTN)
    @IBAction func signInWithAct(_ sender: Any) {
        mainViewSegue()
    }
    
    //MARK: - textFields should return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextfield.becomeFirstResponder()
        } else {
            passwordTextfield.resignFirstResponder()
        }
        return true
    }
}
