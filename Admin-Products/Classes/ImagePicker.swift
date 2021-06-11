//
//  ImagePicker.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit
import CropViewController

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}


class ImagePicker: NSObject {
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    
    private var croppingStyle = CropViewCroppingStyle.circular
    private var croppedRect = CGRect.zero
    private var croppedAngle = 0

    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate, style: CropViewCroppingStyle) {
        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController
        self.delegate = delegate
        self.croppingStyle = style

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = false
        self.pickerController.mediaTypes = ["public.image"]
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func present(from sourceView: UIView) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: "Cámara") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Rollo de Cámara") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Galería") {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)

        self.delegate?.didSelect(image: image)
    }

        


}


extension ImagePicker: UIImagePickerControllerDelegate, CropViewControllerDelegate {

    
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        guard let image = info[.editedImage] as? UIImage else {
//            return self.pickerController(picker, didSelect: nil)
//        }
//        self.pickerController(picker, didSelect: image)
        
        guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
        
        //self.pickerController(picker, didSelect: image)
        let cropController = CropViewController(croppingStyle: croppingStyle, image: image)
        cropController.modalPresentationStyle = .fullScreen
        cropController.delegate = self
        cropController.doneButtonTitle = "Listo"
        cropController.cancelButtonTitle = "Cancelar"
        
        picker.pushViewController(cropController, animated: true)
//        if croppingStyle == .circular {
//            if picker.sourceType == .camera {
//                picker.dismiss(animated: true, completion: {
//
//                    self.presentationController!.present(cropController, animated: true, completion: nil)
//                })
//            } else {
//                picker.pushViewController(cropController, animated: true)
//            }
//        }
//        else { //otherwise dismiss, and then present from the main controller
//            picker.dismiss(animated: true, completion: {
//                print("Crop3")
//                self.presentationController!.present(cropController, animated: true, completion: nil)
//                //self.navigationController!.pushViewController(cropController, animated: true)
//            })
//        }
    }
    
    
    ////////////////////////////////////////////////////////////////
    ///// CROPVIEW CONTROLLER
    ////////////////////////////////////////////////////////////////
    
    public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            self.croppedRect = cropRect
            self.croppedAngle = angle
            updateImageViewWithImage(image, fromCropViewController: cropViewController)
        }
        
        public func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            self.croppedRect = cropRect
            self.croppedAngle = angle
            updateImageViewWithImage(image, fromCropViewController: cropViewController)
        }
        
        public func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
            
            self.delegate?.didSelect(image: image)
            cropViewController.dismiss(animated: true, completion: nil)

        }
}

extension ImagePicker: UINavigationControllerDelegate {

}
