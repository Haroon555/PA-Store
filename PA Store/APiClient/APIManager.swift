//  Created by Faran Mushtaq on 25/02/2020.
//  Copyright © 2020 Appsnado. All rights reserved.

import Foundation
import Alamofire
import RealmSwift
import MobileCoreServices

class APIManager: NSObject {
    
    //progress view
    public var progressLabel: UILabel?
    var progressView: UIProgressView?
    
    static let sharedInstance = APIManager()
    public var sessionManager: Alamofire.SessionManager!
    
    override init() {
        sessionManager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default
        )
        sessionManager.session.configuration.timeoutIntervalForRequest = 120
    }
    
    public var baseURL = ""
}

// MARK: Network Headers Extensions
extension APIManager {
    
    class func NetworkHeaders() -> HTTPHeaders {
        
        var serviceHeaders: HTTPHeaders = [:]
        
        if let authentication = UserDefaults.standard.string(forKey: URLManager().authentication) {
            serviceHeaders[URLManager().authentication] = "Bearer \(authentication)"
        }
        
        return serviceHeaders
    }
}

// MARK: Network Service Extensions
extension APIManager {
    
    public func apiBaseRequest(_ param: ParameterManager,
                               isShowSpinner : Bool = true,
                               success:@escaping (Data?) -> Void) {
        
        if !ConnectionManager().isConnectedToNetwork() {
            Alert.showMsg(title: RC.getValue(viewName: .pharmacy(.alert)), msg: RC.getValue(viewName: .errorMessage(.internet_error)))
            return
        }
        
        if isShowSpinner {
            AFNetwork.shared.showSpinner()
        }
        
        printNgi("\n\(ApiErrorMessage.URL_ERROR) \(param.serviceURL)")
        printNgi("\(ApiErrorMessage.PARAMETERS_ERROR) \(param.params?.prettyPrintedJSON ?? "")")
        printNgi("\(ApiErrorMessage.HEADERS_ERROR) \(param.headers?.prettyPrintedJSON ?? "")")
        
        sessionManager.request(param.serviceURL,
                               method: param.method,
                               parameters: param.params,
                               encoding: param.parameterEncoding,
                               headers: param.headers)
            .validate().responseJSON { (response) -> Void in
                
                printNgi("\n\(ApiErrorMessage.RESPONSE_ERROR) \(response)")
                
                AFNetwork.shared.hideSpinner()
                printNgi(response.data)
              //  success(response.data)
               
                switch response.result {
                case.success:
                    success(response.data)
                    self.checkIfUpdateAvailable(response.data ?? Data())
                case.failure:
                    success(response.data)
                    self.errorHandler(response)
                }
        }
    }
    
