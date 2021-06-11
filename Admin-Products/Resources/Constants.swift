//
//  Constants.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 06/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import Foundation

struct Constants {
    
    struct URL {
        //// PRODUCTION
        
        //// DEVELOPMENT
        static let main = "https://admin-products-4dev.herokuapp.com/"
        
        static let cloudinary = "https://api.cloudinary.com/v1_1/dlkkcbp7h/image/upload"
    }
    
    struct Endpoints {
        static let login = "api/login"
        static let logout = "api/login/renew"
        
        static let parameter = "api/parameter"
        static let product = "api/product"
        static let image = "api/product/image"
        
    }
    
    struct Catalogos {
        static let color = "api/color"
    }
}     
