//
//  HomeScreenInteractor.swift
//  PA Store
//
//  Created Haroon Shoukat on 04/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Alamofire

final class HomeScreenInteractor {

    weak var presenter: HomeScreenInteractorOutputProtocol?

    deinit {
        print("deinit HomeScreenInteractor")
    }
}

extension HomeScreenInteractor: HomeScreenInteractorInputProtocol {
    func getProductDetail(refNumber: String) {
        let headers = [
            "Content-Type": "application/json"
        ]
        
        let params: [String: Any] = ["clientId": "uzbB8yUMN-6citerJ0CEl_e_n7uIoZcN6pdzDknSNlrvTksG7AC7h0mqJjUFahWVD1AJ02-M0yHp1FyS9oI1TQ",
            "clientSecret": "T0uQVhj5kRdqdHEjgsgxv2Idxvu-VZ27YT8HnydvL8o",
            "ReferenceID": "\(refNumber)"]
        
        let url = "https://mmc.pawnamerica.com/api/Mobile/GetProduct"
        let request = Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            
        request.responseJSON { (data) in
            print("@@@@@@@@@@@\(data)")
            switch data.result{
            case .success(let result):
//                let response = result as! NSDictionary
                print("@@@success")
                guard let jsonData = data.data else {
                         return
                   }
                let decoder = JSONDecoder()
                  do {
                      let response = try decoder.decode(GetProductResponse.self, from: jsonData)
                      let encoder = JSONEncoder()
                      let data = try encoder.encode(response.datt)
//                      UserDefaults.standard.set(data, forKey: "user")
                      self.presenter?.getProductSuccess(response)
                  } catch {
                      print("@@@@@getDataList Unexpected error: \(error.localizedDescription).")
                      self.presenter?.getProductFailure(error.localizedDescription)
                  }
                
               
                break
            case .failure:
                self.presenter?.getProductFailure(data.result.description)
                return
            }
        }
    }
    }
