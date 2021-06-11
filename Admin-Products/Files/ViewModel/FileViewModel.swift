//
//  FileViewModel.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import Foundation
import UIKit

protocol fileViewModelProtocol {
    func getResponse(response: Response)
    func getErrorResponse(error:NSString)
}

class FileViewModel: apiCallsProtocol {
    private weak var view: FileView?
    private var router: FileRouter?
    private var apiCall = RestApiCalls()
    private var delegate: fileViewModelProtocol!
    
    func bind(view: FileView, router: FileRouter, delegate: fileViewModelProtocol) {
        self.view = view
        self.router = router
        self.delegate = delegate
        
        self.router?.setSourceView(view)
        apiCall.delegate = self
    }
    
    func getDetailProduct(targetVC: UIViewController, id: String) {
        apiCall.getDetailProduct(targetVC: targetVC, id: id)
    }
    
    func getResponse(response: Response) {
        delegate?.getResponse(response: response)
    }
    
    func getErrorResponse(error: NSString) {
        delegate?.getErrorResponse(error: error)
    }
    
    func goToUploadFile(product_id: String, detail_id: String, delegate: uploadFileProtocol, image: String = "") {
        router?.presentUploadFile(product_id: product_id, detail_id: detail_id, delegate: delegate, image: image)
    }
    
}
