//
//  UIViewController+LC.swift
//  HomeMedics
//
//  Created byDevBatch on 21/06/2017.
//  Copyright © 2017DevBatch. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    
    
    func setPresentationStyle() {
        self.modalPresentationStyle = .fullScreen
    }
    
    func addCustomBackButton(shouldDismissOnBack: Bool = false) {
        let selector = shouldDismissOnBack ?  #selector(barCancelButtonTapped(button:)) : #selector(backButton(sender:))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Back arrow black"), style: .plain, target: self, action: selector)
    }

    func addCustomCrossButton() {
        let crossButton: UIButton = UIButton (type: UIButton.ButtonType.custom)
        crossButton.setImage(UIImage(named: "cancel"), for: UIControl.State.normal)

        crossButton.addTarget(self, action: #selector(self.barCancelButtonTapped(button:)), for: UIControl.Event.touchUpInside)

        crossButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: crossButton)

        navigationItem.rightBarButtonItem = barButton
    }

    @objc func backButtonPressed(button : UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backButton(sender : UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    

    @objc func barCancelButtonTapped(button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func backButtonTapped(button: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationChangeBarButton), object: nil)
        navigationController?.popViewController(animated: true)
    }

}
