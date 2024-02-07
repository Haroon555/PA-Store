//
//  LoginScreenViewControllerInteractor.swift
//  PA Store
//
//  Created Haroon Shoukat on 18/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Alamofire

final class LoginScreenViewControllerInteractor {

    weak var presenter: LoginScreenViewControllerInteractorOutputProtocol?

    deinit {
        print("deinit LoginScreenViewControllerInteractor")
    }
}

extension LoginScreenViewControllerInteractor: LoginScreenViewControllerInteractorInputProtocol {
    func loginUser(params: [String : Any]) {
        let url = "https://mmc.pawnamerica.com/api/Mobile/login"
        let request = Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
        request.responseJSON { (data) in
            switch data.result{
            case .success(let result):
                let response = result as! NSDictionary
                guard let jsonData = data.data else {
                         return
                   }
                   let decoder = JSONDecoder()
                     do {
                         let response = try decoder.decode(LoginResponse.self, from: jsonData)
                         let encoder = JSONEncoder()
                         let data = try encoder.encode(response.datt?.user)
                         UserDefaults.standard.set(data, forKey: "user")
                         let soteData = try encoder.encode(response.datt?.AssignedStores)
                         UserDefaults.standard.set(soteData, forKey: "stores")
                         self.presenter?.getLoginSuccess(response)
//                         if response.AssignedStores?.count ?? 0 > 1 {
//                             self.gotoAssignedStore(stores: response.AssignedStores)
//                         }else{
//                             self.gotoHomePage()
//                         }
                     } catch {
                         print("@@@@@getDataList Unexpected error: \(error.localizedDescription).")
                         self.presenter?.getLoginFailure(error.localizedDescription)
                     }
                
                break
            case .failure:
                print("@@@success")
                self.presenter?.getLoginFailure(data.result.description)
                return
            }
        }
    }
}
