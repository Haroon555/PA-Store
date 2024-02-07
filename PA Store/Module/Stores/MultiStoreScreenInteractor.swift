//
//  MultiStoreScreenInteractor.swift
//  PA Store
//
//  Created Haroon Shoukat on 19/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MultiStoreScreenInteractor {

    weak var presenter: MultiStoreScreenInteractorOutputProtocol?

    deinit {
        printNgi("deinit MultiStoreScreenInteractor")
    }
}

extension MultiStoreScreenInteractor: MultiStoreScreenInteractorInputProtocol {

}
