//
//  CatalogosRouter.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 10/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit

class CatalogosRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    var catalog: [Catalog]
    var tag: Int
    var parametro: String
    var titulo: String
    var delegate: catalogosProtocol!
    private var sourceView: UIViewController?
    
    init(catalog: [Catalog] ,tag: Int, parametro: String, titulo: String, delegate: catalogosProtocol) {
        self.catalog = catalog
        self.tag = tag
        self.parametro = parametro
        self.titulo = titulo
        self.delegate = delegate
    }
    
    
    private func createViewController () -> UIViewController {
        let view = CatalogosView(nibName: "CatalogosView", bundle: Bundle.main)
        view.catalog = self.catalog
        view.tag = self.tag
        view.parametro = self.parametro
        view.titulo = self.titulo
        view.delegate = self.delegate
        return view
        
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard  let view  = sourceView else {
            fatalError("Error desconocido")
        }
        
        self.sourceView = view
    }
    
    
}
