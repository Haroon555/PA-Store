//
//  Shortcut.swift
//  PA Store
//
//  Created by Haroon Shoukat on 11/09/2023.
//

import Foundation
import UIKit

func getStoryBoard(_ storyBoard: StoryBoard) -> UIStoryboard {
    return UIStoryboard(name: storyBoard.rawValue, bundle: nil)
}

func printNgi(_ any: Any) {
        print(any)
}

func getApiHeaders() -> [String: String] {
   
    var headers = [String: String]()
    headers["x-device-type"] = "ios"
  //  headers["x-app-version"] = appVersionWithBuilNumber()
    headers["x-device-id"] = UIDevice.current.identifierForVendor?.uuidString

    return headers
}

func getImage(imageName: String) -> UIImageView {
    let imageName = imageName
    let image = UIImage(named: imageName)
    let imageView = UIImageView(image: image!)
    return imageView
}
