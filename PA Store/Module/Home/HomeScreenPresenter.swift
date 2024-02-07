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
        print("deinit HomeScreenPresenter")
    }

    func viewDidLoad() {

    }
}

extension HomeScreenPresenter: HomeScreenPresenterProtocol {
    func gotoSetting() {
        router.gotoSetting()
    }
    
    func gotoProductDetailPage(product: GetProductResponse) {
        router.gotoProductDetailPage(product: product)
    }
    
    func getProductDetail(refNumber: String) {
        interactor?.getProductDetail(refNumber: refNumber)
    }
    
    func gotoLoginPage() {
        router.gotoLoginPage()
    }
    

}

extension HomeScreenPresenter: HomeScreenInteractorOutputProtocol {
    
    func getProductSuccess(_ product: GetProductResponse) {
        if product.message == "Product is already image ready"{
            self.view?.hideLoader()
            self.view?.showAlertView(message: "Product is already image ready")
        }else{
            self.gotoProductDetailPage(product: product)
            self.view?.hideLoader()
        }
        
    }
    
    func getProductFailure(_ errorMessage: String) {
        self.view?.setupArabicView()
    }
    

}
