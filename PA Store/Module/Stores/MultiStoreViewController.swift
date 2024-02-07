//
//  MultiStoreViewController.swift
//  PA Store
//
//  Created by Haroon Shoukat on 10/10/2023.
//

import UIKit

class MultiStoreViewController:  UIViewController {
    
    //MARK: - IbOutlets
    @IBOutlet weak var tableViewStores: UITableView!

    //MARK: - Private
    
    //MARK: - Public
    var stores = [AssignedStore]()
    //MARK: - onCreate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    //MARK: - Private Functions
    private func setUpViewController(){
        let navLabel = UILabel()
        let navTitle = Utility.attributedTitleWithFirstBold(firstTitle: "Assigned", secondTitle: " Stores")
        navLabel.attributedText = navTitle
        navigationItem.titleView = navLabel
        
        setUpTableView()
    }
    
    private func setUpTableView(){
        self.tableViewStores.register(UINib(nibName: "StoreTableViewCell", bundle: nil), forCellReuseIdentifier: "StoreTableViewCell")
        self.tableViewStores.delegate = self
        self.tableViewStores.dataSource = self
        self.tableViewStores.separatorColor = .clear
        
        self.tableViewStores.reloadData()
        
    }
    //MARK: - Public Functions
    
    //MARK: - Ib Actions
    
}

//MARK: - TableView Delegate Datasource

extension MultiStoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreTableViewCell") as! StoreTableViewCell
        let obj = self.stores[indexPath.row]
        
        cell.lblTitle.text = obj.StoreName
        obj.IsPrimaryStore == true ? (cell.lblPrimaryStore.isHidden = false) : (cell.lblPrimaryStore.isHidden = true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
