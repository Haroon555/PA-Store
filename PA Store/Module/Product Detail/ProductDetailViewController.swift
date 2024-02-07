//
//  ProductDetailViewController.swift
//  PA Store
//
//  Created by Haroon Shoukat on 22/09/2023.
//

import UIKit
import Lightbox

class ProductDetailViewController:  UIViewController {
    
    //MARK: - IbOutlets
    @IBOutlet weak var tableView: UITableView!

    //MARK: - Private
    private var titles = ["Brand","Title","Product Model","Item Code","Sales Price"]
    private var Values = ["Nintendo","Nintendo Ags001 Gameby Advance Spaaa W Cord, Case","Ags001","Game, Electronic Television","99.990000"]

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
        
        let navLabel = UILabel()
        let navTitle = Utility.attributedTitleWithFirstBold(firstTitle: "Product", secondTitle: "Detail")
        navLabel.attributedText = navTitle
        navigationItem.titleView = navLabel
        
        let filterBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
        filterBtn.setImage(#imageLiteral(resourceName: "back_arrow"), for: .normal)
        filterBtn.addTarget(self, action: #selector(backButton), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: filterBtn)
        self.navigationItem.leftBarButtonItem = barButton
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        self.tableView.reloadData()
    }
    //MARK: - Public Functions
    
    //MARK: - Ib Actions
    @objc override func backButton(sender : UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction fileprivate func didTapUploadImages() {
        let productDetailController = AttachImageViewController()
        productDetailController.addCustomBackButton()
        self.navigationController?.pushViewController(productDetailController, animated: true)
    }
}

//MARK: - Api Methods

extension ProductDetailViewController {
    
}


//MARK: - TableView Delegate & Datasource

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProductTVCell.cellForTableView(tableView: tableView, atIndexPath: indexPath)
        let item = self.titles[indexPath.row]
        let itemValues = self.Values[indexPath.row]
        cell.labelTitle.text = item
        cell.labelValue.text = itemValues
        return cell
    }
}


