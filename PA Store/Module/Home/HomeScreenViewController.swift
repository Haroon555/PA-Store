//
//  HomeScreenViewController.swift
//  PA Store
//
//  Created Haroon Shoukat on 04/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftLoader
import NVActivityIndicatorView
import Alamofire
import BarcodeScanner

class HomeScreenViewController: UIViewController {
    
    var presenter: HomeScreenPresenterProtocol?
    
    
    // MARK: - Iboutlets
    @IBOutlet weak var lblHello: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var collectionViewServices: UICollectionView!
    @IBOutlet weak var viewNavigation: NavigationView!
    @IBOutlet weak var viewNavigationHC: NSLayoutConstraint!
    @IBOutlet weak var buttonSetting: UIButton!
    
    
    //MARK: - Private variables
    private var servicesList = ["Scan Product", "High Value Count", "Service", "Service"]
    private var servicesListDescription = ["Scan products with barcode", "Add update High Value Count", "Service Description", "Service Description"]
    var option_icons = [ImagesName.ScanProduct, ImagesName.HighValueCount, ImagesName.ScanProduct, ImagesName.ScanProduct]
    
    deinit {
        print("deinit HomeScreenViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
        networkRequest()
        checkUserLoginStatus()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        setupCollectionView()
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

//MARK: - Private Functions

extension HomeScreenViewController{
    
}
    
    
//MARK: - functions
extension HomeScreenViewController {
    
    @IBAction func didTapSetting(_ sender: UIButton) {
        self.presenter?.gotoSetting()
    }
    
    func setupCollectionView() {
        collectionViewServices.delegate = self
        collectionViewServices.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (self.view.frame.width / 2) - 0.5, height: (self.view.frame.width / 2) - 0.5)
        collectionViewServices.collectionViewLayout = layout
        collectionViewServices.register(UINib(nibName: String(describing: HomeServicesCVC.self), bundle: .main), forCellWithReuseIdentifier: String(describing: HomeServicesCVC.self))
        //        collectionViewServices.register(UINib(nibName: String(describing: HomeSliderCVC.self), bundle: .main), forCellWithReuseIdentifier: String(describing: HomeSliderCVC.self))
    }
    func setUpServiceCollectionView(){
        self.collectionViewServices.register(UINib(nibName:"HomeServicesCVC", bundle: nil), forCellWithReuseIdentifier:"HomeServicesCVC")
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (self.view.frame.width / 2) - 0.5, height: (self.view.frame.width / 2) - 0.5)
        
        self.collectionViewServices.collectionViewLayout = layout
        
        self.collectionViewServices.delegate = self
        self.collectionViewServices.dataSource = self
        
        self.collectionViewServices.reloadData()
        
    }
}

extension HomeScreenViewController: HomeScreenViewProtocol {
    func showAlertView(message: String) {
        Alert.showMsg(msg: message, parentViewController: self)
    }
    
    
    func showLoader() {
        DispatchQueue.main.async {
            //            self.showLoadingIndicator(withDimView: true)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            //            self.hideLoadingIndicator()
            SwiftLoader.hide()
        }
    }
    
    func setupEnglishView() {
        
    }
    
    func setupArabicView() {
        Alert.showMsg(msg: "Data not Found!", parentViewController: self)
    }
}

extension HomeScreenViewController {
    
    func setupNavigation() {
        let navigation: NavigationView = .fromNib()
        navigation.delegate = self
        navigation.btnLogout.isHidden = false
//        self.setNavigationBar(view: viewNavigation, title: "PA Store", navigationView: navigation)
        viewNavigationHC.constant = 98
    }
    
    func setNavigationBar(view: UIView, title: String, isFromSideMenu: Bool = false, navigationView: UIView) {
        view.endEditing(true)
        let navigation = navigationView
        navigation.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        navigation.frame = view.frame
        view.addSubview(navigation)
    }
    
    func setupView() {
        
        self.lblHello.text = "Hello"
        //        self.lblHello.font = UIFont(name: "Poppins-Bold", size: 20)
        self.lblHello.textColor = .orange
        
        
        self.lblUserName.text = "Emaad Ali"
        //        self.lblUserName.font = UIFont(name: "Poppins-Bold", size: 18)
        //        self.lblUserName.font = AppFonts.getFont(.syneBold(engSize: 30))()
        self.lblUserName.textColor = .white
        //        setupCollectionView()
        setUpServiceCollectionView()
    }
    
