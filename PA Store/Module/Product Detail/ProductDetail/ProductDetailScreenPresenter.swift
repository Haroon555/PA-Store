//
//  ProductDetailScreenPresenter.swift
//  PA Store
//
//  Created Haroon Shoukat on 23/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ProductDetailScreenPresenter {

    weak private var view: ProductDetailScreenViewProtocol?
    var interactor: ProductDetailScreenInteractorInputProtocol?
    private let router: ProductDetailScreenWireframeProtocol

    init(interface: ProductDetailScreenViewProtocol, interactor: ProductDetailScreenInteractorInputProtocol?, router: ProductDetailScreenWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    deinit {
        printNgi("deinit ProductDetailScreenPresenter")
    }

    func viewDidLoad() {

    }
}

extension ProductDetailScreenPresenter: ProductDetailScreenPresenterProtocol {

}

extension ProductDetailScreenPresenter: ProductDetailScreenInteractorOutputProtocol {

}
