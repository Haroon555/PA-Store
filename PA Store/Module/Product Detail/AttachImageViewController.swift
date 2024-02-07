//
//  AttachImageViewController.swift
//  PA Store
//
//  Created by Haroon Shoukat on 22/09/2023.
//

import UIKit
import Alamofire

class AttachImageViewController: UIViewController {
    
    //MARK: - IbOutlets
    @IBOutlet private var imgCollectionView: UICollectionView!

    //MARK: - Private
    private var imagesData = [UIImage]()

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
        let navTitle = Utility.attributedTitleWithFirstBold(firstTitle: "Attach ", secondTitle: "Image")
        navLabel.attributedText = navTitle
        navigationItem.titleView = navLabel
        
        let filterBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
        filterBtn.setImage(#imageLiteral(resourceName: "back_arrow"), for: .normal)
        filterBtn.addTarget(self, action: #selector(backButton), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: filterBtn)
        self.navigationItem.leftBarButtonItem = barButton
        
        
        let doneBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
        doneBtn.setTitle("Save", for: .normal)
        doneBtn.setTitleColor(.black, for: .normal)
        doneBtn.addTarget(self, action: #selector(backButton), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: doneBtn)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.imgCollectionView.dataSource = self
        self.imgCollectionView.delegate = self
    }
    //MARK: - Public Functions
    
    //MARK: - Ib Actions
    @IBAction fileprivate func didTapUploadImages() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = false
        pickerController.sourceType = .camera
        self.present(pickerController, animated: true, completion: nil)
    }
    
    @objc override func backButton(sender : UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Api Methods

extension AttachImageViewController {
    
}

//MARK: - UIImagePickerController Delegates

extension AttachImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        self.imagesData.append(image.fixOrientation())
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

extension AttachImageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
    return CGSize(width: 150, height: 150)
}

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

}
}
