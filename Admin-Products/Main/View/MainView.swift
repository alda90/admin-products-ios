//
//  MainView.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 06/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit
import JJFloatingActionButton
//import Firebase

class MainView: UIViewController, mainViewModelProtocol, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private var viewModel = MainViewModel()
    fileprivate let actionButton = JJFloatingActionButton()
    private var router = MainRouter()
    private var products: [Product] = [Product]()
    private var apiFunction = ""
    private var query = ""
    
//    private var page = 1
//    private var last_page = 0
    
    private let searchBar = UISearchBar()
    private let searchController = UISearchController(searchResultsController: nil)

    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ////////////////////////////////////////////  VIEW CONTROLLER
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.searchController = nil
        
        let btnLogout = UIBarButtonItem(image: UIImage(named: "iconLogOut"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(MainView.alertLogout(_:)))
        self.navigationItem.setRightBarButtonItems([btnLogout], animated: true)

        createSearchBar()
        
        actionButton.buttonColor = UIColor(named: "colorPrincipal")!
        actionButton.addItem(title: "Nuevo", image:  UIImage(named: "iconNew")!) { item in
            self.viewModel.goToNewProduct()
        }

        actionButton.display(inViewController: self)
        viewModel.bind(view: self, router: router, delegate: self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = nombreApp
        if query != "" {
            products.removeAll()
            searchData()
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        actionButton.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          
        self.apiFunction = "PRODUCTS"
        query = searchBar.text ?? ""
        //page = 1
        products.removeAll()
        searchData()
        
    }
       
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        query = ""
        actionButton.isHidden = false
        products.removeAll()
        setTableView()
    }
    
    
    
    @IBAction func actionSegmentedCtrl(_ sender: Any) {
        
        //page = 1
        products.removeAll()
        searchData()
    }
    
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ////////////////////////////////////////////  PRIVATE FUNCTIONS
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    private func hiddenSearchController() {
        navigationItem.searchController = nil
    }
    
    private  func createSearchBar(){
           
        self.definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.placeholder = "Buscar ..."
        searchController.searchBar.barTintColor = UIColor.white
        searchController.searchBar.barStyle = .black
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
           
    }
    
    private func searchData() {
        
        let q = query.trimmingCharacters(in: .whitespaces)
        
        if Validations.validateText(value: q) {
//            let queryItems = [
//                NSURLQueryItem(name: "q", value: q),
//                NSURLQueryItem(name: "page", value: String(page))
//                ] as [URLQueryItem]
            
            apiFunction = "PRODUCTS" 
            self.viewModel.getProducts(targetVC: self, q: q)
            
        }
        
        
    }
   
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////// FUNCTIONS
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    @objc func alertLogout(_ sender: Any) {
        
        let alertController = UIAlertController(title: "¡Atención!", message: "¿Esta seguro de cerrar Sesión?", preferredStyle: UIAlertController.Style.alert)
        //alertController.view.tintColor = UIColor(named: "colorPrincipal")
        
        let alertDelete = UIAlertAction(title: "Cerrar Sesión", style: .destructive) { action in
            
            self.apiFunction = "LOGOUT"
            self.viewModel.logOut(targetVC: self)
        }
        
     
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        
       
        alertController.addAction(alertDelete)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //////////////////////////////////////////// API REST
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       
   
    
    func getResponse(response: Response) {
        print("ResultView: \(response)")
        
        let success = response.success ?? false
        
        //                    let meta = result.value(forKey: "meta") as! NSDictionary
        //                    self.last_page = meta.value(forKey: "last_page") as? Int ?? 0
        //                    let total = meta.value(forKey: "total") as? Int ?? 0
        //
        //                    if productsArray.count != total || self.page == 1 {
        //                        productsArray.addObjects(from: data as! [Any])
        //                        setTableView()
        //                    }
        
        if apiFunction == "LOGOUT" {
            if success {
                deleteDataSession("access_token")
                viewModel.goToLogin()
            } else {
                AlertErrorGral.alertWarning(targetVC: self, title: "Lo Sentimos", message: "No se pudo cerrar sesion.")
            }
            
        } else if apiFunction == "PRODUCTS" {
            
            if success {
                self.products = response.products!
                setTableView()
            } else {
                self.products.removeAll()
                setTableView()
                AlertErrorGral.alertWarning(targetVC: self, title: "Lo Sentimos", message: "No se encontraron datos.")
            }
        }
        
    }
       
       func getErrorResponse(error: NSString) {
           print("error: \(error)")
        //self.tableView.tableFooterView = nil
       }

    
    ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////   UITABLE VIEW
            ///////////////////////////////////////////////////////////////////////////////////////////////
    
    private func setTableView(){
        

        
        self.tableView.register(UINib(nibName: "product", bundle: nil), forCellReuseIdentifier: "cellProduct")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
    }
               
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
                
                
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
                
               
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
                
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let id = products[indexPath.row].id
        
        self.viewModel.goToDetailProduct(product_id: id)
    }
            
                
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellProduct", for: indexPath) as? CeldasGralesTableViewCell  else {
            fatalError("The dequeued cell is not an instance of RequisitoCell.")
        }
            
            
        if products.count > 0 {
            
            setCellValues(viewContent: cell.viewContentProducts)
            
            cell.lblNombreParametro.text = "Producto"
            cell.lblParametro.text = products[indexPath.row].value
            
        }
           
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell
                    
    }
            

    private func setCellValues(viewContent: UIView) {
        viewContent.layer.masksToBounds = false
        viewContent.layer.shadowColor = UIColor.black.cgColor
        viewContent.layer.shadowOpacity = 0.5
        viewContent.layer.shadowOffset = CGSize(width: 0, height: 1)
        viewContent.layer.shadowRadius = 3
    }
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////   PAGINATION
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height ){
            print("Fetch more")
            if !viewModel.isFetching() {
                
//                if self.last_page > self.page {
//                    self.page += 1
//                    searchData()
//                }
            }
        }
    }
    
    
    private func createSpinnerFooter () -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }

}
