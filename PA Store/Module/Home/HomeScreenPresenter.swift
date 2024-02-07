//
//  HomeScreenPresenter.swift
//  PA Store
//
//  Created Haroon Shoukat on 04/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HomeScreenPresenter {

    weak private var view: HomeScreenViewProtocol?
    var interactor: HomeScreenInteractorInputProtocol?
    private let router: HomeScreenWireframeProtocol

    init(interface: HomeScreenViewProtocol, interactor: HomeScreenInteractorInputProtocol?, router: HomeScreenWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    deinit {
        printNgi("deinit HomeScreenPresenter")
    }

    func viewDidLoad() {

    }
}

extension HomeScreenPresenter: HomeScreenPresenterProtocol {

}

extension HomeScreenPresenter: HomeScreenInteractorOutputProtocol {

}
