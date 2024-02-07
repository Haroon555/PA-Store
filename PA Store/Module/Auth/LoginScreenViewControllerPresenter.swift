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

    init(interface: LoginScreenViewControllerViewProtocol, interactor: LoginScreenViewControllerInteractorInputProtocol?, router: LoginScreenViewControllerWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    deinit {
        printNgi("deinit LoginScreenViewControllerPresenter")
    }

    func viewDidLoad() {

    }
}

extension LoginScreenViewControllerPresenter: LoginScreenViewControllerPresenterProtocol {

}

extension LoginScreenViewControllerPresenter: LoginScreenViewControllerInteractorOutputProtocol {

}