    func networkRequest() {
    }
}


//MARK: - Navigation delegate

extension HomeScreenViewController: NavigationViewProtocol{
    
    func didTapSwitchOff() {
        self.presenter?.gotoLoginPage()
    }
    
    func checkUserLoginStatus(){
        let data = UserDefaults.standard.data(forKey: "user")
        
        if data != nil{
            do {
                let decoder = JSONDecoder()
                let person = try decoder.decode(User.self, from: data!)
                self.lblUserName.text = "\(person.FirstName ?? "") \(person.LastName ?? "")"
                if person.Email == "" {
                    self.presenter?.gotoLoginPage()
                }
            } catch {
                // Fallback
            }
        }else{
            self.presenter?.gotoLoginPage()
        }

    }
    
    func openBarCode() {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        viewController.headerViewController.titleLabel.text = "Scan barcode"
        viewController.cameraViewController.barCodeFocusViewType = .animated
        viewController.cameraViewController.showsCameraButton = true
        viewController.headerViewController.closeButton.tintColor = .red
        viewController.messageViewController.regularTintColor = .black
        viewController.messageViewController.errorTintColor = .red
        viewController.messageViewController.textLabel.textColor = .black
        viewController.isOneTimeSearch = true
        self.navigationController?.present(viewController, animated: true)
    }
}


//MARK: - UICollection view delegate and datasource

extension HomeScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.servicesList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeServicesCVC", for: indexPath) as! HomeServicesCVC
        var serviceName: String?
        var serviceDescription: String?
        var imageObj: String?
        serviceName = self.servicesList[indexPath.row]
        imageObj = self.option_icons[indexPath.row]
        serviceDescription = self.servicesListDescription[indexPath.row].description
        cell.lblTitle.text = "\(serviceName ?? "")"
        cell.lblTitle.textColor = .black
        cell.lblDesc.textColor = .black
//        cell.lblTitle.textAlignment = .center
        cell.lblDesc.text = "\(serviceDescription ?? "")"
//        cell.lblDesc.textAlignment = .center
        cell.imgView.image = UIImage(named: imageObj ?? "")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
//            SwiftLoader.show(title: "Getting Detail", animated: true)
//            self.presenter?.getProductDetail(refNumber: "1242962337352")
            self.openBarCode()
        }
        
    }
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        return CGSize(width: (self.view.frame.width  / 2) - 0.5, height: 150)
        
        //        if (self.servicesList.count ?? 0) == indexPath.row {
        //            return CGSize(width: self.view.frame.width, height: (self.view.frame.width / 2) - 0.5)
        //        }else{
        //            return CGSize(width: (self.view.frame.width  / 2) - 0.5, height: 205)
        //
        //        }
//        if (self.servicesList.count ?? 0) == indexPath.row {
//            return CGSize(width: self.view.frame.width, height: 200)
//        }else{
            let padding = 1
//            let width = (collectionView.frame.size.width - CGFloat(padding) * 2) / CGFloat(2)
            let width = (collectionView.frame.width  / 2) - 0.5
            let height = width / 200 * 110 // or what height you want to do
            return CGSize(width: width, height: 200)
        
    }
}




extension HomeScreenViewController: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    func scanner(_ controller: BarcodeScanner.BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("@@@--\(code)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            controller.navigationController?.popViewController(animated: true)
            controller.dismiss(animated: true)
            let refNumber = code
            SwiftLoader.show(title: "Getting Detail", animated: true)
            self.presenter?.getProductDetail(refNumber: refNumber)
        }
        //        controller.reset()
        //        controller.dismiss(animated: true, completion: nil)
        //        getProductDetailRequest()
        
    }
    
    func scanner(_ controller: BarcodeScanner.BarcodeScannerViewController, didReceiveError error: Error) {
        print("@@@@===\(error)")
    }
    
    func scannerDidDismiss(_ controller: BarcodeScanner.BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
