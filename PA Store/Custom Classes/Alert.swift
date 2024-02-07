//
//  Alert.swift


import UIKit

public class Alert {
    
    private static var parentWindow:UIViewController?
    
    private init(){
        
    }

    public static func showMsg(title: String? = "Alert", msg: String, btnActionTitle: String? = "Ok") -> Void {
        
        self.parentWindow = nil
        
//        let error = RC.getValue(viewName: .messages(Utility.errorStringConverter2(errors: [""], errorMessage: msg) ?? .doc_delete_msg))
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
//        let alertAction = UIAlertAction(title:  RC.getValue(viewName: .generic(.ok)), style: .default) { (action) in
//
//        }
//        alertController .addAction(alertAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showMsg(title : String = "Notification", msg : String, btnActionTitle : String? = "Okay", parentViewController:UIViewController? ) -> Void {
        
        self.parentWindow = parentViewController
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btnActionTitle, style: .default) { (action) in
            
            
        }
        alertController .addAction(alertAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showWithCompletion(title : String = "Notification", msg: String, btnActionTitle: String? = "Ok" , completionAction: @escaping () -> Void) -> Void{
        
        self.parentWindow = nil
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btnActionTitle, style: .default) { (action) in
            
            completionAction()
        }
        alertController .addAction(alertAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showWithCompletion(title: String = "Notification", msg: String, btnActionTitle: String? = "Okay" , completionAction: @escaping () -> Void, parentViewController: UIViewController?) -> Void {
        
        self.parentWindow = parentViewController
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btnActionTitle, style: .default) { (action) in
            
            completionAction()
        }
        alertController .addAction(alertAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showWithTwoActions(title: String, msg :String , okBtnTitle: String, okBtnAction: @escaping () -> Void , cancelBtnTitle: String , cancelBtnAction: @escaping () -> Void) -> Void {
        
        self.parentWindow = nil
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: okBtnTitle, style: .default, handler: { (action) in
            
            okBtnAction()
        })
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (action) in
            
            cancelBtnAction()
        })
        
        alertController .addAction(doneAction)
        
        alertController .addAction(cancelAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showWithTwoActions(title: String, msg: String, okBtnTitle: String, okBtnAction: @escaping () -> Void , cancelBtnTitle: String, cancelBtnAction: @escaping () -> Void, parentViewController:UIViewController?) -> Void {
        
        self.parentWindow = parentViewController
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: okBtnTitle, style: .default, handler: { (action) in
            
            okBtnAction()
        })
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (action) in
            
            cancelBtnAction()
        })
        
        alertController .addAction(doneAction)
        
        alertController .addAction(cancelAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showWithThreeActions( title : String , msg : String , FirstBtnTitle : String , FirstBtnAction: @escaping () -> Void , SecondBtnTitle : String , SecondBtnAction: @escaping () -> Void , cancelBtnTitle : String , cancelBtnAction: @escaping () -> Void) -> Void{
        
        self.parentWindow = nil
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let firstBtnAction = UIAlertAction(title: FirstBtnTitle, style: .default, handler: { (action) in
            
            FirstBtnAction()
        })
        
        
        let secondBtnAction = UIAlertAction(title: SecondBtnTitle, style: .default, handler: { (action) in
            
            SecondBtnAction()
        })
        
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (action) in
            
            cancelBtnAction()
        })
        
