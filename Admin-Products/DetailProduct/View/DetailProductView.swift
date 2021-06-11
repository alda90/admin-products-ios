//
//  DetailProductView.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit



class DetailProductView: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, detailProViewModelProtocol {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnValidate: appCustomButton!
    @IBOutlet weak var btnArchivosAdjuntos: appCustomButton!
    
    
    private var viewModel = DetailProViewModel()
    private var router:  DetailProductRouter?
    //private var requisitosTextArray: NSMutableArray = NSMutableArray()
    private var requisitosFileArray: NSMutableArray = NSMutableArray()
    private var catalog: [Catalog] = [Catalog]()
    private var detail: [Detail] = [Detail]()
    private var valueTextFields: [Int: [String]] = [:]
    private var apiFunction = ""
    private var validado = 0
    
    var product_id: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationItem.setHidesBackButton(true, animated: true)
        
//        let btnDelete = UIBarButtonItem(image: UIImage(named: "iconDelete"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(DetailProductView.alertDelete(_:)))
//         self.navigationItem.setRightBarButtonItems([btnDelete], animated: true)
        
        router = DetailProductRouter(product_id: product_id!)
        viewModel.bind(view: self, router: router!, delegate: self)
        self.tableView.register(UINib(nibName: "parameterText", bundle: nil), forCellReuseIdentifier: "cellParameterText")

        
        detail.removeAll()

        getDetail()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let title = "Detalle del Producto"
      
        navigationItem.title =  title
    }
    
    private func getDetail () {
        
        apiFunction = "DETAIL"
        viewModel.getDetailProduct(targetVC: self, id: product_id!)
        
    }
    
    
    @IBAction func actionArchivosAdjuntos(_ sender: Any) {
        viewModel.goToFiles(product_id: product_id!, detail: self.detail)
    }
    
    
    @IBAction func actionValidate(_ sender: Any) {

        self.viewModel.toToMain()
        //AlertErrorGral.alertSuccess(targetVC: self, title: "¡Éxito!", message: "Se ha registrado un producto exitosamente.")
    }
    
    

    func getResponse(response: Response) {
        print("ResultView: \(response)")
        
        let success = response.success ?? false
        
        if success {
            if apiFunction == "DETAIL" {
                
                if validado == 1 {
                   
                    btnValidate.isHidden = true
                    btnArchivosAdjuntos.isEnabled = false
                    btnArchivosAdjuntos.setTitleColor(UIColor.darkGray, for: .normal)
                }

                setArrayData(datos: response.detail!)
                
            } else if apiFunction == "COLORES" {
                
                catalog = response.colors!
                self.setData()
                self.tableView.dataSource = self
                self.tableView.delegate = self
                self.tableView.reloadData()
            }

        } else {
            AlertErrorGral.alertWarning(targetVC: self, title: "Lo Sentimos", message: "Se ha producido un error.")
        }
    
    
    }
   
   func getErrorResponse(error: NSString) {
       print("error Detail : \(error)")
 
   }
    
    @objc func alertDelete(_ sender: Any) {
        let alertController = UIAlertController(title: "¡Atención!", message: "¿Esta seguro de eliminar el producto?", preferredStyle: UIAlertController.Style.alert)
        alertController.view.tintColor = UIColor(named: "colorPrincipal")
        
        
        let alertDelete = UIAlertAction(title: "Eliminar", style: .destructive) { action in
            
            self.apiFunction = "DELETE"
        }
        
     
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        
       
        
        alertController.addAction(alertDelete)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    

    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////   PRIVATE FUNCTIONS
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    private func setData() {
        if detail.count > 0 {
            for i in 0 ... detail.count-1 {
                
                let value = self.detail[i].value
                let name_parameter = self.detail[i].parameter!.name_parameter
                let type = self.detail[i].parameter!.type
                
                var data = "\(value)"
                
                
                if type == "int" {
                    
                    if name_parameter == "color" {
                        
                        let color = catalog.filter { $0.id == value }
                        data = color[0].name
                    }
                    
                }
                
                
                self.valueTextFields.updateValue(["\(value)","\(data)"], forKey: i)
                
                
            }
        }
    }
    
    private func setArrayData(datos: [Detail]) {
        
        if datos.count > 0 {
//            let requisitos = NSMutableArray(array: datos)
//            let predicateText: NSPredicate = NSPredicate(format: "SELF.es_archivo == 0")
//            let predicateFile: NSPredicate = NSPredicate(format: "SELF.es_archivo == 1")
//
//            requisitosTextArray = NSMutableArray(array: requisitos.filtered(using: predicateText))
//            requisitosFileArray = NSMutableArray(array: requisitos.filtered(using: predicateFile))
            
            //showContentsRequisitos()
            
            self.detail = datos.filter { $0.parameter!.is_file == false }
            
            apiFunction = "COLORES"
            self.viewModel.getColors(targetVC: self)
            
        } else {
            AlertErrorGral.alertWarning(targetVC: self, title: "Lo Sentimos", message: "No se encontraron datos.")
        }
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
            return detail.count
        }
            
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            
        }
        
            
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellParameterText", for: indexPath) as? CeldasGralesTableViewCell  else {
               fatalError("The dequeued cell is not an instance of RequisitoCell.")
           }
               
               
           if detail.count > 0 {
               
               //setCellValues(viewContent: cell.viewContentRequisitosText)
            cell.widthImgParameterText.constant = 0.0
            
            cell.txtParameterText.delegate = self
            cell.txtParameterText.placeholder = detail[indexPath.row].parameter?.name
            cell.txtParameterText.title = detail[indexPath.row].parameter?.name
            //cell.lblObservacionesText.text = (requisitosTextArray[indexPath.row] as AnyObject).value(forKey: "observaciones") as? String ?? ""
               
          
               
            cell.txtParameterText.tag = indexPath.row
               
            if self.valueTextFields[indexPath.row] != [] {
                let data = self.valueTextFields[indexPath.row]
                cell.txtParameterText.text = data![1]
              
            } else {
                cell.txtParameterText.text = ""
                
            }
               
            
            cell.viewContentParamterText.isUserInteractionEnabled = false

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
   

}
