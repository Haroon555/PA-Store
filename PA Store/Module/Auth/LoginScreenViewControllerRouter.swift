//
//  LoginScreenViewControllerRouter.swift
//  PA Store
//
//  Created Haroon Shoukat on 18/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Hasnain Kanji
//

import UIKit

final class LoginScreenViewControllerRouter {

    weak var viewController: UIViewController?

    deinit {
        printNgi("deinit LoginScreenViewControllerRouter")
    }

    static func createModule() -> UIViewController {

        // Change to get view from storyboard if not using progammatic UI
        let view = LoginScreenViewControllerViewController(nibName: nil, bundle: nil)
        let interactor = LoginScreenViewControllerInteractor()
        let router = LoginScreenViewControllerRouter()
        let presenter = LoginScreenViewControllerPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}

extension LoginScreenViewControllerRouter: LoginScreenViewControllerWireframeProtocol {

}