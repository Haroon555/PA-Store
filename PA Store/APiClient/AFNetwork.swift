//
//  AFNetwork.swift

import UIKit
import Alamofire
//import MOLH

//main class
public class AFNetwork: NSObject {
    
    // MARK: constant and variable
    //manager
    public var alamoFireManager: Alamofire.SessionManager!
    public var failureMessage = "Unable to connect to the internet"
    public var isFirstIndex = true
    
    let baseVC = BaseViewController()
    //network
    public var baseURL = DEFAULT_CONFIG.baseUrl
    public var commonHeaders: Dictionary<String, String> = [
        "Authorization": "",
         "Accept": "application/json"
    ]
    
    //spinner
    struct SpinnerViewConfig {
        static let tag: Int = 98272
        static let color = UIColor.init(named: ConstantText.THEMECOLOR)
    }
    
    //progress view
    public var progressLabel: UILabel?
    var progressView: UIProgressView?
    struct ProgressViewConfig {
        static let tag: Int = 98273
        static let color = UIColor.white
        static let labelColor = UIColor.init(hexString: "#CE9825")
        static let trackTintColor = UIColor.init(hexString: "#CE9825")
        static let progressTintColor = UIColor.init(hexString: "#CE9825")
    }
    
    //shared Instance
    public static let shared: AFNetwork = {
        let instance = AFNetwork()
        return instance
    }()
    
    // MARK: - : override
    override init() {
        alamoFireManager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default
        )
        alamoFireManager.session.configuration.timeoutIntervalForRequest = 120
    }
    
    //setupSSL
    public func setupSSLPinning(_ fileNameInBundle: String) {
        
        // Set up certificates
        let pathToCert = Bundle.main.path(forResource: fileNameInBundle, ofType: "crt")
        let localCertificate = NSData(contentsOfFile: pathToCert!)
        let certificates = [SecCertificateCreateWithData(nil, localCertificate!)!]
        
        // Configure the trust policy manager
        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
            certificates: certificates,
            validateCertificateChain: true,
            validateHost: true
        )
        
        let serverTrustPolicies = [
            AFNetwork.shared.baseURL.getDomain() ?? AFNetwork.shared.baseURL: serverTrustPolicy
        ]
        
        alamoFireManager =
            Alamofire.SessionManager(
                configuration: URLSessionConfiguration.default,
                serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }
}

// MARK: - Request
extension AFNetwork {
    
    //general request
    public func apiRequest(_ info: AFParam, isSpinnerNeeded: Bool, success:@escaping (Data?) -> Void, failure:@escaping (Error) -> Void) {
        
        if info.params != nil {
            
            for (key, value) in info.params! {
                
                print(key)
                print(value)
                
            }
        }
        //if spinner needed
        if isSpinnerNeeded {
            DispatchQueue.main.async {
                AFNetwork.shared.showSpinner()
            }
        }
        //URLEncoding(destination: .methodDependent)
        //request
        alamoFireManager.request(self.baseURL + info.endpoint,
                                 method: info.method, parameters: info.params,
                                 encoding: info.parameterEncoding,
                                 headers: mergeWithCommonHeaders(info.headers)).responseJSON { (response) -> Void in
            
            //remove spinner
            if isSpinnerNeeded {
                DispatchQueue.main.async {
                    AFNetwork.shared.hideSpinner()
                }
            }
            
            //check response result case
            switch response.result {
            case .success:
                print(response)
                success(response.data)
            case .failure:
                let error: Error = response.result.error!
                debugPrint("responseError: \(error)")
                Alert.showMsg(msg: error.localizedDescription)
                failure(error)
            }
        }
    }
    
