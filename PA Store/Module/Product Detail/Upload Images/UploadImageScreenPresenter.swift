//
//  UploadImageScreenPresenter.swift
//  PA Store
//
//  Created Haroon Shoukat on 23/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class UploadImageScreenPresenter {

    weak private var view: UploadImageScreenViewProtocol?
    var interactor: UploadImageScreenInteractorInputProtocol?
    private let router: UploadImageScreenWireframeProtocol

    init(interface: UploadImageScreenViewProtocol, interactor: UploadImageScreenInteractorInputProtocol?, router: UploadImageScreenWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    deinit {
        printNgi("deinit UploadImageScreenPresenter")
    }

    func viewDidLoad() {

    }
}

extension UploadImageScreenPresenter: UploadImageScreenPresenterProtocol {

}

extension UploadImageScreenPresenter: UploadImageScreenInteractorOutputProtocol {

}
