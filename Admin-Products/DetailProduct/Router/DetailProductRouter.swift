//
//  DetailProductRouter.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit

class DetailProductRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    var product_id: String
    private var sourceView: UIViewController?
    
    init(product_id: String ) {
        self.product_id = product_id
    }
    
    
    private func createViewController () -> UIViewController {
        let view = DetailProductView(nibName: "DetailProductView", bundle: Bundle.main)
        view.product_id = self.product_id
        
        return view
        
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard  let view  = sourceView else {
            fatalError("Error desconocido")
        }
        
        self.sourceView = view
    }
    
    func navigateToFiles(product_id: String, detail: [Detail]) {
        let fileView = FileRouter(product_id: product_id, detail: detail).viewController
        sourceView?.navigationController?.pushViewController(fileView, animated: true)
    }
    
    func navigateToDetailProduct(product_id: String) {
        let detailProductView = DetailProductRouter(product_id: product_id).viewController
        sourceView?.navigationController?.pushViewController(detailProductView, animated: true)
    }
    
    func naviagateToMain() {
        let mainView = MainRouter().viewController
        sourceView?.navigationController?.pushViewController(mainView, animated: true)
    }
    
}
