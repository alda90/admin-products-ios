//
//  Validations.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit


class Validations {
    
    class func validateText(value: String) -> Bool  {
        var validate = false
        
        let val = value.trimmingCharacters(in: .whitespaces)
        
        if val.count > 0 && val != "" {
            validate = true
        }
        
        return validate
        
    }
    
    class func validateEmail(value: String) -> Bool {
        var validate = false
        
        let val = value.trimmingCharacters(in: .whitespaces)
        if isEmailValid(val){
            validate = true
        }
        
        return validate
    }
    
    private class func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
