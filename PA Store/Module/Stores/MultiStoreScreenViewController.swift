//
//  MultiStoreScreenViewController.swift
//  PA Store
//
//  Created Haroon Shoukat on 19/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MultiStoreScreenViewController: BaseViewController {

	var presenter: MultiStoreScreenPresenterProtocol?

    deinit {
        printNgi("deinit MultiStoreScreenViewController")
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

extension MultiStoreScreenViewController {
}

extension MultiStoreScreenViewController: MultiStoreScreenViewProtocol {

     func showLoader() {
        DispatchQueue.main.async {
            self.showLoadingIndicator(withDimView: true)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.hideLoadingIndicator()
        }
    }

    func setupEnglishView() {

    }
    
    func setupArabicView() {

    }
}

extension MultiStoreScreenViewController: SetupViewController {
    
    func setupNavigation() {
    }
    
    func setupView() {
    }
    
    func networkRequest() {
    }
}
