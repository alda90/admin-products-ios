//
//  UploadFileRouter.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit

class UploadFileRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    var product_id: String
    var detail_id: String
    var image: String
    var delegate: uploadFileProtocol!
    private var sourceView: UIViewController?
    
    init(product_id: String, detail_id: String, delegate: uploadFileProtocol, image: String = "") {
        self.product_id = product_id
        self.detail_id = detail_id
        self.image = image
        self.delegate = delegate
    }
    
    
    private func createViewController () -> UIViewController {
        let view = UploadFileView(nibName: "UploadFileView", bundle: Bundle.main)
        view.product_id = self.product_id
        view.detail_id = self.detail_id
        view.delegate = self.delegate
        view.image = self.image
        return view
        
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard  let view  = sourceView else {
            fatalError("Error desconocido")
        }
        
        self.sourceView = view
    }
    
    
}
