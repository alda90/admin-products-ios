//
//  MainViewModel.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 06/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import Foundation
import UIKit

protocol  mainViewModelProtocol {
    func getResponse(response: Response)
    func getErrorResponse(error:NSString)
}

class MainViewModel: apiCallsProtocol {
    
    private weak var view: MainView?
    private var router: MainRouter?
    private var apiCall = RestApiCalls()
    private var delegate: mainViewModelProtocol!
    
    
    func bind(view: MainView, router: MainRouter, delegate: mainViewModelProtocol) {
        self.view = view
        self.router = router
        self.delegate = delegate
        //bind router with the view
        self.router?.setSourceView(view)
        apiCall.delegate = self
    }
    
    func isFetching() -> Bool {
        return apiCall.fetching
    }
    
    func getProducts(targetVC: UIViewController, q: String) {
        apiCall.getProducts(targetVC: targetVC, q: q)
    }
    
    func logOut(targetVC: UIViewController) {
        apiCall.logout(targetVC: targetVC)
    }
    
    
    func getResponse(response: Response) {
        delegate?.getResponse(response: response)
    }
    
    func getErrorResponse(error: NSString) {
        delegate?.getErrorResponse(error: error)
    }
    
    
    func goToNewProduct() {
        router?.navigateToNewProduct()
    }
    
    func goToUpdateProduct(id: String, typeMode: TypeMode) {
        router?.navigateToUpdateProduct(typeMode: typeMode)
    }
    
    func goToDetailProduct(product_id: String) {
        router?.navigateToDetailProduct(product_id: product_id)
    }
    
    func goToLogin() {
        router?.navigateToLogin()
    }
}
