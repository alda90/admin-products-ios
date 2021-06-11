//
//  FileRouter.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit

class FileRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    var product_id: String
    var detail: [Detail]
    var id: String
    var typeMode: TypeMode
    private var sourceView: UIViewController?
    
    init(product_id: String, detail: [Detail], id: String = "", typeMode: TypeMode = .register) {
        self.product_id = product_id
        self.detail = detail
        self.id = id
        self.typeMode = typeMode
    }
    
    
    private func createViewController () -> UIViewController {
        let view = FileView(nibName: "FileView", bundle: Bundle.main)
        view.product_id = self.product_id
        view.detail = self.detail
        view.detail_id = self.id
        view.typeMode = self.typeMode
        return view
        
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard  let view  = sourceView else {
            fatalError("Error desconocido")
        }
        
        self.sourceView = view
    }
    
    func presentUploadFile(product_id: String, detail_id: String, delegate: uploadFileProtocol, image: String = "") {
        let uploadFileView = UploadFileRouter(product_id: product_id, detail_id: detail_id, delegate: delegate, image: image).viewController
        sourceView?.present(uploadFileView, animated: true, completion: nil)
    }
    
    
}

