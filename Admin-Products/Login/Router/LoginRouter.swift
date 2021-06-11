//
//  LoginRouter.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 05/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import Foundation
import UIKit

class LoginRouter {
    
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    private func createViewController () -> UIViewController {
        let view = LoginView(nibName: "LoginView", bundle: Bundle.main)
        
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else  {
            fatalError("Unknow error")
        }
        
        self.sourceView = view
    }
    
    func navigateToMain() {
        let mainView = MainRouter().viewController
        
        let navController = UINavigationController(rootViewController: mainView)
        navController.modalPresentationStyle = .fullScreen
        sourceView?.present(navController, animated: true, completion: nil)
    }
}
