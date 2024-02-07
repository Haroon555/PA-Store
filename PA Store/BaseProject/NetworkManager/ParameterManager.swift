//  Created by Faran Mushtaq on 25/02/2020.
//  Copyright © 2020 Appsnado. All rights reserved.

import Foundation
import UIKit
import Alamofire

public struct ParameterManager {
    var serviceURL: String = ""
    var params: [String : Any]?
    var headers: [String : String]?
    var method: HTTPMethod
    var images: [UIImage?]
    var imageTitle: [String]? = []
    var files: [URL?] = []
    var fileKey: String = ""
    var parameterEncoding: ParameterEncoding
    var isIcloudMultipart = false
    var fileType = ""

    
    public init(serviceURL:String,
                params: [String : Any],
                headers: [String : String],
                method: HTTPMethod,
                parameterEncoding: ParameterEncoding,
                images: [UIImage?],
                imageTitle: [String] = [] ,
                files: [URL?] = [],
                fileKey: String = "post_file",
                fileType: String = ""){
        
        self.serviceURL = serviceURL
        self.params = params
        self.headers = headers
        self.method = method
        self.images = images
        self.parameterEncoding = parameterEncoding
        self.imageTitle = imageTitle
        self.files = files
        self.fileKey = fileKey
    }
}

