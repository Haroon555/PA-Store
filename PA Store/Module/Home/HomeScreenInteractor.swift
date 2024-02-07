//
//  HomeScreenInteractor.swift
//  PA Store
//
//  Created Haroon Shoukat on 04/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HomeScreenInteractor {

    weak var presenter: HomeScreenInteractorOutputProtocol?

    deinit {
        printNgi("deinit HomeScreenInteractor")
    }
}

extension HomeScreenInteractor: HomeScreenInteractorInputProtocol {

}
