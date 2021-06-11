//
//  NewProductView.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 06/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit

class NewProductView: UIViewController, newProViewModelProtocol, catalogosProtocol, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var viewInicio: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAdjuntos: appCustomButton!
    @IBOutlet weak var btnActions: appCustomButton!
    
    private var viewModel = NewProductViewModel()
    private var router: NewProductRouter?
    private var validateTable = false
    private var valueTextFields: [Int: [String]] = [:]
    private var apiFunction = ""
    private var catalog: [Catalog] = [Catalog]()
    private var parameters: [Parameter] = [Parameter]()
    
    var typeMode: TypeMode = TypeMode.register
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        self.navigationController?.navigationBar.topItem?.title = " "

        
        router = NewProductRouter(typeMode: typeMode)
        viewModel.bind(view: self, router: router!, delegate: self)
        
        self.viewInicio.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NewProductView.hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIApplication.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIApplication.keyboardWillChangeFrameNotification, object: nil)
        
        self.tableView.register(UINib(nibName: "parameterText", bundle: nil), forCellReuseIdentifier: "cellParameterText")
        
        parameters.removeAll()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let title = "Nuevo Producto"
        
        getData()
        
        navigationItem.title = title
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.isFirstResponder {
            textField.keyboardType = .default
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        let name_parameter = self.parameters[textField.tag].name_parameter
        
               
        if name_parameter == "color" {
            self.viewModel.goToCatalogo(catalog: catalog, tag: textField.tag, parametro: "color_id", titulo: "Colores", delegate: self)
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let name_parameter = self.parameters[textField.tag].name_parameter
        
        if name_parameter == "color" {
            self.view.endEditing(true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.valueTextFields.updateValue([textField.text!, textField.text!], forKey: textField.tag)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let name_parameter = self.parameters[textField.tag].name_parameter
        
        if name_parameter == "model" {
            if range.location > 3 {
                textField.text?.removeLast()
            }
        }
        
        return true
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////   FUNCTIONS
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc func Keyboard(notification: Notification){
        let userInfo = notification.userInfo!
    
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
    
        if notification.name == UIApplication.keyboardWillHideNotification {
            tableView.contentInset = UIEdgeInsets.zero
        } else {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
    
        tableView.scrollIndicatorInsets = tableView.contentInset
    }

    private func getData() {
        
        if typeMode == .register {
            apiFunction = "PARAMETERS"

            viewModel.getParameters(targetVC: self, parameters: "")
            
        } else if typeMode == .update {
            //btnAdjuntos.isHidden = false
           
        }
        
       
    }
    
    func getSelection(result: String, data: String, tag: Int, parametro: String) {
        print("nada?? Result: \(result) data: \(data) -tag \(tag)")
        
        
        self.valueTextFields.updateValue([result,data], forKey: tag)

        tableView.reloadData()
    }
    
    private func setData() {
        if self.parameters.count > 0 {
            for i in 0 ... self.parameters.count-1 {
                if typeMode == .update {
                    
//                    let value = self.parameters[i].value
//                    let parameter = self.parameters[i].name_parameter
//                    let type = self.parameters[i].type
//
//
//                    if type > "int" {
//
//                        if parameter == "color" {
//                            let predicateColor: NSPredicate = NSPredicate(format: "SELF.id == \(value)")
//                            let color = NSMutableArray(array: arrayColors.filtered(using: predicateColor))
//                            data = (color[0] as AnyObject).value(forKey: "nombre") as? String ?? ""
//                        }
//
//
//
//                        self.valueTextFields.updateValue(["\(value)","\(data)"], forKey: i)
//
//                    } else {
//                        // self.valueTextFields.updateValue([], forKey: i)
//
//                        self.valueTextFields.updateValue(["\(value)","\(value)"], forKey: i)
//                    }
                } else {
                    self.valueTextFields.updateValue([], forKey: i)
                }
               
             }
         }
     }
    
    
    private func setArrayData(data: [Parameter]) {
        
        if data.count > 0 {
            
//            let params = NSMutableArray(array: data)
//
//            let predicate1 = NSPredicate(format: "SELF.is_file == false")
//            //let predicate2 = NSPredicate(format: "SELF.name_parameter <> %@", "color")
//
//            let predicateText: NSPredicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1] )
//            //let predicateFile: NSPredicate = NSPredicate(format: "SELF.is_file == 1")
//
//            let paramsArray = NSMutableArray(array: params.filtered(using: predicateText))

            
            self.parameters = data.filter { $0.is_file == false }
            
            apiFunction = "COLORES"
            self.viewModel.getColors(targetVC: self)
            
            
        } else {
            AlertErrorGral.alertWarning(targetVC: self, title: "Lo Sentimos", message: "No se encontraron datos.")
        }
        
    }

    private func validateFields() {
        var count: Int = 0
        var validado = true
        var cadParametros = ""
        var queryItems = [] as [URLQueryItem]
        
        
        for i in 0 ... self.parameters.count - 1 {
            
            if self.valueTextFields[i] != [] {
                
                let name_parameter = self.parameters[i].name_parameter
                let value = self.valueTextFields[i]!
                
                if !Validations.validateText(value: value[0]) {
                    validado = false
                }
                
                if name_parameter == "email" && !Validations.validateEmail(value: value[0]){
                    validado = false
                }
               
               
                if typeMode == .update {
                    queryItems.append(NSURLQueryItem(name: name_parameter, value: value[0]) as URLQueryItem)
                } else {
                    if cadParametros != "" {
                        cadParametros += "&"
                    }
                     cadParametros += "\(name_parameter)=\(value[0])"
                }
                
                count += 1
                
                print(cadParametros)
                
            } else {
                validado = false
                
                
            }
        }
        
        print("\(validado)")
     
        validateTable = true
        tableView.reloadData()
        
        if validado {
            if typeMode == .register {
                apiFunction = "CREATE_PRODUCT"
                viewModel.newProduct(targetVC: self, parameters: cadParametros)
            } else if typeMode == .update {
                apiFunction = "UPDATE"

            }

        }
        
    }
    
    func getResponse(response: Response) {
           print("ResultView: \(response)")
        
        let success = response.success ?? false
        
        if success {
            if apiFunction == "PARAMETERS" {
                setArrayData(data: response.parameters!)
             
            } else if apiFunction == "COLORES" {
                
                catalog = response.colors!
                self.setData()
                self.tableView.dataSource = self
                self.tableView.delegate = self
                self.tableView.reloadData()
                
            }  else if apiFunction == "CREATE_PRODUCT" {
                
                
                
                self.viewModel.goToDetailProduct(product_id: response.product_id!)
            }
        } else {
            AlertErrorGral.alertWarning(targetVC: self, title: "Lo Sentimos", message: "Se ha producido un error.")
        }
        
    }
       
    func getErrorResponse(error: NSString) {
        print("error: \(error)")
    }
    
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////   ACTIONS
        ///////////////////////////////////////////////////////////////////////////////////////////////
    
    
    @IBAction func actionRegistrar(_ sender: Any) {
         validateFields()
        
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
            return self.parameters.count
        }
            
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            
        }
        
            
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellParameterText", for: indexPath) as? CeldasGralesTableViewCell  else {
                fatalError("The dequeued cell is not an instance of RequisitoCell.")
            }
                
                
            if self.parameters.count > 0 {
                
                setCellValues(viewContent: cell.viewContentParamterText)
                
                cell.widthImgParameterText.constant = 0.0
                cell.txtParameterText.delegate = self
                cell.txtParameterText.placeholder = self.parameters[indexPath.row].name
                cell.txtParameterText.title = self.parameters[indexPath.row].name
                //cell.lblObservacionesText.text = (requisitosTextArray[indexPath.row] as AnyObject).value(forKey: "observaciones") as? String ?? ""
                
                let name_parameter = self.parameters[indexPath.row].name_parameter
 
                cell.txtParameterText.tag = indexPath.row
                
                if name_parameter.contains("telefono") {
                    cell.txtParameterText.keyboardType = .numberPad
                    cell.txtParameterText?.addDoneToolbar()
                }
                
                if self.valueTextFields[indexPath.row] != [] {
                    let data = self.valueTextFields[indexPath.row]
                    
                    cell.txtParameterText.text = data![1]
                    
                    if validateTable {
                        cell.txtParameterText.errorMessage = ""
                    }
                    
                    if !Validations.validateText(value: data![1]) {
                        cell.txtParameterText.errorMessage = "Debe ingresar este campo"
                    }
                    
                    if name_parameter == "email" && !Validations.validateEmail(value: data![1]) {
                        cell.txtParameterText.errorMessage = "Debe ingresar un email válido"
                    }
                    
                    
                } else {
                    cell.txtParameterText.text = ""
                    if validateTable {
                        cell.txtParameterText.errorMessage = "Debe ingresar este campo"
                    }
                }
             
//                }

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
