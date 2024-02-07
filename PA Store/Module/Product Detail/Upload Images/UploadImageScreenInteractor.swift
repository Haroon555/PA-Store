//
//  UploadImageScreenInteractor.swift
//  PA Store
//
//  Created Haroon Shoukat on 23/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class UploadImageScreenInteractor {

    weak var presenter: UploadImageScreenInteractorOutputProtocol?

    deinit {
        printNgi("deinit UploadImageScreenInteractor")
    }
}

extension UploadImageScreenInteractor: UploadImageScreenInteractorInputProtocol {

}
