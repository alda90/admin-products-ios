//
//  LoginView.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 05/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
//import Firebase

class LoginView: UIViewController, UITextFieldDelegate, loginViewModelProtocol {
    
    @IBOutlet var viewInicio: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    
    private var viewModel = LoginViewModel()
    private var router = LoginRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginView.hideKeyboard)))
       
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIApplication.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIApplication.keyboardWillChangeFrameNotification, object: nil)
        
        viewModel.bind(view: self, router: router, delegate: self)
    }
    
    // MARK: Validate single field
    // Don't forget to use UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           
        if txtEmail.isFirstResponder {
            txtPassword.becomeFirstResponder()
        } else if txtPassword.isFirstResponder {
            self.view.endEditing(true)
            validate()
        }
        
        return true
    }

    @IBAction func actionLogin(_ sender: Any) {
        validate()
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
       ///////////////   FUNCTIONS
       ///////////////////////////////////////////////////////////////////////////////////////////////
       
       @objc func hideKeyboard(){
                 self.view.endEditing(true)
       }
       
       @objc func Keyboard(notification: Notification){
              let userInfo = notification.userInfo!
              
              let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
              let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
              
              if notification.name == UIApplication.keyboardWillHideNotification {
                  scrollView.contentInset = UIEdgeInsets.zero
              } else {
                  scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
              }
              
              scrollView.scrollIndicatorInsets = scrollView.contentInset
          }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
      ///////////////   PRIVATE FUNCTIONS
      ///////////////////////////////////////////////////////////////////////////////////////////////
      
    private func validate() {
  
        if validateFields() {
            login()
        }
    }
    
    private func login() {
        
        let email = txtEmail.text?.trimmingCharacters(in: .whitespaces)
        let password = txtPassword.text?.trimmingCharacters(in: .whitespaces)
        let parameters = "email=\(email!)&password=\(password!)"
        viewModel.login(targetVC: self, parameters: parameters)
                        
    }
      
    private func validateFields()-> Bool {
        var validateEmail = false
        var validatePassword = false
          
        if Validations.validateText(value: txtEmail.text!) {
            if Validations.validateEmail(value: txtEmail.text!){
                  txtEmail.errorMessage = ""
                  validateEmail = true
              } else {
                  txtEmail.errorMessage = "Debe Ingresar un Email válido"
              }
              
        } else {
            txtEmail.errorMessage = "Debe Ingresar su Email"
        }
          
        if Validations.validateText(value: txtPassword.text!) {
            txtPassword.errorMessage = ""
            validatePassword = true
        } else {
            txtPassword.errorMessage = "Debe Ingresar su Contraseña"
        }
          
         
          
          if validatePassword && validateEmail  {
              return true
          } else {
              return false
          }
          
      }
    
    
    func getResponse(response: Response) {
        print("ResultView: \(response)")

        
        let success = response.success ?? false
        
        if success {
            if let user = response.user {
                setDataSession(user.email, key: "email")
//                Crashlytics.crashlytics().setUserID(getDataSession("email"))
            }
            
            setDataSession(response.token ?? "", key: "access_token")
            viewModel.goToMain()
        }
    }
    
    func getErrorResponse(error: NSString) {
        print("error: \(error)")
    }
      
      

}
