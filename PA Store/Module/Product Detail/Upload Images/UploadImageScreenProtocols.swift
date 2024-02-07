//
//  UploadImageScreenProtocols.swift
//  PA Store
//
//  Created Haroon Shoukat on 23/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Hasnain Kanji
//

import Foundation

// MARK: Wireframe -
protocol UploadImageScreenWireframeProtocol: class {

}
// MARK: Presenter -
protocol UploadImageScreenPresenterProtocol: class {

    var interactor: UploadImageScreenInteractorInputProtocol? { get set }

    func viewDidLoad()
}

// MARK: Interactor -
protocol UploadImageScreenInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol UploadImageScreenInteractorInputProtocol: class {

    var presenter: UploadImageScreenInteractorOutputProtocol? { get set }

    /* Presenter -> Interactor */
}

// MARK: View -
protocol UploadImageScreenViewProtocol: class {

    var presenter: UploadImageScreenPresenterProtocol? { get set }

    /* Presenter -> ViewController */
    func showLoader()
    func hideLoader()

    func setupEnglishView()
    func setupArabicView()
}
