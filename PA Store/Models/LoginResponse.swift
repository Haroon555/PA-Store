//
//  LoginResponse.swift
//  PA Store
//
//  Created by Haroon Shoukat on 27/09/2023.
//

import Foundation
import ObjectMapper

struct LoginResponse: Codable {
    
    var success: Bool?
    var message: String?
    var datt: DataObj?
    
    
    
    enum CodingKeys: String, CodingKey {
             case success = "success"
             case message = "message"
             case datt = "Data"
        
       }
    
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        success              <-  map["success"]
//        message        <-  map["message"]
//        User        <-  map["User"]
//        AssignedStores        <-  map["AssignedStores"]
//    }
}


// User Object
struct User: Codable {
    
    var UserID: Int?
    var FirstName: String?
    var LastName: String?
    var Email: String?
    var Role: String?
    var IsAdmin: Bool?
    
    
    enum CodingKeys: String, CodingKey {
             case UserID = "UserID"
             case FirstName = "FirstName"
             case LastName = "LastName"
             case Email = "Email"
             case Role = "Role"
             case IsAdmin = "IsAdmin"
       }
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        UserID              <-  map["UserID"]
//        FirstName              <-  map["FirstName"]
//        LastName        <-  map["LastName"]
//        Email        <-  map["Email"]
//        Role        <-  map["Role"]
//        IsAdmin        <-  map["IsAdmin"]
//    }
}


// Assigned Store
struct AssignedStore: Codable {
    
    var StoreNumber: Int?
    var StoreName: String?
    var IsPrimaryStore: Bool?
    
    enum CodingKeys: String, CodingKey {
             case StoreNumber = "StoreNumber"
             case StoreName = "StoreName"
             case IsPrimaryStore = "IsPrimaryStore"
       }
    
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        StoreNumber              <-  map["StoreNumber"]
//        StoreName              <-  map["StoreName"]
//        IsPrimaryStore        <-  map["IsPrimaryStore"]
//    }
}


struct DataObj: Codable {
    
    var user: User?
    var AssignedStores: [AssignedStore]?
    
    enum CodingKeys: String, CodingKey {
        case user = "User"
        case AssignedStores = "AssignedStores"
       }
    
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        StoreNumber              <-  map["StoreNumber"]
//        StoreName              <-  map["StoreName"]
//        IsPrimaryStore        <-  map["IsPrimaryStore"]
//    }
}
