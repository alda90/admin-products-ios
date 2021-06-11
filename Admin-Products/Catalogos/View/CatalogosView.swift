//
//  CatalogosView.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 10/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit

protocol catalogosProtocol {
    func getSelection(result: String, data: String, tag: Int, parametro: String)
}

class CatalogosView: UIViewController, catalogosViewModelProtocol, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    
    private var viewModel = CatalogosViewModel()
    private var router: CatalogosRouter?
    
    
    var delegate: catalogosProtocol!
    var catalog: [Catalog] = [Catalog]()
    var tag: Int = 0
    var parametro: String = ""
    var titulo: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        router = CatalogosRouter(catalog: catalog, tag: tag, parametro: parametro, titulo: titulo, delegate: delegate)
        viewModel.bind(view: self, router: router!, delegate: self)
        
        self.tableView.register(UINib(nibName: "catalogo", bundle: nil), forCellReuseIdentifier: "cellCatalogo")
        
        
        navItem.title = titulo
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        
        print(catalog)
    }


    func getResponse(response: Response) {
        print("ResultView: \(response)")
    }
    
    func getErrorResponse(error: NSString) {
        print("error: \(error)")
    }
   
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////   UITABLE VIEW
    ///////////////////////////////////////////////////////////////////////////////////////////////
           
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
            
            
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
            
           
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalog.count
    }
            
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = catalog[indexPath.row].id
        let name = catalog[indexPath.row].name

        self.delegate.getSelection(result: id, data: name, tag: tag, parametro: parametro)
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
        
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellCatalogo", for: indexPath) as? CeldasGralesTableViewCell  else {
            fatalError("The dequeued cell is not an instance of RequisitoCell.")
        }
                    
                    
        if catalog.count > 0 {
            cell.lblCatalogo.text = catalog[indexPath.row].name
            
            if parametro == "color_id" {
                let code = catalog[indexPath.row].code
                let color = hexStringToUIColor(hex: code!)
                
                cell.viewCatalogo.layer.cornerRadius = cell.viewCatalogo.frame.size.height/2
                cell.viewCatalogo.layer.backgroundColor = color.cgColor
                cell.viewCatalogo.layer.borderWidth = 1.0
                cell.viewCatalogo.layer.borderColor = UIColor.lightGray.cgColor
                
            }
                
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        
        return cell
                
    }

}
