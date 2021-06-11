//
//  CustomControllers.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit

class appCustomButton: UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        
        self.layer.backgroundColor = UIColor(named: "colorPrincipal")?.cgColor
        self.layer.cornerRadius = self.frame.height / 3.5
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        //self.layer.borderColor = colorSecundario.cgColor
        //self.layer.borderWidth = 3
    }
}


class appButton: UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = self.frame.height / 3.5
        //self.layer.shadowColor = UIColor.gray.cgColor
        //self.layer.shadowRadius = 1
        //self.layer.shadowOpacity = 0
        //self.layer.shadowOffset = CGSize(width: -3, height: -2)
        self.layer.borderColor = UIColor(named: "colorPrincipal")?.cgColor
        self.layer.borderWidth = 3
    }
}

class FloatingActionButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        layer.backgroundColor = UIColor(named: "colorPrincipal")?.cgColor
        layer.cornerRadius = frame.height/2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
}


//extension UITextField{
//
//    @IBInspectable var doneAccessory: Bool{
//        get{
//            return self.doneAccessory
//        }
//        set (hasDone) {
//            if hasDone{
//                addDoneButtonOnKeyboard()
//            }
//        }
//    }
//
//    func addDoneButtonOnKeyboard()
//    {
//        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
//        doneToolbar.barStyle = .default
//
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let done: UIBarButtonItem = UIBarButtonItem(title: "Aceptar", style: .done, target: self, action: #selector(self.doneButtonAction))
//
//        let items = [flexSpace, done]
//        doneToolbar.items = items
//        doneToolbar.sizeToFit()
//
//        self.inputAccessoryView = doneToolbar
//    }
//
//    @objc func doneButtonAction() {
//        self.resignFirstResponder()
//    }
//
//}



func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
