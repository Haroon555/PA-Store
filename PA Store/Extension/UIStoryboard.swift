//
//  UIStoryboard.swift
//  PA Store
//
//  Created by Haroon Shoukat on 11/09/2023.
//

import Foundation
import UIKit

extension UIStoryboard {

    func instantiateViewController<T: UIViewController>(ofType _: T.Type,
                                                        withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        guard let controller = instantiateViewController(withIdentifier: identifier) as? T else {
            assertionFailure("instantiateNavigationController controller unwrapped failed")
            fatalError()
        }
        return controller
    }

    func instantiateNavigationController<T: UINavigationController>(ofType _: T.Type,
                                                                    withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        guard let navigationController = instantiateViewController(withIdentifier: identifier) as? T else {
            assertionFailure("instantiateNavigationController navigation controller unwrapped failed")
            fatalError()
        }
        return navigationController
    }
}
