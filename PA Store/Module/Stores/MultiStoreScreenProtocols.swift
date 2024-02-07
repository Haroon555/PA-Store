//
//  MultiStoreScreenProtocols.swift
//  PA Store
//
//  Created Haroon Shoukat on 19/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Hasnain Kanji
//

import Foundation

// MARK: Wireframe -
protocol MultiStoreScreenWireframeProtocol: class {
    func gotoHomePage()
}
// MARK: Presenter -
protocol MultiStoreScreenPresenterProtocol: class {

    var interactor: MultiStoreScreenInteractorInputProtocol? { get set }

    func viewDidLoad()
    
    var stores: [AssignedStore] {get set}
    
    func gotoHomePage()
}

// MARK: Interactor -
protocol MultiStoreScreenInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol MultiStoreScreenInteractorInputProtocol: class {

    var presenter: MultiStoreScreenInteractorOutputProtocol? { get set }

    /* Presenter -> Interactor */
}

// MARK: View -
protocol MultiStoreScreenViewProtocol: class {

    var presenter: MultiStoreScreenPresenterProtocol? { get set }

    /* Presenter -> ViewController */
    func showLoader()
    func hideLoader()

    func setupEnglishView()
    func setupArabicView()
}
