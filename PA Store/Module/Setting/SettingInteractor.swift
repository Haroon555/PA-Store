//
//  SettingInteractor.swift
//  PA Store
//
//  Created Haroon Shoukat on 29/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SettingInteractor {

    weak var presenter: SettingInteractorOutputProtocol?

    deinit {
        printNgi("deinit SettingInteractor")
    }
}

extension SettingInteractor: SettingInteractorInputProtocol {

}
