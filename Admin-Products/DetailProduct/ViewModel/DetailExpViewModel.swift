//
//  DetailProViewModel.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import Foundation
import UIKit

protocol detailProViewModelProtocol {
    func getResponse(response: Response)
    func getErrorResponse(error:NSString)
}

class DetailProViewModel: apiCallsProtocol {
    private weak var view: DetailProductView?
    private var router: DetailProductRouter?
    private var apiCall = RestApiCalls()
    private var delegate: detailProViewModelProtocol!
    
    func bind(view: DetailProductView, router: DetailProductRouter, delegate: detailProViewModelProtocol) {
        self.view = view
        self.router = router
        self.delegate = delegate
        
        self.router?.setSourceView(view)
        apiCall.delegate = self
    }
    
    func getDetailProduct(targetVC: UIViewController, id: String) {
        apiCall.getDetailProduct(targetVC: targetVC, id: id)
    }
    
    ///////////// CATALOGS
       
    func getColors(targetVC: UIViewController) {
        apiCall.getColors(targetVC: targetVC)
    }
    
    ///////// NAVIGATIONS
    
    
    func goToFiles(product_id: String, detail: [Detail]) {
        router?.navigateToFiles(product_id: product_id, detail: detail)
    }
    
    func goToDetailProduct(product_id: String) {
        router?.navigateToDetailProduct(product_id: product_id)
    }
    
    func toToMain() {
        router?.naviagateToMain()
    }
    
    //////////   RESPONSES
    
    func getResponse(response: Response) {
        delegate?.getResponse(response: response)
    }
    
    func getErrorResponse(error: NSString) {
        delegate?.getErrorResponse(error: error)
    }
}
