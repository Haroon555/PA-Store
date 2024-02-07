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
    @objc optional func didTapEditProfile()
    @objc optional func didTapOnSideMenu()
    @objc optional func didTapRightNavButton()
    @objc optional func didTapOnMessage()
    @objc optional func didTapOnInfo()
    @objc optional func didTapOnRightBtn2()
    @objc optional func didTapSwitchOn()
    @objc optional func didTapSwitchOff()

}

// MARK: POPUP HANDLING
@objc protocol PopupProtocol: AnyObject {
    func didTapOnOption1(Data: Any)
    func didTapOnOption2()
}

// MARK: PORTION
@objc protocol PortionProtocol: AnyObject {
    func didTapOnAdd(index: Int)
    func didTapOnSub(index: Int)
}

// MARK: SEND BACK DATA
@objc protocol SendBackData {
    @objc optional func sendBack()
    @objc optional func sendBack(Data: [String: Any], controller: String)
    @objc optional func sendBackObject(Data: Any)
}

// MARK: POPUP CONTROLLER PROTOCOL
protocol PopupControllerProtocol: AnyObject {
    func didTapSubmitButton()
    func didTapNoButton()
}
