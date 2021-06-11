//
//  FileView.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit

class FileView: UIViewController,  UITableViewDelegate, UITableViewDataSource, fileViewModelProtocol, uploadFileProtocol {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = FileViewModel()
    private var router: FileRouter?
    private var apiFunction = ""
    private var btnsRequisitosState: [Int: Bool] = [:]
    
    var detail: [Detail]?
    var product_id: String?
    var detail_id: String?
    var typeMode: TypeMode = TypeMode.register

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = " "
        
        router = FileRouter(product_id: product_id!, detail: detail!, typeMode: typeMode)
        viewModel.bind(view: self, router: router!, delegate: self)
        
        print("Id Pro File \(product_id!)")
        self.tableView.register(UINib(nibName: "parameterFile", bundle: nil), forCellReuseIdentifier: "cellParameterFile")
        //setDataFile()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = "Archivos Adjuntos"
        getDetail()
    }
    
    private func getDetail() {
        if typeMode == .register {
            apiFunction = "DETAIL"
            viewModel.getDetailProduct(targetVC: self, id: product_id!)
        } else {
            apiFunction = "DETAIL UPDATE"
        
        }
        
    }
    
    private func setArrayData(result: [Detail]){
        
        if result.count > 0 {

            
            self.detail = result.filter { $0.parameter!.is_file == true }
                                              
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.reloadData()
                   
        } else {
            AlertErrorGral.alertWarning(targetVC: self, title: "Lo Sentimos", message: "No se encontraron datos.")
        }
    }
    
    func getResponse(response: Response) {
        print("ResultView: \(response)")
        if apiFunction == "DETAIL" || apiFunction == "DETAIL UPDATE" {
            setArrayData(result: response.detail!)
        }
    
    }
   
   func getErrorResponse(error: NSString) {
       print("error: \(error)")
   }
    
    func getUploadFileResponse(response: Response) {
        
        let success = response.success ?? false
        
        if success {
            getDetail()
        } else {
            AlertErrorGral.alertWarning(targetVC: self, title: "Lo Sentimos", message: "No se pudo subir la imagen.")
        }
        
    }
    
    
    private func setDataFile() {
//        if self.requisitosFileArray.count > 0 {
//            for i in 0 ... requisitosFileArray.count - 1 {
//                let rechazado = (requisitosFileArray[i] as AnyObject).value(forKey: "rechazado") as? Int ?? 0
//                let validado = (requisitosFileArray[i] as AnyObject).value(forKey: "validado") as? Int ?? 0
//                let valor = (requisitosFileArray[i] as AnyObject).value(forKey: "valor") as? String ?? ""
//
//                if rechazado == 1{
//                    btnsRequisitosState.updateValue(true, forKey: i)
//                } else if validado == 1 {
//                    btnsRequisitosState.updateValue(false, forKey: i)
//                } else if valor == "" {
//                    btnsRequisitosState.updateValue(true, forKey: i)
//                } else {
//                    btnsRequisitosState.updateValue(false, forKey: i)
//                }
//            }
//        }
    }
    
    @objc func goUploadFile(sender: UIButton) {
        print("The user wants to buy feature \(sender.tag)")
        
        let detail_id = self.detail![sender.tag].id
        
        let valor = self.detail![sender.tag].value
        
        viewModel.goToUploadFile(product_id: product_id!, detail_id: detail_id, delegate: self, image: valor )
        
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
            return self.detail!.count
        }
            
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            
        }
        
            
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellParameterFile", for: indexPath) as? CeldasGralesTableViewCell  else {
                            fatalError("The dequeued cell is not an instance of RequisitoCell.")
                        }
                            
                            
            if self.detail!.count > 0 {
                setCellValues(viewContent: cell.viewContentParameterFile)
                cell.lblParameterFile.text = self.detail![indexPath.row].parameter?.name
                cell.lblObservacionesFile.text = ""
                            
                            if let isEnabled = btnsRequisitosState[indexPath.row] {
                                cell.btnParameterFile.isEnabled = isEnabled
                                cell.btnParameterFile.isHidden = !isEnabled
                                cell.btnParameterFile.setTitle("Archivo", for: .normal)
                            
                            }
                            
                            
                            cell.btnParameterFile.tag = indexPath.row
                            cell.btnParameterFile.addTarget(self, action: #selector(FileView.goUploadFile(sender:)), for: .touchUpInside)
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
