//
//  UploadImageScreenInteractor.swift
//  PA Store
//
//  Created Haroon Shoukat on 23/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Alamofire

final class UploadImageScreenInteractor {

    weak var presenter: UploadImageScreenInteractorOutputProtocol?

    deinit {
        printNgi("deinit UploadImageScreenInteractor")
    }
}

extension UploadImageScreenInteractor: UploadImageScreenInteractorInputProtocol {
    func updateProductCall(param: [String: Any]) {
        let url = "https://mmc.pawnamerica.com/api/Mobile/UpdateProduct"
        let jsonData = try! JSONSerialization.data(withJSONObject: param)
        var request = URLRequest(url: URL(string: url)!)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
        Alamofire.request(request).responseJSON {
                    (response) in
                    print(response)
            switch response.result{
            case .success(let result):
                print("@@@success")
                self.presenter?.getProductSuccess()
                break
            case .failure:
                self.presenter?.getProductFailure(response.result.description)
                return
            }

                }
    }
}
