//
//  LoginViewController.swift
//  PA Store
//
//  Created by Haroon Shoukat on 18/09/2023.
//

import UIKit
import MaterialComponents
import Alamofire
import ObjectMapper
//import Networking
import LocalAuthentication

class LoginViewController: UIViewController {
    
    //MARK: - IbOutlets
    @IBOutlet var txtFieldEmail: MDCOutlinedTextField!
    @IBOutlet var txtFieldPassword: MDCOutlinedTextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var imgViewFaceId: UIImageView!
    //MARK: - Private
    typealias CompletionHandler = (_ success:Bool) -> Void
    //MARK: - Public
    
    //MARK: - onCreate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    //MARK: - Private Functions
    private func setUpViewController(){
        self.indicatorView.isHidden = true
        print("@@@\(Utility.isKeyPresentInUserDefaults(key: kToken))")
        guard let data = UserDefaults.standard.data(forKey: "user") else {
            return
        }
        do {
            let decoder = JSONDecoder()
            let person = try decoder.decode(User.self, from: data)
            if person.Email != "" {
                self.gotoHomePage()
            }
        } catch {
            // Fallback
        }
        
       
        
        let serviceOneGesture = UITapGestureRecognizer(target: self, action: #selector(imgViewTapped(sender:)))
        self.imgViewFaceId.isUserInteractionEnabled = true
        self.imgViewFaceId.addGestureRecognizer(serviceOneGesture)
    }
    //MARK: - Public Functions
    private func gotoHomePage(){
        let navController = UINavigationController()
        navController.setupAppThemeNavigationBar()
        let homeView = HomeController()
        navController.viewControllers = [homeView]
        self.present(navController, animated: true, completion: nil)
    }
    
    private func gotoAssignedStore(stores: [AssignedStore]?){
        
        let navController = UINavigationController()
        navController.setupAppThemeNavigationBar()
        let assignedStoresViewController = MultiStoreViewController()
        assignedStoresViewController.stores = stores ?? [AssignedStore]()
        navController.viewControllers = [assignedStoresViewController]
        self.present(navController, animated: true, completion: nil)
        
    }
    
    private func faceLogin(compltion: CompletionHandler){
        let context = LAContext()
        var error: NSError? = nil
        let reason  = "Please authorize with faceid"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {[weak self] success, error in
                guard success, error == nil else {
                    return
                }
                
//                DispatchQueue.main.sync {
//
//                    compltion(true)
//                }
            }
        }else{
            let alert = UIAlertController(title: "Unavailable", message: "You can't use this service", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self.present(alert, animated: true)
        }

    }
    //MARK: - Ib Actions
    @IBAction fileprivate func didTapLogin() {
        
        
        //        if txtFieldEmail.text!.isEmpty {
        //            NSError.showErrorWithMessage(message: "Empty Email Field", viewController: self, type: .error, isNavigation: false)
        //            return
        //        }
        //
        //        if txtFieldPassword.text!.isEmpty {
        //            NSError.showErrorWithMessage(message: "Empty Password Field", viewController: self, type: .error, isNavigation: false)
        //            return
        //        }
        
        self.indicatorView.isHidden = false
        self.indicatorView.startAnimating()
        loginRequest()
    }
    
    @objc func imgViewTapped(sender: UITapGestureRecognizer) {
        faceLogin { success in
            self.gotoHomePage()
        }
    }
    
    
}

//MARK: - Api Methods

extension LoginViewController {
    private func loginRequest(){
        
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        let headers: HTTPHeaders = [
            
            "Content-Type":"application/json",
            "Accept": "application/json"
            //                "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        
        
        let params: [String: String] = ["email": "emmad.ali@pawnamerica.com", "password": "PawnAmerica@12345", "clientId": "uzbB8yUMN-6citerJ0CEl_e_n7uIoZcN6pdzDknSNlrvTksG7AC7h0mqJjUFahWVD1AJ02-M0yHp1FyS9oI1TQ",
            "clientSecret": "T0uQVhj5kRdqdHEjgsgxv2Idxvu-VZ27YT8HnydvL8o"]
        
        let url = "https://mmc.pawnamerica.com/api/tokenauth/login"
        let request = Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
        request.responseJSON { (data) in
            self.indicatorView.isHidden = true
            self.indicatorView.stopAnimating()
            switch data.result{
            case .success(let result):
                let response = result as! NSDictionary
                guard let jsonData = data.data else {
                         return
                   }
                   let decoder = JSONDecoder()
                     do {
                         let response = try decoder.decode(LoginResponse.self, from: jsonData)
                         let encoder = JSONEncoder()
                         let data = try encoder.encode(response.datt?.user)
                         UserDefaults.standard.set(data, forKey: "user")
                         if response.datt?.AssignedStores?.count ?? 0 > 1 {
                             self.gotoAssignedStore(stores: response.datt?.AssignedStores)
                         }else{
                             self.gotoHomePage()
                         }
                     } catch {
                         print("@@@@@getDataList Unexpected error: \(error.localizedDescription).")
                     }
                
                break
            case .failure:
                print("@@@success")
                return
            }
        }
    }
}
