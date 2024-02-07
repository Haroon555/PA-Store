//
//  MultiStoreScreenPresenter.swift
//  PA Store
//
//  Created Haroon Shoukat on 19/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MultiStoreScreenPresenter {

    weak private var view: MultiStoreScreenViewProtocol?
    var interactor: MultiStoreScreenInteractorInputProtocol?
    private let router: MultiStoreScreenWireframeProtocol

    init(interface: MultiStoreScreenViewProtocol, interactor: MultiStoreScreenInteractorInputProtocol?, router: MultiStoreScreenWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    deinit {
        printNgi("deinit MultiStoreScreenPresenter")
    }

    func viewDidLoad() {

    }
}

extension MultiStoreScreenPresenter: MultiStoreScreenPresenterProtocol {

}

extension MultiStoreScreenPresenter: MultiStoreScreenInteractorOutputProtocol {

}
