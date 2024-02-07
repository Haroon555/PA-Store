//
//  UpdateProduct.swift
//  PA Store
//
//  Created by Haroon Shoukat on 03/02/2024.
//

import Foundation

struct UpdateProduct: Codable {
    
    var success: Bool?
    var message: String?
    
    

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
    }
    
}
