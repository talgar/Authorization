//
//  Extentions.swift
//  AuthoApp
//
//  Created by admin on 25.12.2020.
//

import Foundation
import UIKit
import GoogleSignIn
import Firebase
import FirebaseAuth

extension UIViewController :  GIDSignInDelegate {

    //MARK: - google sign in
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
       
        if error != nil { return }
        
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if error != nil { return }
            else {self.homeViewSegue()}
        }
    }
    
    //MARK: - phone verification
    func verification(number: String){
        let userDefaults = UserDefaults.standard
        let alert = UIAlertController(title: "Notice", message: "Is this your phone number? \n \(number)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
            PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) {(verificationID, error) in
                if error != nil {
                    print("Error \(String(describing: error?.localizedDescription))")
                } else {
                    userDefaults.setValue(verificationID, forKey: "phoneID")
                    let vc = self.storyboard?.instantiateViewController(identifier: Constants.codeVC) as! CodeVC
                    self.view.window?.rootViewController = vc
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
        
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - code authorization
    func authorization(code: String){
        let userDefaults = UserDefaults.standard
        let credential : PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: userDefaults.string(forKey: "phoneID")!, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("Error: \(String(describing: error?.localizedDescription))")
                self.showAlert(title: "Error", message: error!.localizedDescription)
            } else {
                self.homeViewSegue()
            }
        }
    }
    
    //MARK: - alert func
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - segue func
    func homeViewSegue(){
        let vc = storyboard?.instantiateViewController(identifier: Constants.homeVC) as! HomeVC
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    
    func mainViewSegue(){
        let vc = storyboard?.instantiateViewController(identifier: Constants.mainVC) as! MainVC
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    
    func phoneViewSegue(){
        let vc = storyboard?.instantiateViewController(identifier: Constants.phoneNumberVC) as! PhoneNumberVC
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    
    //MARK: - keyboard func 
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}


