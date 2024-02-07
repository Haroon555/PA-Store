//
//  AuthModuleManager.swift
//  PA Store
//
//  Created by Haroon Shoukat on 11/09/2023.
//

import Foundation

class AuthModuleManager {
//    func APILogin(param:[String:Any],
//                  version: BaseUrlVersion = .version1,
//                  success: @escaping (BaseModelObject<UserModel>?) -> Void,
//                  failure: @escaping (String, [String]) -> Void) {
//        
//        let headers: [String: String] = getApiHeaders()
//        let userLoginURL = URLManager.getBaseUrl(with: version) + URLManager().LOGIN
//        let networkParam = ParameterManager(serviceURL: userLoginURL,
//                                            params: param,
//                                            headers: headers,
//                                            method: .post,
//                                            parameterEncoding: URLEncoding.default,
//                                            images: [])
//        
//        APIManager.sharedInstance.apiBaseRequest(networkParam, success: { (response) in
//            
//            guard let data = response else { return }
//            
//            let parsedModal = ParsingManager<UserModel>().parseModal(from: data)
//            
//            let status = APIManager.sharedInstance.getstatusCode(apiStatus: parsedModal?.apiStatus ?? 500)
//            
//            switch status {
//            case URLManager().SUCCESS:
//                success(parsedModal)
//                
//            case URLManager().FAILURE:
//                failure(parsedModal?.message ?? "", parsedModal?.error ?? [])
//                
//            default: break
//            }
//        })
//    }
}
