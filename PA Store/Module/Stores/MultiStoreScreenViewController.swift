//
//  MultiStoreScreenViewController.swift
//  PA Store
//
//  Created Haroon Shoukat on 19/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MultiStoreScreenViewController: UIViewController {

	var presenter: MultiStoreScreenPresenterProtocol?
    
    @IBOutlet weak var tableViewStores: UITableView!
    
    
    deinit {
        printNgi("deinit MultiStoreScreenViewController")
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
        networkRequest()
        setUpTableView()
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
    
    private func setUpTableView(){
        self.tableViewStores.register(UINib(nibName: "StoreTableViewCell", bundle: nil), forCellReuseIdentifier: "StoreTableViewCell")
        self.tableViewStores.delegate = self
        self.tableViewStores.dataSource = self
        self.tableViewStores.separatorColor = .clear
        
        self.tableViewStores.reloadData()
        
    }
    
}

extension MultiStoreScreenViewController: MultiStoreScreenViewProtocol {

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
}

extension MultiStoreScreenViewController {
    
    func setupNavigation() {
    }
    
    func setupView() {
    }
    
    func networkRequest() {
    }
}


//MARK: - TableView Delegate Datasource

extension MultiStoreScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter?.stores.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreTableViewCell") as! StoreTableViewCell
        let obj = self.presenter?.stores[indexPath.row]
        
        cell.lblTitle.text = obj?.StoreName
        obj?.IsPrimaryStore == true ? (cell.lblPrimaryStore.isHidden = false) : (cell.lblPrimaryStore.isHidden = true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        defaults.set(self.presenter?.stores[indexPath.row].StoreNumber, forKey: "StoreId")
        self.presenter?.gotoHomePage()
    }
}
