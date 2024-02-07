//
//  UploadImageScreenViewController.swift
//  PA Store
//
//  Created Haroon Shoukat on 23/01/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftLoader

class UploadImageScreenViewController: UIViewController {

	var presenter: UploadImageScreenPresenterProtocol?

    @IBOutlet private var imgCollectionView: UICollectionView!
    private var imagesData = [UIImage]()
    
    private var convertedImages = [String]()
    
    deinit {
        printNgi("deinit UploadImageScreenViewController")
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

extension UploadImageScreenViewController {
    @IBAction fileprivate func didTapUploadImages() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = false
        pickerController.sourceType = .camera
        self.present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction fileprivate func didTapSaveButton() {
        SwiftLoader.show(title: "Updating Product", animated: true)
        var images = [[String:String]]()
        for item in convertedImages{
            images.append(["FileName":"\(convertedImages.firstIndex(of: item))", "Base64Data":"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"])
        }
        let params = [
            "clientId": "uzbB8yUMN-6citerJ0CEl_e_n7uIoZcN6pdzDknSNlrvTksG7AC7h0mqJjUFahWVD1AJ02-M0yHp1FyS9oI1TQ",
                "clientSecret": "T0uQVhj5kRdqdHEjgsgxv2Idxvu-VZ27YT8HnydvL8o",
            "ReferenceID": "\(self.presenter?.product?.itemId ?? "" )",
            "UserID": "7",
            "Condition": "good",
            "WhatsIncluded": "\(self.presenter?.product?.whatsIncluded ?? "")",
            "WhatsNotIncluded": "\(self.presenter?.product?.whatsNotIncluded ?? "")",
            "ModelNumber": "\(self.presenter?.product?.productModel ?? "")",
            "Features":"Features",
            "Description":"\(self.presenter?.product?.description ?? "")",
            "Color": "Red",
            "Images": images
        ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
        
        printNgi("@@@\(jsonData)--\(jsonString)")
        
        self.presenter?.updateProductCall(param: params)

    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
}

extension UploadImageScreenViewController: UploadImageScreenViewProtocol {

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

extension UploadImageScreenViewController {
    
    func setupNavigation() {
    }
    
    func setupView() {
        self.imgCollectionView.dataSource = self
        self.imgCollectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (self.view.frame.width / 2) - 0.5, height: (self.view.frame.width / 2) - 0.5)
        imgCollectionView.collectionViewLayout = layout
    }
    
    func networkRequest() {
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - UIImagePickerController Delegates

extension UploadImageScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imagesData.append(image.fixOrientation())
            self.convertedImages.append(convertImageToBase64String(img: image))
            self.imgCollectionView.isHidden = false
            self.imgCollectionView.reloadData()
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}


//MARK: - UICollectionView Delegate

extension UploadImageScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = AttachImageCollectionCell.cellForCollectionView(collectionView: collectionView, atIndexPath: indexPath)
        
        cell.imgAttach.image = self.imagesData[indexPath.row]
        cell.buttonClick = {
            self.imagesData.remove(at: indexPath.row)
            self.imgCollectionView.reloadData()
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
//        return CGSize(width: 150, height: 150)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth / 3 - 2, height: collectionWidth / 3 - 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}


