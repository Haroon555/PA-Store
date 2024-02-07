//
//  ProductDetailScreenProtocols.swift
//  PA Store
//
//  Created Haroon Shoukat on 23/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Hasnain Kanji
//

import Foundation

// MARK: Wireframe -
protocol ProductDetailScreenWireframeProtocol: class {
    func gotoImageCapturePage(product: DataProduct)
}
// MARK: Presenter -
protocol ProductDetailScreenPresenterProtocol: class {

    var interactor: ProductDetailScreenInteractorInputProtocol? { get set }
    var product: DataProduct? {get set}
    func viewDidLoad()
    
    func gotoImageCapturePage(product: DataProduct)
}

// MARK: Interactor -
protocol ProductDetailScreenInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol ProductDetailScreenInteractorInputProtocol: class {

    var presenter: ProductDetailScreenInteractorOutputProtocol? { get set }

    /* Presenter -> Interactor */
}

// MARK: View -
protocol ProductDetailScreenViewProtocol: class {

    var presenter: ProductDetailScreenPresenterProtocol? { get set }

    /* Presenter -> ViewController */
    func showLoader()
    func hideLoader()

    func setupEnglishView()
    func setupArabicView()
}
