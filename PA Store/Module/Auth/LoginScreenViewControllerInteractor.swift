//
//  LoginScreenViewControllerInteractor.swift
//  PA Store
//
//  Created Haroon Shoukat on 18/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class LoginScreenViewControllerInteractor {

    weak var presenter: LoginScreenViewControllerInteractorOutputProtocol?

    deinit {
        printNgi("deinit LoginScreenViewControllerInteractor")
    }
}

extension LoginScreenViewControllerInteractor: LoginScreenViewControllerInteractorInputProtocol {

}
