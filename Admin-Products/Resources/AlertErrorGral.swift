//
//  AlertErrorGral.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 06/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//



import Foundation
import UIKit

class AlertErrorGral {
    
    class func alertErrorConexion(targetVC: UIViewController) {
        let alertController = AlertController(title: "Error de Conexión", message: "Encienda las Redes WiFi o de Datos.", preferredStyle: .alert)
        alertController.view.tintColor = UIColor(named: "colorPrincipalDark")
        alertController.setTitleImage(UIImage(named: "iconErrorConexion"))
        
        // Create the actions
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            if let url = URL(string:UIApplication.openSettingsURLString)
            {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        
        
        // Add the actions
        alertController.addAction(okAction)
        
        
        // Present the controller
        targetVC.present(alertController, animated: true, completion: nil)
    }
    
    class func alertErrorInternet(targetVC: UIViewController) {
        let alertController = AlertController(title: "Error de Red", message: "Verifique su conexión a Internet.", preferredStyle: .alert)
        alertController.view.tintColor =  UIColor(named: "colorPrincipalDark")
        alertController.setTitleImage(UIImage(named: "iconErrorInternet"))
        
        // Create the actions
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        
        
        
        // Add the actions
        alertController.addAction(okAction)
        
        
        // Present the controller
        targetVC.present(alertController, animated: true, completion: nil)
    }
    
    class func alertErrorTimedOut(targetVC: UIViewController) {
        let alertController = AlertController(title: "Lo Sentimos", message: "Hay problemas con la conexión a internet. Intente de nuevo.", preferredStyle: .alert)
        alertController.view.tintColor =  UIColor(named: "colorPrincipalDark")
        alertController.setTitleImage(UIImage(named: "iconErrorInternet"))
        
        // Create the actions
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        
        
        
        // Add the actions
        alertController.addAction(okAction)
        
        
        // Present the controller
        targetVC.present(alertController, animated: true, completion: nil)
    }
    
    class func alertErrorServer(targetVC: UIViewController) {
        let alertController = AlertController(title: "Lo Sentimos", message: "El Servidor está en mantenimiento. Intente más tarde.", preferredStyle: .alert)
        alertController.view.tintColor =  UIColor(named: "colorPrincipalDark")
        alertController.setTitleImage(UIImage(named: "iconErrorServer"))
        
        // Create the actions
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        
        
        
        // Add the actions
        alertController.addAction(okAction)
        
        
        // Present the controller
        targetVC.present(alertController, animated: true, completion: nil)
    }
    
    class func alertErrorLocation(targetVC: UIViewController) {
        let alertController = AlertController(title: "Atención", message: "Encienda sus servicios de ubicación para mostrarle los restaurantes que se encuentran cerca de usted.", preferredStyle: .alert)
        alertController.view.tintColor = UIColor(named: "colorPrincipalDark")
        alertController.setTitleImage(UIImage(named: "iconErrorConexion"))
        
        // Create the actions
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            if let url = URL(string:UIApplication.openSettingsURLString)
            {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        
        
        // Add the actions
        alertController.addAction(okAction)
        
        
        // Present the controller
        targetVC.present(alertController, animated: true, completion: nil)
    }
    
    
    class func AlertNoDATOS(targetView: UIView, imgView: UIImageView, lbl: UILabel, msg: String){
        let backgroundImage = UIImage(named: "iconInbox")
        imgView.image = backgroundImage
        imgView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        imgView.center = CGPoint(x: targetView.center.x, y: 200)
        //imageView1.center = CGPoint(x: 160, y: 240)
        targetView.addSubview(imgView)
        
        lbl.frame = CGRect(x: 0, y: 0, width: 300, height: 21)
        lbl.center = CGPoint(x: targetView.center.x, y: 245)
        lbl.textAlignment = .center
        lbl.text = msg
        lbl.textColor =  UIColor(named: "colorPrincipalDark")
        targetView.addSubview(lbl)
    }
    
  
    
    class func DeleteAlertEventos(lbl: UILabel, img: UIImageView) {
        lbl.removeFromSuperview()
        img.removeFromSuperview()
    }
    
//    class func ShowLoading(targetView: UIView, loadView: UIView, loadImgView: UIImageView, y: CGFloat ){
//        let screenSize: CGRect = UIScreen.main.bounds
//        loadView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
//        loadView.backgroundColor = UIColor.black.withAlphaComponent(0.55)
//        //let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
//        //myView.backgroundColor = UIColor.black.withAlphaComponent(0.55)
//
//        targetView.addSubview(loadView)
//
//
//        loadImgView.loadGif(name: "logoGobierno")
//        loadImgView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
//        loadImgView.center = CGPoint(x: targetView.center.x, y: y)
//        targetView.addSubview( loadImgView)
//    }
    
    class func DissmissLoading(loadView: UIView, loadImgView: UIImageView){
        print( " CODEE shiii?")
        loadImgView.removeFromSuperview()
        loadView.removeFromSuperview()
    }
    
    
    class func alertWarning(targetVC: UIViewController, title: String, message: String) {
        let alertController = AlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor =  UIColor(named: "colorPrincipalDark")
        alertController.setTitleImage(UIImage(named: "iconWarning"))
        
        // Create the actions
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        
        
        
        // Add the actions
        alertController.addAction(okAction)
        
        
        // Present the controller
        targetVC.present(alertController, animated: true, completion: nil)
    }
    
    class func alertSuccess(targetVC: UIViewController, title: String, message: String) {
        let alertController = AlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor =  UIColor(named: "colorPrincipalDark")
        alertController.setTitleImage(UIImage(named: "iconSuccess"))
        
