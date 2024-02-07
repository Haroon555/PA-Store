//
//  SettingPresenter.swift
//  PA Store
//
//  Created Haroon Shoukat on 29/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SettingPresenter {

    weak private var view: SettingViewProtocol?
    var interactor: SettingInteractorInputProtocol?
    private let router: SettingWireframeProtocol

    init(interface: SettingViewProtocol, interactor: SettingInteractorInputProtocol?, router: SettingWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    deinit {
        printNgi("deinit SettingPresenter")
    }

    func viewDidLoad() {

    }
}

extension SettingPresenter: SettingPresenterProtocol {
    func gotoMultiStoreScreen(stores: [AssignedStore]) {
        router.gotoMultiStoreScreen(stores: stores)
    }
    
    func gotoLogin() {
        router.gotoLogin()
    }
}

extension SettingPresenter: SettingInteractorOutputProtocol {

}
