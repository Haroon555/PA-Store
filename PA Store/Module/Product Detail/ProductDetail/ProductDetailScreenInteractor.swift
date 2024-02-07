//
//  ProductDetailScreenInteractor.swift
//  PA Store
//
//  Created Haroon Shoukat on 23/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ProductDetailScreenInteractor {

    weak var presenter: ProductDetailScreenInteractorOutputProtocol?

    deinit {
        printNgi("deinit ProductDetailScreenInteractor")
    }
}

extension ProductDetailScreenInteractor: ProductDetailScreenInteractorInputProtocol {

}