    //file upload
    func apiRequestUpload(_ info: AFParam, isSpinnerNeeded: Bool, success:@escaping (Data?) -> Void, failure:@escaping (Error) -> Void) {
        
        //if spinner needed
        if isSpinnerNeeded {
            DispatchQueue.main.async {
                AFNetwork.shared.showSpinner()
            }
        }
        
        let URL = try! URLRequest(url: self.baseURL + info.endpoint, method: info.method, headers: mergeWithCommonHeaders(info.headers))
        
        print(URL)
        
        alamoFireManager.upload(multipartFormData: { (multipartFormData) in
            
            //multipart params
            if info.params != nil {
                
                for (key, value) in info.params! {
                    
                    print(key)
                    print(value)
               
                    //--FM
                    if let tagsArray = value as? [String] {
                        
                        let stringsData = NSMutableData()
                        for tag in tagsArray {
                            if let stringData = tag.data(using: .utf8) {
                                stringsData.append(stringData)
                            }
                        }
                        multipartFormData.append(stringsData as Data, withName: key)
                    }
                    else if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }
            
            //multipart images
            if info.images != nil {
                if !(info.images!.isEmpty) {
                    
                    for value in info.images! {
                        let imageData = value.pngData() as Data?
                        if imageData != nil {
                            multipartFormData.append(imageData!, withName: "image", fileName: "file.png", mimeType: "image/png")
                        }
                    }
                }
            }
            
            print(multipartFormData)
            
        }, with: URL, encodingCompletion: { (result) in
            
            //remove spinner
            
            switch result {
            case .success(let upload, _, _):
                upload
                    .uploadProgress { progress in
                        
                        //set progress view
                        
                        print(Float(progress.fractionCompleted))
                        self.setProgressProgress(Float(progress.fractionCompleted))
                        
                    }
                    .validate()
                    .responseJSON { response in
                        
                        print(response.request)
                        if isSpinnerNeeded {
                            DispatchQueue.main.async {
                                AFNetwork.shared.hideSpinner()
                            }
                        }
                        
                        //set progress view
                        self.setProgressProgress(1.0)
                        
                        switch response.result {
                        case .success(let value):
                            
                            print(value)
                            
                            if let result = response.result.value {
                                success(response.data)
                            } else {
                                success(response.data)
                            }
                        case .failure(let responseError):
                            
                            print("responseError: \(responseError)")
                            Alert.showMsg(msg: responseError.localizedDescription)
                            failure(responseError)
                        }
                }
            case .failure(let encodingError):
                failure(encodingError)
            }
        })
    }
    
    func apiGeneric<T : Decodable> (_ param: AFParam, modelType: T.Type,
                                    isShowSpinner: Bool = true, completion: @escaping (T) -> Void) {
        
        //request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: isShowSpinner, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(modelType.self, from: data)
                
                //  if result.code == ServiceCodes.successCode
                // {
                
                completion(result)
                
                // }
                /*else
                 {
                 AlertClass.showError(msg : result.message ?? "Server Not responding")
                 
                 }*/
                
            } catch let error {
                print("Error: ", error)
            }
            
        }) { (error) in
            
        }
    }
    
    func apiForMultiPart<T : Decodable> (_ param: AFParam, modelType: T.Type, isShowSpinner: Bool = true, completion: @escaping (T) -> Void) {
        
        //request
        AFNetwork.shared.apiRequestUpload(param, isSpinnerNeeded: isShowSpinner, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(modelType.self, from: data)
                
                completion(result)
                
            } catch let error {
                print("Error: ", error)
            }
            
        }) { (error) in
            
        }
    }
}

// MARK: - Progress and spinner methods
extension AFNetwork {
    
    public func showProgressView(_ customView: UIView?) {
        
        var window = customView
        
        if (window == nil) {
            window = returnTopWindow()
        }
        if window?.viewWithTag(ProgressViewConfig.tag) != nil {
            return
        }
        
        let backgroundView = UIView(frame: CGRect.zero)
        backgroundView.tag = ProgressViewConfig.tag
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.clear.withAlphaComponent(0.7)
        
        let progressContainer = UIView()
        progressContainer.translatesAutoresizingMaskIntoConstraints = false
        progressContainer.backgroundColor = UIColor.clear
        
        progressLabel = UILabel()
        progressLabel?.translatesAutoresizingMaskIntoConstraints = false
        progressLabel?.textColor = ProgressViewConfig.labelColor
        progressLabel?.text = "Upload progress 0%"
        progressLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.bold)
        progressLabel?.adjustsFontSizeToFitWidth = true
        progressLabel?.textAlignment = .center
        progressContainer.addSubview(progressLabel!)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView?.translatesAutoresizingMaskIntoConstraints = false
        progressView?.progressTintColor = ProgressViewConfig.progressTintColor
        progressView?.trackTintColor = ProgressViewConfig.color
        progressView?.progress = 0.0
        progressContainer.addSubview(progressView!)
        
        progressContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[progressView]-(10)-[progressLabel]|",
                                                                        options: [], metrics: nil, views: ["progressLabel": progressLabel!, "progressView": progressView!]))
        progressContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[progressView(200)]|",
                                                                        options: [], metrics: nil, views: ["progressView": progressView!]))
        progressContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[progressLabel]|",
                                                                        options: [], metrics: nil, views: ["progressLabel": progressLabel!]))
        backgroundView.addSubview(progressContainer)
        
        backgroundView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .centerY, relatedBy: .equal,
                                                        toItem: progressContainer, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        backgroundView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .centerX, relatedBy: .equal,
                                                        toItem: progressContainer, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        window?.addSubview(backgroundView)
        window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[backgroundView]|", options: [],
                                                              metrics: nil, views: ["backgroundView": backgroundView]))
        window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundView]|", options: [],
                                                              metrics: nil, views: ["backgroundView": backgroundView]))
    }
    
    //hide progress view
    public func hideProgressView() {
        
        let window: UIWindow? = returnTopWindow()
        window?.viewWithTag(ProgressViewConfig.tag)?.removeFromSuperview()
        progressLabel = nil
        progressView = nil
    }
    
    //show spinner
    public func showSpinner() {
        DispatchQueue.main.async {
            let window: UIWindow = self.returnTopWindow()
            window.isUserInteractionEnabled = false
            SVProgressHUD.setForegroundColor(.themeColor)
            SVProgressHUD.setBackgroundColor(.clear)
            SVProgressHUD.show()
        }
    }
    
    //hide spinner
    public func hideSpinner() {
        let window: UIWindow = self.returnTopWindow()
        window.isUserInteractionEnabled = true
        SVProgressHUD.dismiss()
    }
}

// MARK: - Helper methods
extension AFNetwork {
    
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
    func mergeWithCommonHeaders(_ headers: [String : String]?) -> Dictionary<String, String> {
        
        if headers != nil {
            for header in headers! {
                AFNetwork.shared.commonHeaders[header.key] = header.value
            }
        }
        return AFNetwork.shared.commonHeaders
    }
}

class Internet {
    class var isConnected: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