    // image or file upload
    func apiBaseMultipart(_ param: ParameterManager,
                          isShowSpinner: Bool = true,
                          success:@escaping (Data?) -> Void,
                          failure:@escaping (Error) -> Void) {
        
        if !ConnectionManager().isConnectedToNetwork() {
            Alert.showMsg(msg: GlobalStatic.getLocalizedString(ConstantText.NO_INTERNET))
            NotificationCenter.default.post(name: Notification.Name.noInternet, object: nil)
            return
        }
        
        if isShowSpinner {
            AFNetwork.shared.showSpinner()
        }
        
        let URL = try! URLRequest(url: param.serviceURL, method: param.method, headers: param.headers)
        
        printNgi("\n\(ApiErrorMessage.URL_ERROR) \(param.serviceURL)")
        printNgi("\(ApiErrorMessage.PARAMETERS_ERROR) \(param.params?.prettyPrintedJSON ?? "")")
        printNgi("\(ApiErrorMessage.HEADERS_ERROR) \(param.headers?.prettyPrintedJSON ?? "")")
        
        self.sessionManager.upload(multipartFormData: { (multipartFormData) in
            
            //multipart params
            if param.params != nil {
                
                for (key, value) in param.params! {
                    
                    printNgi(key)
                    printNgi(value)
                    
                    //--FM
                    if let tagsArray = value as? [String] {
                        
                        let stringsData = NSMutableData()
                        for tag in tagsArray {
                            if let stringData = tag.data(using: .utf8) {
                                stringsData.append(stringData)
                            }
                        }
                        multipartFormData.append(stringsData as Data, withName: key)
                    } else if value is NSDictionary {
                        do {
                            let json = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                            multipartFormData.append(json as Data, withName: key)
                        } catch {}
                    } else if value is [NSDictionary] {
                        do {
                            let json = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                            multipartFormData.append(json as Data, withName: key)
                        } catch {}

                    } else if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                        multipartFormData.append(data, withName: key)
                    }
                    
                    /*   if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                     multipartFormData.append(data, withName: key)
                     } */
                }
            }
            
            // multipart images
            if param.images != nil {
                if param.images.count > 0 {
                                for (index,value) in param.images.enumerated() {
                                    let imageData = value?.pngData() as Data?
                                    if imageData != nil {
                                        multipartFormData.append(imageData!,
                                                                 withName: param.imageTitle?[index] ?? "",
                                                                 fileName: param.fileKey ?? "\(Date().toMillis() ?? 0).png" ,
                                                                 mimeType: "image/png")
                                    }
                                }
                            }
                        }
//            if param.images != nil {
//                if param.images!.count > 0 {
//                    for value in param.images! {
//                        let imageData = value.pngData() as Data?
//                        if imageData != nil {
//                            multipartFormData.append(imageData!,
//                                                     withName: param.imageTitle,
//                                                     fileName: "file.png",
//                                                     mimeType: "image/png")
//                        }
//                    }
//                }
//            }
            
            // icloud drive multipart request
            
            // multipart videos and images
            if(param.files != nil) {
                if(param.files.count > 0) {
                    for value in param.files {
                        if((value is UIImage)) {
                            //for images
                            let imageData = (value as? UIImage)?.jpegData(compressionQuality: 0.7)
                            
                        multipartFormData.append(imageData!, withName: param.fileKey + "[]", fileName: "file.png", mimeType: "image/png")
                        } else if(value is URL) {
                        
                            
                            let fileExtension = (value as! URL).pathExtension

                           
                        if fileExtension == "mp3" || fileExtension == "wav" {
                            
                            let fileExtension = (value as! URL).pathExtension
                            
                            let fileName = (value as! URL).deletingPathExtension().lastPathComponent
                            let data = try! Data(contentsOf: value as! URL)
                            
//                            let fileName = (value as! URL).lastPathComponent
//                        let data = try! Data(contentsOf: value as! URL)
                            multipartFormData.append(data, withName: param.fileKey , fileName: fileName, mimeType: "audio.m4a")
                            printNgi(fileName)
                        }
                            if fileExtension == "pdf"{
                                
                                let fileName = (value as! URL).lastPathComponent
                                let data = try! Data(contentsOf: value as! URL)
                          
                                multipartFormData.append(data, withName: param.fileKey, fileName: fileName, mimeType: "application/pdf")
                            }
                            
                            else {
                                let fileName = (value as! URL).lastPathComponent

                                let data = try! Data(contentsOf: value as! URL)

                                multipartFormData.append(data, withName: param.fileKey + "[]", fileName: fileName, mimeType: "video/mp4")
                            }
                            
                        } else if (value is Data) {
                            if param.fileType == FileType.audio {
                                multipartFormData.append(value as! Data, withName: param.fileKey + "[]", fileName: "audio.mp3", mimeType: "audio/mp3")
                            } else if param.fileType == FileType.video {
                                
                            } else if param.fileType == FileType.image {
                                multipartFormData.append(value as! Data, withName: param.fileKey + "[]", fileName: "video.mp3", mimeType: "video/mp4")
                            } else {
                      
                            }
                        }
                    }
                }
            }
            
            printNgi(multipartFormData)
            
        }, with: URL, encodingCompletion: { (result) in
            
            switch result {
            case .success(let upload, _, _):
                upload
                    .uploadProgress { progress in
                        
                        //set progress view
                        printNgi(Float(progress.fractionCompleted))
//                        self.setProgressProgress(Float(progress.fractionCompleted))
//                        AFNetwork.shared.progressLabel?.text = "Uploading \(Int(progress.fractionCompleted * 100.0)) %"
//                        AFNetwork.shared.progressView?.progress = Float(progress.fractionCompleted)
//                        AFNetwork.shared.showProgressView(self.returnTopWindow())
                }
                .validate()
                .responseJSON { response in
                    
                    DispatchQueue.main.async {
                        AFNetwork.shared.hideSpinner()
//                        AFNetwork.shared.hideProgressView()
                    }
                    
                    printNgi("\n\(ApiErrorMessage.RESPONSE_ERROR) \(String(describing: response))")
                    
                    //set progress view
//                    self.setProgressProgress(1.0)
                    
                    switch response.result {
                    case .success(let value):
                        
                        printNgi(value)
                        
                        if response.result.value != nil {
                            success(response.data)
                        } else {
                            success(response.data)
                        }
                    case .failure(let responseError):
                        
                        printNgi("responseError: \(responseError)")
                        NotificationCenter.default.post(name: Notification.Name.uploadFailed, object: nil)
                        failure(responseError)
                        Alert.showMsg(msg: responseError.localizedDescription)
                    }
                }
            case .failure(let encodingError):
                failure(encodingError)
            }
        })
    }
    
    
    private func checkIfUpdateAvailable(_ serverResponse: Data) {
        guard let dataDictionary = serverResponse.getJSONFromData() else {
            return
        }
        let isUpdateAvailable = dataDictionary["update_available"] as? Int
        AppThemeConfig.appUpdateType = isUpdateAvailable ?? 0
        switch AppUpdateType.init(rawValue: isUpdateAvailable ?? 0) {
        case .softUpdate, .hardUpdate:
            if !AppThemeConfig.appUpdatePresent {
                DispatchQueue.main.async {
                    let vc = WarningPopupRouter.createModule(.appUpdate)
                    vc.view.backgroundColor = .black.withAlphaComponent(0.6)
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    UIViewController.top().present(vc, animated: true, completion: nil)
                }
                AppThemeConfig.appUpdatePresent = true
            }
        default:
            break
        }
    }
}

