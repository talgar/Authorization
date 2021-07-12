//
//  Utilities.swift
//  AuthoApp
//
//  Created by admin on 25.12.2020.
//

import Foundation
import UIKit

class Utilities {
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let newPassword = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return newPassword.evaluate(with: password)
    }
}
