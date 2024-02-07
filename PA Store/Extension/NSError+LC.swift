//
//  NSError+LC.swift
//  HomeMedics
//
//  Created byDevBatch on 19/06/2017.
//  Copyright © 2017DevBatch. All rights reserved.
//

import Foundation
import UIKit

let LCErrorDomain = "com.errordomain.LC"
let LCFormErrorCode = 40001
typealias LCAlertCompletionHandler = (_ retry: Bool, _ cancel: Bool) -> Void

extension NSError {

    func alertControllerWithTitle(_ title: String) -> MBAlertViewController {
        return MBAlertViewController(title: title, message: localizedDescription, style: .alert)
    }

    func showServerErrorInViewController(_ viewController: UIViewController) {
        let alertViewController = alertControllerWithTitle("")

        let okAction = MBAlertAction(title: "OK", style: .default) { (action) in

            if self.localizedDescription == "kErrorSessionExpired" {
//                let signInNavigationController = UINavigationController()
//                let signinViewController = SignInViewController()
//                SocketIOManager.sharedInstance.resetSocket()
//
//                signInNavigationController.viewControllers = [signinViewController]
//                signInNavigationController.transparentNavigationBar()
//                signInNavigationController.setupAppThemeNavigationBar()
//                UserDefaults.standard.set(false, forKey: kIsUserLoggedIn)
//                UserDefaults.standard.removeObject(forKey: kSession)
//                Utility.removedCookies()
//                UserDefaults.standard.removeObject(forKey: kIsCardInfoAdded)

                let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    //viewController.present(signInNavigationController, animated: true, completion: nil)
                }
            }
        }

        alertViewController.addAction(okAction)
        viewController.present(alertViewController, animated: true, completion: nil)
    }


    func showNoNetworkErrorInViewController(_ viewController: UIViewController, completionBlock: @escaping LCAlertCompletionHandler) {
        let alertViewController = alertControllerWithTitle("")
        let okAction = MBAlertAction(title: "OK", style: .default) { (action) in
            completionBlock(true, false)
        }

        //alertViewController.addAction(retryAction)
        alertViewController.addAction(okAction)
        let time = DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)

        DispatchQueue.main.asyncAfter(deadline: time) {
            viewController.present(alertViewController, animated: true, completion: nil)
        }
    }

    func showErrorBelowNavigation(viewController: UIViewController, isNavigation: Bool = true) {
        let safeArea = viewController.view.safeAreaLayoutGuide.layoutFrame
        let errorView = UIView(frame: CGRect(x: 0, y: safeArea.origin.y, width: safeArea.width, height: 50))
        let errorLabel = UILabel(frame: CGRect(x: errorView.frame.origin.x + 10, y: 0.0, width: errorView.frame.width-10, height: errorView.frame.height))
        
        errorView.backgroundColor = UIColor.errorViewColor().withAlphaComponent(0.9)
        errorLabel.text = localizedDescription
        errorLabel.textAlignment = .center
        errorLabel.textColor = UIColor.white
        errorLabel.font = UIFont.appThemeFontWithSize(13.0)
        errorLabel.numberOfLines = 0

        errorView.addSubview(errorLabel)
        viewController.view.addSubview(errorView)
        viewController.view.bringSubviewToFront(errorView)

        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {

            errorView.alpha = 1.0

            UIView.animate(withDuration: 2.0, animations: {
                errorView.alpha = 0.0

            }, completion: { (completed) in
                errorView.removeFromSuperview()
            })
        }

        if self.localizedDescription == "kErrorSessionExpired" {

            let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {

            }
        }
    }

    // MARK: - Form Validation Errors

    class func showErrorWithMessage(message: String, viewController: UIViewController, type: LCMessageType = .error, isNavigation : Bool = true) {
        let safeArea = viewController.view.safeAreaLayoutGuide.layoutFrame
        let errorView = UIView(frame: CGRect(x: 0, y: safeArea.origin.y, width: safeArea.width, height: 50))
        let errorLabel = UILabel(frame: CGRect(x: errorView.frame.origin.x + 10, y: 0.0, width: errorView.frame.width-10, height: errorView.frame.height))
        
        errorView.backgroundColor = UIColor.errorViewColor().withAlphaComponent(0.9)

        errorLabel.text = message
        errorLabel.textAlignment = .center
        errorLabel.textColor = UIColor.white
        errorLabel.font = UIFont.appThemeFontWithSize(14.0)
        errorLabel.numberOfLines = 0
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.minimumScaleFactor = 0.5

        if type == .success {
            errorView.backgroundColor = UIColor.CustomColorFromHexaWithAlpha("34a239", alpha: 0.9)

        } else if type == .info {
            errorView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        }

        errorView.addSubview(errorLabel)
        viewController.view.addSubview(errorView)
        viewController.view.bringSubviewToFront(errorView)

        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {

            errorView.alpha = 1.0

            UIView.animate(withDuration: 2.0, animations: {
                errorView.alpha = 0.0

            }, completion: { (completed) in
                errorView.removeFromSuperview()
            })
        }
    }

    class func invalidNameError() -> NSError {
        let userInfo : [AnyHashable: Any] = [NSLocalizedDescriptionKey : "Name should be at least 4 characters!"]

        return NSError(domain: LCErrorDomain, code: LCFormErrorCode, userInfo: (userInfo as! [String : Any]))
    }

    class func invalidEmailError() -> NSError {
        let userInfo : [AnyHashable: Any] = [NSLocalizedDescriptionKey : "Invalid email!"]

        return NSError(domain: LCErrorDomain, code: LCFormErrorCode, userInfo: (userInfo as! [String : Any]))
    }

    class func invalidPasswordError() -> NSError {
        let userInfo : [AnyHashable: Any] = [NSLocalizedDescriptionKey : "Password should be atleast 8 characters and should contain mix characters!"]

        return NSError(domain: LCErrorDomain, code: LCFormErrorCode, userInfo: (userInfo as! [String : Any]))
    }

    class func passwordMismatchError() -> NSError {
        let userInfo : [AnyHashable: Any] = [NSLocalizedDescriptionKey : "Password mismatch!"]

        return NSError(domain: LCErrorDomain, code: LCFormErrorCode, userInfo: (userInfo as! [String : Any]))
    }

    // MARK: - Permissions & availablity errors

}
