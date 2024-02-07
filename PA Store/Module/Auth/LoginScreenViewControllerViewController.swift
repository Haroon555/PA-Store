//
//  LoginScreenViewControllerViewController.swift
//  PA Store
//
//  Created Haroon Shoukat on 18/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import MaterialComponents
import SwiftLoader

class LoginScreenViewControllerViewController: UIViewController {
    
    var presenter: LoginScreenViewControllerPresenterProtocol?
    
    //MARK: - IbOutlets
    @IBOutlet var txtFieldEmail: MDCOutlinedTextField!
    @IBOutlet var txtFieldPassword: MDCOutlinedTextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var imgViewFaceId: UIImageView!
    //MARK: - Private
    typealias CompletionHandler = (_ success:Bool) -> Void
    //MARK: - Public
    
    //MARK: - onCreate
    
    deinit {
        print("deinit LoginScreenViewControllerViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
        networkRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension LoginScreenViewControllerViewController {
    
    private func setUpViewController(){
        print("@@@\(Utility.isKeyPresentInUserDefaults(key: kToken))")
        //        guard let data = UserDefaults.standard.data(forKey: "user") else {
        //            return
        //        }
        //        do {
        //            let decoder = JSONDecoder()
        //            let person = try decoder.decode(User.self, from: data)
        //            if person.Email != "" {
        //                self.gotoHomePage()
        //            }
        //        } catch {
        //            // Fallback
        //        }
        
        
        
        //        let serviceOneGesture = UITapGestureRecognizer(target: self, action: #selector(imgViewTapped(sender:)))
        //        self.imgViewFaceId.isUserInteractionEnabled = true
        //        self.imgViewFaceId.addGestureRecognizer(serviceOneGesture)
    }
}

extension LoginScreenViewControllerViewController: LoginScreenViewControllerViewProtocol {
    func showErrorMessage(_ errorMessage: String) {
        Alert.showMsg(title: "Alert",
                      msg: "\(errorMessage)",
                      btnActionTitle: "Ok")
        hideLoader()
    }
    
    func showSuccessMessage(_ message: String) {
        hideLoader()
        self.presenter?.gotoMultiStore(stores: self.presenter?.userData?.datt?.AssignedStores ?? [])
    }
    
    
    func showLoader() {
        DispatchQueue.main.async {
            //            self.showLoadingIndicator(withDimView: true)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            SwiftLoader.hide()
            //            self.hideLoadingIndicator()
        }
    }
    
    func setupEnglishView() {
        
    }
    
    func setupArabicView() {
        
    }
}

extension LoginScreenViewControllerViewController {
    
    func setupNavigation() {
    }
    
    func setupView() {
    }
    
    func networkRequest() {
    }
}


//MARK: - IbActions

extension LoginScreenViewControllerViewController{
    @IBAction fileprivate func didTapLogin() {
        txtFieldEmail.text = "emmad.ali@pawnamerica.com"
        txtFieldPassword.text = "PawnAmerica@12345"
        
        if txtFieldEmail.text!.isEmpty {
            NSError.showErrorWithMessage(message: "Empty Email Field", viewController: self, type: .error, isNavigation: false)
            return
        }
        
        if txtFieldPassword.text!.isEmpty {
            NSError.showErrorWithMessage(message: "Empty Password Field", viewController: self, type: .error, isNavigation: false)
            return
        }
        
        SwiftLoader.show(title: "Login", animated: true)
        let params = ["email":"\(self.txtFieldEmail.text ?? "")", "password": "\(self.txtFieldPassword.text ?? "")",
                      "clientId": "uzbB8yUMN-6citerJ0CEl_e_n7uIoZcN6pdzDknSNlrvTksG7AC7h0mqJjUFahWVD1AJ02-M0yHp1FyS9oI1TQ",
                      "clientSecret": "T0uQVhj5kRdqdHEjgsgxv2Idxvu-VZ27YT8HnydvL8o"]
        self.presenter?.loginUser(params: params)
    }
}
