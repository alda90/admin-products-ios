//
//  Session.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 11/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import Foundation

var nombreApp: String = "Admin-Products"
var versionApp: String = "v1.0"
var productsTextArray: NSMutableArray = NSMutableArray()

func getDataSession(_ key: String) -> String {
    let datos = UserDefaults.standard
    let data = datos.string(forKey: key)
    
    if data != nil {
        return data!
    }
    else {
        return ""
    }
}

func setDataSession(_ data: Any, key: String) {
    
    // creamos el objeto NSUserDefaults
    let datos = UserDefaults.standard
    
    // guardamos el nombre (NSString)
    datos.set(data, forKey: key)
    
    // guardamos la edad (Integer)
    //[datos setInteger:[tfEdad.text integerValue] forKey:@"edad"];
    
    // almacenamos los datos en la memoria
    datos.synchronize()
}

func deleteDataSession(_ key: String){
    UserDefaults.standard.removeObject(forKey: key)
}
