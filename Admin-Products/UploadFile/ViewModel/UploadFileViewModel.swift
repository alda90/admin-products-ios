//
//  UploadFileViewModel.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import Foundation
import UIKit

protocol uploadFileViewModelProtocol {
    func getResponse(response: Response)
    func getErrorResponse(error:NSString)
}

class UploadFileViewModel: apiCallsProtocol {
    private weak var view: UploadFileView?
    private var router: UploadFileRouter?
    private var apiCall = RestApiCalls()
    private var delegate: uploadFileViewModelProtocol!
    
    func bind(view: UploadFileView, router: UploadFileRouter, delegate: uploadFileViewModelProtocol) {
        self.view = view
        self.router = router
        self.delegate = delegate
        
        self.router?.setSourceView(view)
        apiCall.delegate = self
    }
    
    func uploadFile(targetVC: UIViewController, file_parameter: String, imageData: Data ) {
        apiCall.uploadImage(targetVC: targetVC, file_parameter: file_parameter, imageData: imageData)
    }
    
    func saveImageProduct(targetVC: UIViewController, parameters: String) {
        apiCall.saveImageProduct(targetVC: targetVC, parameters: parameters)
    }
 
    
    func getResponse(response: Response) {
        delegate?.getResponse(response: response)
    }
    
    func getErrorResponse(error: NSString) {
        delegate?.getErrorResponse(error: error)
    }
    
    
}
