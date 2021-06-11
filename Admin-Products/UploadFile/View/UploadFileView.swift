//
//  UploadFileView.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit
import CropViewController
import SDWebImage


protocol uploadFileProtocol {
    func getUploadFileResponse(response: Response)
}

class UploadFileView: UIViewController, uploadFileViewModelProtocol {
    
    
    
    @IBOutlet weak var imgFile: UIImageView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    private var viewModel = UploadFileViewModel()
    private var router: UploadFileRouter?
    private var imagePicker: ImagePicker!
    
    var delegate: uploadFileProtocol!
    var product_id: String?
    var detail_id: String?
    var image: String = ""
    var apiFunction = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        router = UploadFileRouter(product_id: product_id!, detail_id: detail_id!, delegate: delegate, image: image)
        viewModel.bind(view: self, router: router!, delegate: self)
        
        let btnCerrar = UIBarButtonItem(title: "Cerrar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(UploadFileView.cerrar(_:)))
        navItem.setLeftBarButton(btnCerrar, animated: true)
        
        if image != "" {
            let urlImage = URL(string: image)
            imgFile.sd_setImage(with: urlImage)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        navItem.title = "Subir Archivo"
       }


    @IBAction func actionBuscarImagen(_ sender: Any) {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self, style: CropViewCroppingStyle.default)
        self.imagePicker.present(from: sender as! UIView)
    }
    
    @IBAction func actionUploadFile(_ sender: Any) {
        
        guard let image  = imgFile.image else {
             AlertErrorGral.alertWarning(targetVC: self, title: "¡Atención!", message: "Debe agregar una imagen.")
            
            return
        }
        
        let imageHeight = image.size.height
        let imageWidth = image.size.width
        
        print("Height Image: \(imageHeight)")
        print("Width Image: \(imageWidth)")
        
        var imageToUpload: UIImage?
        if Double(imageHeight) >  2027.0 {
            imageToUpload = image.resize(withSize: CGSize(width: 1524.0, height: 2027.0))
            print("New Height Image: \(imageToUpload!.size.height)")
            print("New Width Image: \(imageToUpload!.size.width)")
        } else {
            imageToUpload = image
        }
        
        
        
        let imgData = imageToUpload!.jpegData(compressionQuality: 0.55) ?? Data()
        apiFunction = "UPLOAD IMAGE"
        viewModel.uploadFile(targetVC: self, file_parameter: "foto", imageData: imgData)

//               if imgData.base64EncodedString() == "" {
//
//                   AlertErrorGral.alertWarning(targetVC: self, title: "¡Atención!", message: "Debe agregar una imagen.")
//               } else {
//

    }
    
    @objc func cerrar(_ sender: Any) {
           self.presentingViewController!.dismiss(animated: true, completion: nil)
       }
    
    
    func getResponse(response: Response) {
         print("ResultView: \(response)")
        
        if apiFunction == "UPLOAD IMAGE" {
            let secure_url = response.secure_url ?? ""
            
            if secure_url != "" {
                let parameters = "id=\(detail_id ?? "")&photo=\(secure_url)"
                apiFunction = "SAVE IMAGE"
                viewModel.saveImageProduct(targetVC: self, parameters: parameters)
            }
        } else if apiFunction == "SAVE IMAGE" {
            self.delegate.getUploadFileResponse(response: response)
            self.presentingViewController!.dismiss(animated: true, completion: nil)

        }
    }
    
    func getErrorResponse(error: NSString) {
        print("error: \(error)")
    }
    
}

extension UploadFileView: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imgFile.image = image
    }
}
