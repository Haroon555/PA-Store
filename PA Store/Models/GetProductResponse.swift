//
//  GetProductResponse.swift
//  PA Store
//
//  Created by Haroon Shoukat on 23/01/2024.
//

import Foundation
import ObjectMapper

struct GetProductResponse: Codable {
    
    var success: Bool?
    var message: String?
    var datt: DataProduct?
    
    
    
    enum CodingKeys: String, CodingKey {
             case success = "success"
             case message = "message"
             case datt = "Data"
       }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        datt = try values.decodeIfPresent(DataProduct.self, forKey: .datt)
        
    }

}

struct DataProduct: Codable {
    
    var itemId: String = ""
    var qty: Int = 0
    var title: String = ""
    var brand: String = ""
    var categoryCode: String = ""
    var productModel: String = ""
    var itemCode: String = ""
    var storeId: Int = 0
    var condition: String = ""
    var description: String = ""
    var longdescription: String = ""
    var whatsIncluded: String = ""
    var whatsNotIncluded: String = ""
    var salePrice: Float = 0.0
    var unitCost: Float = 0.0
    
    enum CodingKeys: String, CodingKey {
        case itemId = "ItemId"
        case qty = "Qty"
        case title = "Title"
        case brand = "Brand"
        case productModel = "ProductModel"
        case categoryCode = "CategoryCode"
        case itemCode = "ItemCode"
        case storeId = "StoreId"
        case salePrice = "SalePrice"
        case unitCost = "UnitCost"
        case description = "Description"
        case longdescription = "LongDescription"
        case condition = "Condition"
        case whatsIncluded = "WhatsIncluded"
        case whatsNotIncluded = "WhatsNotIncluded"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        itemId = try values.decodeIfPresent(String.self, forKey: .itemId) ?? ""
        qty = try values.decodeIfPresent(Int.self, forKey: .qty) ?? 0
        storeId = try values.decodeIfPresent(Int.self, forKey: .storeId) ?? 0
        salePrice = try values.decodeIfPresent(Float.self, forKey: .salePrice) ?? 0.0
        unitCost = try values.decodeIfPresent(Float.self, forKey: .unitCost) ?? 0.0
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        brand = try values.decodeIfPresent(String.self, forKey: .brand) ?? ""
        productModel = try values.decodeIfPresent(String.self, forKey: .productModel) ?? ""
        categoryCode = try values.decodeIfPresent(String.self, forKey: .categoryCode) ?? ""
        itemCode = try values.decodeIfPresent(String.self, forKey: .itemCode) ?? ""
        condition = try values.decodeIfPresent(String.self, forKey: .condition) ?? ""
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        longdescription = try values.decodeIfPresent(String.self, forKey: .longdescription) ?? ""
        whatsIncluded = try values.decodeIfPresent(String.self, forKey: .whatsIncluded) ?? ""
        whatsNotIncluded = try values.decodeIfPresent(String.self, forKey: .whatsNotIncluded) ?? ""
        
    }
}
