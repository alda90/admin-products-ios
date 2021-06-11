//
//  LoginViewModel.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 11/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import Foundation
import UIKit

protocol  loginViewModelProtocol {
    func getResponse(response: Response)
    func getErrorResponse(error:NSString)
}

class LoginViewModel: apiCallsProtocol {
    
    
    private weak var view: LoginView?
    private var router: LoginRouter?
    private var apiCall = RestApiCalls()
    private var delegate: loginViewModelProtocol!
    
    
    func bind(view: LoginView, router: LoginRouter, delegate: loginViewModelProtocol) {
        self.view = view
        self.router = router
        self.delegate = delegate
        //bind router with the view
        self.router?.setSourceView(view)
        apiCall.delegate = self
    }
    
    func login(targetVC: UIViewController, parameters: String) {
        apiCall.login(targetVC: targetVC, parameters: parameters)
    }
    
    
    func getResponse(response: Response) {
        delegate?.getResponse(response: response)
    }
    
    
    func getErrorResponse(error: NSString) {
        delegate?.getErrorResponse(error: error)
    }
    
    
    func goToMain() {
        router?.navigateToMain()
    }
    
}
