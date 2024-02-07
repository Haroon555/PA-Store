//
//  SettingViewController.swift
//  PA Store
//
//  Created Haroon Shoukat on 29/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

	var presenter: SettingPresenterProtocol?

    deinit {
        printNgi("deinit SettingViewController")
    }
    
    var stores = [AssignedStore]()

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
    
    @IBAction func didTapChangeStore(_ sender: Any) {
        self.presenter?.gotoMultiStoreScreen(stores: stores)
    }
    @IBAction func didTapLogut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "user")
        self.presenter?.gotoLogin()
    }
}

extension SettingViewController {
    
    
}

extension SettingViewController: SettingViewProtocol {

     func showLoader() {
        DispatchQueue.main.async {
//            self.showLoadingIndicator(withDimView: true)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
//            self.hideLoadingIndicator()
        }
    }

    func setupEnglishView() {

    }
    
    func setupArabicView() {

    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        printNgi("@@@@@_______")
        self.navigationController?.popViewController(animated: true)
    }
}

extension SettingViewController {
    
    func setupNavigation() {
    }
    
    func setupView() {
        let data = UserDefaults.standard.data(forKey: "stores")
        
        if data != nil{
            do {
                let decoder = JSONDecoder()
                stores = try decoder.decode([AssignedStore].self, from: data!)

            } catch {
                // Fallback
            }
        }
    }
    
    func networkRequest() {
    }
}