        alertController .addAction(firstBtnAction)
        alertController .addAction(secondBtnAction)
        alertController .addAction(cancelAction)
                Alert.showOnWindow(alertController)
        
    }
    
    public static func showWithThreeActions(title: String, msg: String, FirstBtnTitle: String, FirstBtnAction: @escaping () -> Void , SecondBtnTitle: String, SecondBtnAction: @escaping () -> Void , cancelBtnTitle: String, cancelBtnAction: @escaping () -> Void, parentViewController:UIViewController?) -> Void {
        
        self.parentWindow = parentViewController
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let firstBtnAction = UIAlertAction(title: FirstBtnTitle, style: .default, handler: { (action) in
            
            FirstBtnAction()
        })
         
        let secondBtnAction = UIAlertAction(title: SecondBtnTitle, style: .default, handler: { (action) in
            
            SecondBtnAction()
        })
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (action) in
            
            cancelBtnAction()
        })
        
        alertController .addAction(firstBtnAction)
        alertController .addAction(secondBtnAction)
        alertController .addAction(cancelAction)
        
        Alert.showOnWindow(alertController)
        
    }
    
    private static func showOnWindow(_ alert: UIAlertController) {
        
        if parentWindow != nil {
            parentWindow?.present(alert, animated: true, completion: nil)
        } else {
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(alert, animated: true, completion: nil)
                // topController should now be your topmost view controller
            }
        }
        
    }
    static func showAlertMsgWithTitle( title : String , msg : String , btnActionTitle : String , viewController : UIViewController, completionAction: @escaping () -> Void ) -> Void{
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btnActionTitle, style: .default, handler: { (action) in
            
            completionAction()
        })
        
        alertController .addAction(alertAction)
        
        // return alertController
        viewController .present(alertController, animated: true, completion: nil)
        
    }
    
    static func showAlertMsgWithTitle( title : String , msg : String , otherBtnTitle : String , otherBtnAction: @escaping () -> Void , cancelBtnTitle : String , cancelBtnAction: @escaping () -> Void, viewController : UIViewController ) -> Void{
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: otherBtnTitle, style: .default, handler: { (action) in
            
            otherBtnAction()
        })
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (action) in
            
            cancelBtnAction()
        })
        
        alertController .addAction(cancelAction)
        alertController .addAction(doneAction)
        
        // return alertController
        viewController .present(alertController, animated: true, completion: nil)
        
    }
    //Discard this below function as its the same as the first one
    static func showAlertMsgWithTitle(title: String, msg: String, otherBtnTitle: String, otherBtnAction: @escaping () -> Void, viewController: UIViewController) -> Void {
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: otherBtnTitle, style: .default, handler: { (action) in
            
            otherBtnAction()
        })
        
        alertController .addAction(doneAction)
        
        // return alertController
        viewController .present(alertController, animated: true, completion: nil)
        
    }
    
    static func showErrorMessage(viewController: UIViewController) -> Void {
        
        //PKHUD.sharedHUD.hide()
        let alertController = UIAlertController(title: "Failed", message: "Something went wrong, please try again.", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
        })
        
        alertController .addAction(doneAction)
        
        // return alertController
        viewController .present(alertController, animated: true, completion: nil)
        
    }
    
    static func showErrorMessageWithCompletion (viewController: UIViewController, okButtonAction: @escaping () -> Void) -> Void {
        
        //PKHUD.sharedHUD.hide()
        let alertController = UIAlertController(title: "Failed", message: "Something went wrong, please try again.", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
            okButtonAction()
        })
        
        alertController .addAction(doneAction)
        
        // return alertController
        viewController .present(alertController, animated: true, completion: nil)
        
    }
    
    static func showNoInternetMessage (viewController : UIViewController) -> Void{
        //PKHUD.sharedHUD.hide()
        let alertController = UIAlertController(title: "No Internet", message: "Please make sure you have a working internet connection and retry.", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
        })
        
        alertController .addAction(doneAction)
        
        // return alertController
        viewController .present(alertController, animated: true, completion: nil)
    }
    
    static func showNoInternetMessageWithCompletion (viewController: UIViewController, okButtonAction: @escaping () -> Void) -> Void {
        //PKHUD.sharedHUD.hide()
        let alertController = UIAlertController(title: "No Internet", message: "Please make sure you have a working internet connection.", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
            
            okButtonAction()
        })
        
        alertController .addAction(doneAction)
        
        // return alertController
        viewController .present(alertController, animated: true, completion: nil)
    }
}
