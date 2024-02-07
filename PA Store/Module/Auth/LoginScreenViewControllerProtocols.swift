//
//  LoginScreenViewControllerProtocols.swift
//  PA Store
//
//  Created Haroon Shoukat on 18/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Hasnain Kanji
//

import Foundation

// MARK: Wireframe -
protocol LoginScreenViewControllerWireframeProtocol: class {

}
// MARK: Presenter -
protocol LoginScreenViewControllerPresenterProtocol: class {

    var interactor: LoginScreenViewControllerInteractorInputProtocol? { get set }

    func viewDidLoad()
}

// MARK: Interactor -
protocol LoginScreenViewControllerInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol LoginScreenViewControllerInteractorInputProtocol: class {

    var presenter: LoginScreenViewControllerInteractorOutputProtocol? { get set }

    /* Presenter -> Interactor */
}

// MARK: View -
protocol LoginScreenViewControllerViewProtocol: class {

    var presenter: LoginScreenViewControllerPresenterProtocol? { get set }

    /* Presenter -> ViewController */
    func showLoader()
    func hideLoader()

    func setupEnglishView()
    func setupArabicView()
}
