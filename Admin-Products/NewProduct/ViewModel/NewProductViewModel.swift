//
//  NewProductViewModel.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 06/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import Foundation
import UIKit

protocol  newProViewModelProtocol {
    func getResponse(response: Response)
    func getErrorResponse(error:NSString)
}

class NewProductViewModel: apiCallsProtocol {
    private weak var view: NewProductView?
    private var router: NewProductRouter?
    private var apiCall = RestApiCalls()
    private var delegate: newProViewModelProtocol!
    
    func bind(view: NewProductView, router: NewProductRouter, delegate: newProViewModelProtocol) {
        self.view = view
        self.router = router
        self.delegate = delegate
        
        //bind router with the view
        self.router?.setSourceView(view)
        apiCall.delegate = self
    }
    
    func getParameters(targetVC: UIViewController, parameters: String) {
       
        apiCall.getParameters(targetVC: targetVC, parameters: parameters)
    }
    
    func newProduct(targetVC: UIViewController, parameters: String) {
        apiCall.newProduct(targetVC: targetVC, parameters: parameters)
    }
    
    func getDetailProduct(targetVC: UIViewController, id: String){
        apiCall.getDetailProduct(targetVC: targetVC, id: id)
    }
    
    ///////////// CATALOGOS
    
    func getColors(targetVC: UIViewController) {
        apiCall.getColors(targetVC: targetVC)
    }
    
    ///////////// RESPONSE
    
    func getResponse(response: Response) {
        delegate?.getResponse(response: response)
    }
    
    func getErrorResponse(error: NSString) {
        delegate?.getErrorResponse(error: error)
    }
    
    
    ///////////// NAVIGATION
    func goToDetailProduct(product_id: String) {
        router?.navigateToDetailProduct(product_id: product_id)
    }
    
    func goToCatalogo(catalog: [Catalog], tag: Int, parametro: String, titulo: String, delegate: catalogosProtocol) {
        router?.presentCatalogo(catalog: catalog, tag: tag, parametro: parametro, titulo: titulo, delegate: delegate)
    }
    
    func goToFiles(product_id: String, detail: [Detail], id: String, typeMode: TypeMode) {
        router?.navigateToFiles(product_id: product_id, detail: detail, id: id, typeMode: typeMode)
    }
}
