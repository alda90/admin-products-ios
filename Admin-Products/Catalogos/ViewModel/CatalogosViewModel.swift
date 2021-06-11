//
//  CatalogosViewModel.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 10/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import Foundation
import UIKit

protocol  catalogosViewModelProtocol {
    func getResponse(response: Response)
    func getErrorResponse(error:NSString)
}

class CatalogosViewModel: apiCallsProtocol {
    private weak var view: CatalogosView?
    private var router: CatalogosRouter?
    private var apiCall =  RestApiCalls()
    private var delegate: catalogosViewModelProtocol!
    
    func bind(view: CatalogosView, router: CatalogosRouter, delegate: catalogosViewModelProtocol) {
        self.view = view
        self.router = router
        self.delegate = delegate
        
        self.router?.setSourceView(view)
        apiCall.delegate = self
    }
    
    func getResponse(response: Response) {
        delegate?.getResponse(response: response)
    }
    
    func getErrorResponse(error: NSString) {
        delegate?.getErrorResponse(error: error)
    }
}
