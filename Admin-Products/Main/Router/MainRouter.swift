//
//  MainRouter.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 06/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import Foundation
import UIKit

class MainRouter {
    
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    private func createViewController () -> UIViewController {
        let view = MainView(nibName: "MainView", bundle: Bundle.main)
        
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else  {
            fatalError("Unknow error")
        }
        
        self.sourceView = view
    }
    
    func navigateToNewProduct() {
        let newProductView = NewProductRouter().viewController
        sourceView?.navigationController?.pushViewController(newProductView, animated: true)
    }
    
    func navigateToUpdateProduct(typeMode: TypeMode) {
        let detailProductView = NewProductRouter(typeMode: typeMode).viewController
        sourceView?.navigationController?.pushViewController(detailProductView, animated: true)
    }
    
    func navigateToDetailProduct(product_id: String) {
        let detailProductView = DetailProductRouter(product_id: product_id).viewController
        sourceView?.navigationController?.pushViewController(detailProductView, animated: true)
        
    }
    
    func navigateToLogin() {
        let loginView = LoginRouter().viewController
        loginView.modalPresentationStyle = .fullScreen
        
        sourceView?.present(loginView, animated: true, completion: nil)
    }

}
