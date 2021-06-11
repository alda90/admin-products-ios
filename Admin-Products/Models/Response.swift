//
//  Response.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 07/06/21.
//  Copyright © 2021 Aldair Carrillo. All rights reserved.
//

import Foundation

struct Response: Codable {
    var success: Bool?
    var message: String?
    var user: User?
    var token: String?
    var parameters: [Parameter]?
    var product_id: String?
    var products: [Product]?
    var detail: [Detail]?
    var colors: [Catalog]?
    var secure_url: String?
}

struct User: Codable {
    var id: String
    var name: String
    var email: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case id = "uid"
        case name, email, password
    }
}

struct Parameter: Codable {
    var id: String
    var is_file: Bool
    var is_catalog: Bool
    var name: String
    var name_parameter: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
//        case isFile = "is_file"
//        case isCatalog = "is_catalog"
        case is_file, is_catalog, name, name_parameter, type
    }
}

struct Product: Codable {
    var id: String
    var value: String
    var parameter: [Parameter]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case value, parameter
    }
}

struct Detail: Codable {
    var id: String
    var value: String
    var parameter: Parameter?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case value, parameter
    }
}

struct Catalog: Codable {
    var id: String
    var name: String
    var code: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, code
    }
}

