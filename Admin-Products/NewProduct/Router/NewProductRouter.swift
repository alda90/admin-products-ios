//
//  NewProductRouter.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit

class NewProductRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    

    var typeMode: TypeMode
    private var sourceView: UIViewController?
    
    init(typeMode: TypeMode = .register) {
        self.typeMode = typeMode
    }
    
    
    private func createViewController () -> UIViewController {
        let view = NewProductView(nibName: "NewProductView", bundle: Bundle.main)
        view.typeMode = self.typeMode
        return view
        
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard  let view  = sourceView else {
            fatalError("Error desconocido")
        }
        
        self.sourceView = view
    }
    
    func navigateToDetailProduct(product_id: String) {
        let detailProductView = DetailProductRouter(product_id: product_id).viewController
        sourceView?.navigationController?.pushViewController(detailProductView, animated: true)
    }
    
    func navigateToFiles(product_id: String, detail: [Detail], id: String, typeMode: TypeMode) {
        let fileView = FileRouter(product_id: product_id, detail: detail, id: id, typeMode: typeMode).viewController
        sourceView?.navigationController?.pushViewController(fileView, animated: true)
    }
    
    func presentCatalogo(catalog: [Catalog], tag: Int, parametro: String, titulo: String, delegate: catalogosProtocol) {
        let catalogoView = CatalogosRouter(catalog: catalog, tag: tag, parametro: parametro, titulo: titulo, delegate: delegate).viewController
        sourceView?.present(catalogoView, animated: true, completion: nil)
    }
    
    
}