        // Create the actions
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
           
        }
        
        
        
        // Add the actions
        alertController.addAction(okAction)
        
        
        // Present the controller
        targetVC.present(alertController, animated: true, completion: nil)
    }
    
    
    class func mensajeStandard(targetVC: UIViewController, titulo:String, mensaje:String) {

        

        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor =  UIColor(named: "colorPrincipalDark")
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        targetVC.present(alert, animated: true, completion: nil)


    }
    
    class func alertErrorResponse(targetVC: UIViewController, title: String, message: String) {
        let alertController = AlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor =  UIColor(named: "colorPrincipalDark")
        alertController.setTitleImage(UIImage(named: "iconWarning"))
        
        // Create the actions
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        
//        let detailAction = UIAlertAction(title: "Ver Detalle", style: UIAlertAction.Style.default) {
//            UIAlertAction in
//
//            alertErrorDetail(targetVC: targetVC, detail_error: detail_error, title: title, message: message)
//        }
        
        
        
        // Add the actions
        //alertController.addAction(detailAction)
        alertController.addAction(okAction)
        
        
        // Present the controller
        targetVC.present(alertController, animated: true, completion: nil)
    }
    
    class func alertErrorDetail(targetVC: UIViewController, detail_error: String, title: String, message: String) {
        let alertController = AlertController(title: "", message: detail_error, preferredStyle: .alert)
        alertController.view.tintColor =  UIColor(named: "colorPrincipalDark")
        
        // Create the actions
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            alertErrorResponse(targetVC: targetVC, title: title, message: message)
        }
        
        
        
        // Add the actions
        alertController.addAction(okAction)
        
        
        // Present the controller
        targetVC.present(alertController, animated: true, completion: nil)
    }
    
    class func alertStatusCode (targetVC: UIViewController, code: Int, funcion: String, data: NSDictionary) {
        if code == 500 {
            alertErrorServer(targetVC: targetVC)
        } else if code == 401 {
            
            if funcion == "api-login" {
                alertErrorResponse(targetVC: targetVC, title: "Usuario no encontrado", message: "Usuario y/o contraseña incorrectos")
            } else {
                let okAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default) {
                     UIAlertAction in
                    self.cerrarSesion(targetVC: targetVC)
                     
                 }
                
                 let alert = UIAlertController(title: "¡Atención!", message: "Su usuario no esta autenticado.", preferredStyle: .alert)
                 alert.addAction(okAction)
                 targetVC.present(alert, animated: true)
            }
            
            
        } else if code == 403 {
            
//            if funcion.contains("validar") {
//                alertErrorResponse(targetVC: targetVC, title: "¡Atención!", message: "Hacen falta archivos por anexar.", detail_error: "\(data)")
//
//            } else if funcion.contains("api/product") {
//                alertErrorResponse(targetVC: targetVC, title: "¡Atención!", message: "El producto ya no puede ser eliminado.", detail_error:"\(data)")
//            } else {
//                alertErrorResponse(targetVC: targetVC, title: "Lo Sentimos", message: "Tiene acceso restringido.", detail_error: "\(data)")
//                self.cerrarSesion(targetVC: targetVC)
//            }
            
            alertErrorResponse(targetVC: targetVC, title: "¡Atención!", message: data.value(forKey: "message") as? String ?? "")
            
            
        } else if code == 404 {
            alertErrorResponse(targetVC: targetVC, title: "Lo Sentimos", message: "La función solicitada no fue encontrada.")
            self.cerrarSesion(targetVC: targetVC)
            
        } else if code == 422 {
//            if funcion == "api/product" {
//                alertErrorResponse(targetVC: targetVC, title: "Lo Sentimos", message: "El correo electrónico ya se encuentra registrado.", detail_error: "\(data)")
////            } else if funcion == "api/refresh" {
////                alertWarning(targetVC: targetVC, title: "Lo Sentimos", message: "Refresh Token inválido.")
////            } else if funcion.contains("api/signup") {
////                alertWarning(targetVC: targetVC, title: "Lo Sentimos", message: "El código es inválido.")
//            } else {
//                alertErrorResponse(targetVC: targetVC, title: "Lo Sentimos", message: "Faltan parámetros para ejecutar la petición.", detail_error: "\(data)")
//            }
            alertErrorResponse(targetVC: targetVC, title: "Atención", message: self.getErrorsMessages(dataErrors: data))
        } else {
            alertErrorResponse(targetVC: targetVC, title: "Lo Sentimos", message: "Se ha producido un error.")
        }
    }
    
    
    class func cerrarSesion(targetVC: UIViewController) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "login") as! ViewController
//        targetVC.present(controller, animated: true, completion: nil)
//
//        let mapViewControllerObj = targetVC.storyboard?.instantiateViewController(withIdentifier: "login") as? ViewController
//        targetVC.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
        
        deleteDataSession("access_token")
        deleteDataSession("email")
        let loginView = LoginRouter().viewController
        loginView.modalPresentationStyle = .fullScreen
        
        targetVC.present(loginView, animated: true, completion: nil)
    }
    
    class func getErrorsMessages (dataErrors: NSDictionary ) -> String {
        var message = ""
        if let errors = dataErrors.value(forKey: "errors") as? NSDictionary {
            
            for requisito in productsTextArray {
                let nombre_parametro = (requisito as AnyObject).value(forKey: "nombre_parametro") as? String ?? ""
                let messagesArray = errors.value(forKey: nombre_parametro) as? NSArray ?? NSArray()
                if messagesArray.count > 0 {
                    for messageItem in messagesArray {
                        message += "- \(messageItem)\n"
                    }
                }
            }
            
        }
        
        return message
        
    }
    

}
