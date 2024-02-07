//
//  HomeController.swift
//  PA Store
//
//  Created by Haroon Shoukat on 29/11/2023.
//

import UIKit
import BarcodeScanner
import Foundation
import Alamofire

class HomeController: UIViewController {
    
    //MARK: - IbOutlets
    @IBOutlet weak var viewServiceOne: HMView!
    @IBOutlet weak var viewServiceTwo: HMView!
    @IBOutlet weak var viewServiceThree: HMView!
    @IBOutlet weak var viewServiceFourth: HMView!
    @IBOutlet weak var viewServiceFive: HMView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    //MARK: - Private
    
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
        print("@@@--\(Utility.isKeyPresentInUserDefaults(key: kToken))")
        
        let navLabel = UILabel()
        let navTitle = Utility.attributedTitleWithFirstBold(firstTitle: "Home", secondTitle: "")
        navLabel.attributedText = navTitle
        navLabel.textColor  = .black
        navigationItem.titleView = navLabel
        
        let filterBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
        filterBtn.setImage(#imageLiteral(resourceName: "power"), for: .normal)
        filterBtn.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: filterBtn)
        self.navigationItem.rightBarButtonItem = barButton
        
        let serviceOneGesture = UITapGestureRecognizer(target: self, action: #selector(firstViewTapped(sender:)))
        viewServiceOne.addGestureRecognizer(serviceOneGesture)
    }
    //MARK: -  Functions
    private func gotoProductDetailPage(){
        let productDetailController = ProductDetailViewController()
        productDetailController.addCustomBackButton()
        self.navigationController?.pushViewController(productDetailController, animated: true)
    }
    //MARK: - Ib Actions
    @objc func firstViewTapped(sender: UITapGestureRecognizer) {
        //        let scannerViewController = ScannerViewController()
        //        scannerViewController.modalPresentationStyle = .fullScreen
        //        self.navigationController?.pushViewController(scannerViewController, animated: false)
        
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
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func logoutButtonTapped(sender: UIBarButtonItem){
        UserDefaults().removeObject(forKey: "user")
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Api Methods

extension HomeController: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    func scanner(_ controller: BarcodeScanner.BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("@@@--\(code)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            controller.navigationController?.popViewController(animated: true)
            self.getProductDetailRequest()
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


//MARK: - Api Methods

extension HomeController {
    private func getProductDetailRequest(){
        self.indicatorView.isHidden = false
        self.indicatorView.startAnimating()
        let headers = [
            "Content-Type": "application/json"
        ]
        
        let params: [String: Any] = ["clientId": "uzbB8yUMN-6citerJ0CEl_e_n7uIoZcN6pdzDknSNlrvTksG7AC7h0mqJjUFahWVD1AJ02-M0yHp1FyS9oI1TQ",
            "clientSecret": "T0uQVhj5kRdqdHEjgsgxv2Idxvu-VZ27YT8HnydvL8o",
            "ReferenceID": "24321028190"]
        
        let url = "https://mmc.pawnamerica.com/api/tokenauth/GetProduct"
        let request = Alamofire.request(url, method: .post, parameters: params, headers: headers)
            
        request.responseJSON { (data) in
            print("@@@@@@@@@@@\(data)")
            self.indicatorView.isHidden = true
            self.indicatorView.stopAnimating()
            switch data.result{
            case .success(let result):
                let response = result as! NSDictionary
                print("@@@success")
                self.gotoProductDetailPage()
                break
            case .failure:
                print("@@@success")
                return
            }
        }
    }
}