// MARK: Network Error Extensions
extension APIManager {
    
    private func errorHandler(_ response: DataResponse<Any>) {
        
        guard let data = response.data else { return }
        let parsedMessage = ParsingManager<UserModel>().parseModal(from: data)
        
        let error: Error = response.result.error!
        
        printNgi("\n\(ApiErrorMessage.ERROR_CODE) \(error)")
        
        if ((response.response?.statusCode ?? 500) > 400) && ((response.response?.statusCode ?? 500) < 600) {
        //    Alert.showMsg(title: RC.getValue(viewName: .pharmacy(.alert)), msg: RC.getValue(viewName: .errorMessage(.something_wrong)))
        }
        
//        if response.response?.statusCode == URLManager().VALIDATION_ERROR {
//            Alert.showMsg(title: ApiErrorMessage.VALIDATION_ERROR, msg: parsedMessage?.message ?? ConstantText.INVALID_VALIDATION)
//        }
//        
//        if response.response?.statusCode == URLManager().FORBIDDEN {
//            Alert.showMsg(msg: error.localizedDescription)
//        }
//        
//        if response.response?.statusCode == URLManager().NOT_FOUND {
//            Alert.showMsg(msg: error.localizedDescription)
//        }
//        
        if response.response?.statusCode == URLManager().UNAUTHENTICATED {
         //   Alert.showMsg(title: ApiErrorMessage.VALIDATION_ERROR, msg: parsedMessage?.message ?? ConstantText.UNAUTHENTICATED)
            AppHelper.deleteDatabase()
            Bootstrapper.createSetupView()
            
        }
//      
//        if response.response?.statusCode == URLManager().UNPROCESS_ENTITY {
//            Alert.showMsg(msg: error.localizedDescription)
//        }
        
    }
}



// MARK: - Helper methods
extension APIManager {
    
    //set progress and text of progress view
    func setProgressProgress(_ fractionCompleted: Float) {
        
        self.progressView?.progress = Float(fractionCompleted)
        self.progressLabel?.text = String(format: "Uploading Image %.0f%%", fractionCompleted * 100)
    }
    
    //return top window
    func returnTopWindow() -> UIWindow {
        
        let windows: [UIWindow] = UIApplication.shared.windows
        
        for topWindow: UIWindow in windows {
            if topWindow.windowLevel == UIWindow.Level.normal {
                return topWindow
            }
        }
        return UIApplication.shared.keyWindow!
    }
    
    //return merge headers
    /*func mergeWithCommonHeaders(_ headers: [String : String]?) -> Dictionary<String, String> {
     
     if headers != nil {
     for header in headers! {
     APIManager.sharedInstance.commonHeaders[header.key] = header.value
     }
     }
     return APIManager.sharedInstance.commonHeaders
     }*/
}

// navigate app on token unauthentication
extension APIManager {
    
    func navigateToLogin() {
        let realm = try? Realm()
        try? realm?.write {
            realm?.deleteAll()
        }
        
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        printNgi(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        
     //   router.preLoginAsRoot()
    }
    
}

extension APIManager {
    
    func getstatusCode(apiStatus: Int) -> Int {
        
        let requestStatus = apiStatus.status
        switch requestStatus {
        case .success:
            return 1
        case .unauthorized:
            return 0
        case .validation:
            return 0
        case .failure:
            return 0
        case .serverError:
            return 500
        case .unknown:
            return 0
        case .alreadyBooked:
            return 0
        }
    }
    
}

enum HttpStatusCode {
    case success, unauthorized, validation, failure, serverError, unknown, alreadyBooked
}

extension Int {
    var status: HttpStatusCode {
        switch self {
        case 200...299:
            return .success
//        case 401:
//            return .failure // unauthorized
//        case 422:
//            return .failure // validation
//        case 409:
//            return .failure // alreadyBooked
        case 400...499:
            return .failure
        case 500...599:
            return .serverError
        default:
            return .unknown
        }
    }
}
