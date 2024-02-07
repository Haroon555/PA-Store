//
//  Protocols.swift
//  Karve
//
//  Created by Faran Mushtaq on 27/02/2020.
//  Copyright © 2020 Appsnado. All rights reserved.
//

import Foundation

// MARK: NAVIGATION CONTROLLER PROTOCOL
@objc protocol NavigationViewProtocol: AnyObject {
    @objc optional func didTapBackButton()
    @objc optional func didTapSwitchOff()

}
