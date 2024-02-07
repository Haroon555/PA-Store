//
//  LoginScreenViewControllerPresenter.swift
//  PA Store
//
//  Created Haroon Shoukat on 18/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class LoginScreenViewControllerPresenter {

    weak private var view: LoginScreenViewControllerViewProtocol?
    var interactor: LoginScreenViewControllerInteractorInputProtocol?
    private let router: LoginScreenViewControllerWireframeProtocol

    var userData: LoginResponse?
    
    init(interface: LoginScreenViewControllerViewProtocol, interactor: LoginScreenViewControllerInteractorInputProtocol?, router: LoginScreenViewControllerWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    deinit {
        print("deinit LoginScreenViewControllerPresenter")
    }

    func viewDidLoad() {

    }
}

extension LoginScreenViewControllerPresenter: LoginScreenViewControllerPresenterProtocol {
    func gotoMultiStore(stores: [AssignedStore]) {
        router.gotoMultiStoreScreen(stores: stores)
    }
    
    func loginUser(params: [String : Any]) {
        interactor?.loginUser(params: params)
    }
    

}

extension LoginScreenViewControllerPresenter: LoginScreenViewControllerInteractorOutputProtocol {
    func getLoginSuccess(_ userData: LoginResponse?) {
        self.userData = userData
        view?.showSuccessMessage(userData?.message ?? "")
    }
    
    func getLoginFailure(_ errorMessage: String) {
        view?.showErrorMessage(errorMessage)
    }
    

}
