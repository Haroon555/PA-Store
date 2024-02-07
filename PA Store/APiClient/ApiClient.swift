//
//  APIClient.swift
//  HomeMedics
//
//  Created byDevBatch on 19/06/2017.
//  Copyright © 2017DevBatch. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

let APIClientDefaultTimeOut = 40.0

let APIClientBaseURL = kStagingBaseUrl

class APIClient: APIClientHandler {
    
    fileprivate var clientDateFormatter: DateFormatter
    var manager: NetworkReachabilityManager?
    
    static let sharedClient: APIClient = {
        let baseURL = URL(string: APIClientBaseURL)
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = APIClientDefaultTimeOut
        
        let instance = APIClient(baseURL: baseURL!, configuration: configuration)
        
        return instance
    }()
    
    // MARK: - init methods
    
    override init(baseURL: URL, configuration: URLSessionConfiguration, delegate: SessionDelegate = SessionDelegate(), serverTrustPolicyManager: ServerTrustPolicyManager? = nil) {
        clientDateFormatter = DateFormatter()
        
        super.init(baseURL: baseURL, configuration: configuration, delegate: delegate, serverTrustPolicyManager: serverTrustPolicyManager)
        
        //        clientDateFormatter.timeZone = NSTimeZone(name: "UTC")
        clientDateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    // MARK: Helper methods
    
    func apiClientDateFormatter() -> DateFormatter {
        return clientDateFormatter.copy() as! DateFormatter
    }
    
    fileprivate func normalizeString(_ value: AnyObject?) -> String {
        return value == nil ? "" : value as! String
    }
    
    fileprivate func normalizeDate(_ date: Date?) -> String {
        return date == nil ? "" : clientDateFormatter.string(from: date!)
    }
    
    @discardableResult
    func logInUser(phone: String, password: String, isDoctor: Bool, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = isDoctor ? "doctorLogin" : "userLogin"
        let parameters = [
            "phone"     :   phone,
            "password"  :   password
            ] as [String:AnyObject]
        
         return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func signUpUser(fullName: String, email: String, phone: String, password: String, gender: String ,_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "userRegister"
        
        let parameters = [
            
            "full_name" :   fullName,
            "email"     :   email,
            "phone"     :   phone,
            "password"  :   password,
            "gender"    :   gender
            
            ] as [String:AnyObject]
        
        return sendRequest(serviceName, parameters: parameters
            , isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func sendFirstTimeDownloadCheckOnServer(_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "create_downloads"
        let params = [
            "device_id": UIDevice.current.identifierForVendor?.uuidString ?? ""
        ]
        
        return sendRequest(serviceName, parameters: params as [String : AnyObject], isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getBanner(_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "banner_images"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getInDemandProduct(_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "in_demand_products"
        
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func checkApiVersion(_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "about"
        
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }    
    
    @discardableResult
    func getCities(province: String,_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "get_cities?get_all_city=1"
//        if !province.isEmpty {
//            serviceName.append("&province=\(province)")
//        }
        
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func signOut(_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "logout"

        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func forgotPassword(phone: String, isCorporate: Bool, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "userForgotPassword"
        
        let parameters = [
            
            "phone"     :   phone,
            "isCorporate": isCorporate ? "1" : "0",
            
            ] as [String:AnyObject]
        
        return sendRequest(serviceName, parameters: parameters
            , isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func doSetNewPass(userId: Int, code: String, password: String, isCorporate: Bool, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "userResetPassword"
        
        let parameters = [
            
            "user_id"     :   userId,
            "reset_code"     :   code,
            "new_password"     :   password,
            "isCorporate": isCorporate ? "1" : "0",
            
            ] as [String:AnyObject]
        
        return sendRequest(serviceName, parameters: parameters
            , isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getNotifications(pageNo: Int,limit: Int,_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "get_notifications?page=\(pageNo)&limit=\(limit)"
        
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getUserProfile(_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "get_profile"
        
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    /*
    @discardableResult
    func getCorporateUserProfile(_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "corporate_user_profile"
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
     */
    
    
    @discardableResult
    func applyCuoponCode(cuoponCode: String,_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "check_promotion?coupon_code=\(cuoponCode)"
        
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func resendActivationCode(userId: Int, isCorporate: Bool, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "userResendCode"
        
        let parameters = [
            
            "user_id"     :   userId,
            "isCorporate": isCorporate ? "1" : "0",
            ] as [String:AnyObject]
        
        return sendRequest(serviceName, parameters: parameters
            , isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getOrderHistroy(page: Int, limit: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "order_history_med?page=\(page)&limit=\(limit)"
        
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getServiceHistroy(page: Int, limit: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "serviceOrderHistory?page=\(page)&limit=\(limit)"
        
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    @discardableResult
    func getRentalServices(page: Int, limit: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "rental_history?page=\(page)&limit=\(limit)"
        
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func rentalServiceOrder(cityId: Int,_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "get_all_rental?city_id=\(cityId)"
        
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getLabCategories(labId: Int, pageNo: Int, limit: Int, needPopularCategories: Bool, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "test_category_list?lab_id=\(labId)&page=\(-1)&limit=\(10000)&in_popular=\(needPopularCategories ? 1 : 0)"
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getLabList(cityId: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "labs_list?city_id=\(cityId)"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getAllLabList(serviceName: String, cityId: Int, lat: String, lng: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "pharmacy/\(serviceName)"
        
        let parameters = [ "lat" : lat, "lng": lng, "city_id": cityId] as [String:AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func updateUserProfile(name : String, email : String, avatar: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "edit_profile"
        let parameters = [
            "full_name"     :   name,
            "email"         :   email
            
            ] as [String:AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func submitOrderService(cityId: Int,serviceId : Int, comments : String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "order_service"
        let parameters = [
            "service_id"    :   serviceId,
            "comment"       :   comments,
            "city_id"       :   cityId
            
            ] as [String:AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func submitRentalOrderService(cityId: Int,equipmentId : Int, comments : String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "order_rent"
        let parameters = [
            "equipment_id"    :   equipmentId,
            "comment"       :   comments,
            "city_id"       :   cityId
            ] as [String:AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    //Medical Equipment
    @discardableResult
    func getMedicalEquipments(pageNo: Int, limit: Int,_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "medical_equipment?page=\(pageNo)&limit=\(limit)"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    //test_list
    
    @discardableResult
    func getTestList(page: Int, limit: Int, labId: Int, categroyId : Int,  _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "test_list?page=\(page)&limit=\(limit)&lab_id=\(labId)&category_id=\(categroyId)"
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    //get_medicine_categories
    
    @discardableResult
    func getMedicineCategory (page: Int, limit: Int,  _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "get_medicine_categories?limit=\(limit)&page=\(page)"
        
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    //Search Test
    @discardableResult
    func getMedicineList (categoryId: Int, page: Int, limit: Int,  _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "medicines_list?category_id=\(categoryId)&limit=\(limit)&page=\(page)"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func searchEquipmentList (searchItem: String,cityId: Int, page: Int, limit: Int,  _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "search_medical_equipment?equipment_name=\(searchItem)&city_id=\(cityId)&limit=\(limit)&page=\(page)"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func searchFromPharmacy (searchItem: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "search_medicine?medicine_name=\(searchItem)"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func searchMedicineById (searchItem: String, categoryId: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "search_medicine?medicine_name=\(searchItem)&cat_id=\(categoryId)"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func searchTests (searchItem: String, labId: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "search_test?test_name=\(searchItem)&lab_id=\(labId)"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func placeNewOrder(totalAmount: String, paymentMethod: String, deliveryType: String, billingModel: UserAddress, shippingModel: UserAddress , _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "placeNewOrder"
        
        let cartOrders = Cart.shared.getCartItems()
        let cartOrdersArray = cartOrders.map({[
            "product_id": $0.productId,
            "product_type": $0.productType,
            "quantity": $0.quantity
            ]})
        
        let parameters = [
            
            "total_amount": totalAmount,
            "delivery_type_id": deliveryType,
            "payment_method_id": paymentMethod,
            "order": cartOrdersArray,
            "shipping": [
                "first_name": shippingModel.firstName,
                "last_name": shippingModel.lastName,
                "phone": shippingModel.mobileNumber,
                "email": shippingModel.email,
                "home_address": shippingModel.address,
                "province": shippingModel.province,
                "city": shippingModel.city
            ],
            "billing": [
                "first_name": billingModel.firstName,
                "last_name": billingModel.lastName,
                "phone": billingModel.mobileNumber,
                "email": billingModel.email,
                "home_address": billingModel.address,
                "province": billingModel.province,
                "city": billingModel.city,
            ]
            
            
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
        
    }
    
    @discardableResult
    func cashOnDelivery(totalAmount: String, paymentMethod: String, deliveryType: String, billingModel: UserAddress, shippingModel: UserAddress , _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "placeNewOrder"
        
        let cartOrders = Cart.shared.getCartItems()
        let cartOrdersArray = cartOrders.map({[
            "product_id": $0.productId,
            "product_type": $0.productType,
            "quantity": $0.quantity
            ]})
        
        let parameters = [
            
            "total_amount": totalAmount,
            "delivery_type_id": deliveryType,
            "payment_method_id": paymentMethod,
            "order": cartOrdersArray,
            "shipping": [
                "first_name": shippingModel.firstName,
                "last_name": shippingModel.lastName,
                "phone": shippingModel.mobileNumber,
                "email": shippingModel.email,
                "home_address": shippingModel.address,
                "province": shippingModel.province,
                "city": shippingModel.city
            ],
            "billing": [
                "first_name": billingModel.firstName,
                "last_name": billingModel.lastName,
                "phone": billingModel.mobileNumber,
                "email": billingModel.email,
                "home_address": billingModel.address,
                "province": billingModel.province,
                "city": billingModel.city,
            ]
            
            
            ] as [String : AnyObject]
        print(parameters)
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)

    }
    
    @discardableResult
    func setDeviceId(deviceID: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "set_player_id"
        let voipToken = UserDefaults.standard.value(forKey: "kDeviceTokenData") as? String ?? ""
        let parameters = [
            "player_id": deviceID,
            "role": User.shared.roleTypeString(),
            "device_token": voipToken,
            "type": "IOS",
//            "environment": "development"
            "environment": "production"
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func addBillingInfo(firstName: String, lastName: String, phone: String, address: String, province: String, city: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "add_billing_details"
        
        let parameters = [
            "first_name" : firstName,
            "last_name" : lastName,
            "phone" : phone,
            "home_address" : address,
            "province" : province,
            "city" : city
            
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func addShippingInfo(firstName: String, lastName: String, phone: String, address: String, province: String, email: String, city: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "add_or_update_shipping_details"
        
        let parameters = [
            "first_name" : firstName,
            "last_name" : lastName,
            "phone" : phone,
            "email" : email,
            "home_address" : address,
            "province" : province,
            "city" : city
            
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getShippingDetails(_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "get_shipping_details"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getBillingDetails(_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "get_billing_details"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func paymentAuth(method: String, orderId: String, totalAmount: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "paymentauth?method=\(method)&total_amount=\(totalAmount)&order_id=\(orderId)"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func easyPaisaPaymentAuth(orderId: String, totalAmount: String,type: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "easypaisa/checkout"
        let parameters = [
            
            "order_number": orderId,
            "type" : type,
            "total_amount" : totalAmount,
            
        ]
        
        return sendRequest(serviceName, parameters: parameters as [String : AnyObject], isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getMedicalServicesList(cityId: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "home_medical_services_list?city_id=\(cityId)"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getTeleConsultantServiceOrder(cityId: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "order_service_tele_consultant"
        let parameters = ["city_id": "\(cityId)"]
        return sendRequest(serviceName, parameters: parameters as [String : AnyObject], isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func deleteTeleConsultantServiceOrder(orderNumber: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "delete_order?order_number=\(orderNumber)"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func doSignup(email: String, firstName: String, phoneNumber: String, gender: String, dob: String, password: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "signup"
        let parameters = [
            
            "email": email,
            "full_name": firstName,
            "phone" : phoneNumber,
            "gender": gender,
            "dob" : dob,
            "password" : password
        ]
        return sendRequest(serviceName, parameters: parameters as [String : AnyObject], isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    //SocialSignUp- Facebook
    @discardableResult
    func socialSignIn(email: String, full_name: String, social_access_token: String, social_id: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "userSocialSignup"
        let parameters = [
            
            "email": email,
            "full_name" : full_name,
            "social_access_token" : social_access_token,
            "social_id" : social_id
        ]
        return sendRequest(serviceName, parameters: parameters as [String : AnyObject], isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func fbSignInWithCompleteInfo(userId: Int,phone: String,gender: String, isCorporate: Bool, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "socialPhoneVerification"
        let parameters = [
            
            "phone": phone,
            "id"   : userId,
            "gender" : gender,
            "is_corporate": isCorporate ? 1 : 0
            ] as [String : Any]
        return sendRequest(serviceName, parameters: parameters as [String : AnyObject], isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    //Verify Account
    @discardableResult
    func accountVerify(userId: Int, code: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let serviceName = "userActivate"
        let parameters = [
            
            "user_id": userId,
            "code": code,
            "device_id": UIDevice.current.identifierForVendor?.uuidString ?? ""
            
            ] as [String : Any]
        return sendRequest(serviceName, parameters: parameters as [String : AnyObject], isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func confirmOrder(orderNumber: String, status: Int,paymentMethodId: Int, isService: Bool, isRental: Bool, discountedAmount: Double = 0, isUsingCreditAmount: Bool, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "confirmUserOrder"
        let parameters = [
        
            "order_number": orderNumber,
            "status" : status,
            "payment_method_id" : paymentMethodId,
            "rental" : isRental,
            "service" : isService,
            "discountAmount": discountedAmount,
            "isCredit": isUsingCreditAmount
            
        ]  as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func confirmPromotion(code: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "confirm_promotion"
        let parameters = [
            
            "coupon_code": code
            
            ]  as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getPopularTest(_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "in_demand_test_cat"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    @discardableResult
    func getPopularServices(page: Int, limit: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "home_medical_services_list?limit=\(limit)&page=\(page)"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    @discardableResult
    func getPopularEquip(page: Int, limit: Int,_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "in_demand_equipment?limit=\(limit)&page=\(page)"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getOtherMedicines( page: Int, limit: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "other_medicines?limit=\(limit)&page=\(page)"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getSearchOtherMedicine(medicineName: String,  _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "search_other_medicines?medicine_name=\(medicineName)"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func setDoctorAsAvailable(_ isAvailable: Bool, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "doctorAvailablity"
        let parameters = [
            "is_available": isAvailable ? 1 : 0
        ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getDoctorCategories(page: Int, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "getDoctorCategory?page=\(page)&limit=30"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getDoctorsByCategory(_ categoryID: Int, page: Int, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "getDoctorByCategory?page=\(page)&limit=20&category_id=\(categoryID)"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func searchDoctorsByName(inCategory catID: Int, searchText: String, page: Int, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        var serviceName = "searchDoctor?&name=\(searchText)&page=\(page)&limit=20"
        if catID > 0 {
            serviceName += "&category_id=\(catID)"
        }
        
        serviceName = serviceName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getDoctorById(_ id: Int, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "getDoctorById?id=\(id)"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getDoctorTimeSlots(docId: Int, date: Date, weekday: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "getDoctorTimeslot?id=\(docId)&date=\(date.timeIntervalSince1970)&day=\(weekday)"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getDoctorInstantAvailability(docId: Int, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "getInstantAppointment?doctor_id=\(docId)&start_date=\(Utility.getStartOfDate(Date()).timeIntervalSince1970)&end_date=\(Utility.getEndOfDate(Date()).timeIntervalSince1970)"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func saveDoctorTimeSlots(docId: Int, selectedDays: [String], timeSlots: [String], completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "saveDoctorTimeslot"
        let timeSlotDict = [
            "days": selectedDays,
            "time": timeSlots
        ]
        
        var jsonEncodedString = ""
        if let data = try? JSONSerialization.data(withJSONObject: timeSlotDict, options: .prettyPrinted) {
            jsonEncodedString = String(data: data, encoding: .utf8) ?? ""
        }
        
        let parameters = [
            "id": docId,
            "time_slot": jsonEncodedString
        ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func bookAppointment(docId: Int, date: Date, timeSlot: String, isInstant: Bool, discountPercent: Int, amount: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "saveUserAppointment"
        var parameters = [
            "doctor_id": docId,
            "date": date.timeIntervalSince1970,
            "time": timeSlot,
            "day": Utility.getDayAndWeekdayFromDate(date).fullWeekday,
            "type": isInstant ? "instant" : "normal",
            "amount": amount
            ] as [String : AnyObject]
        
        if User.shared.isCorporateUser && User.shared.corporateUserType == .discount {
            parameters["is_corporate"] = 1 as AnyObject
            parameters["is_discount"] = 1 as AnyObject
            parameters["discount_percent"] = discountPercent as AnyObject
        }
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getDoctorReviews(docId: Int, page: Int, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "getReviewById?id=\(docId)&page=\(page)&limit=20"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func saveReview(docId: Int, rating: Int, review: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "saveReview"
        let parameters = [
            "id": docId,
            "rating": rating,
            "review" : review
        ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getAppointments(startDate: Date?, endDate: Date?, page: Int, needSingleList: Bool, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        var serviceName = "getAppointment?page=\(page)&limit=20&role=\(User.shared.roleTypeString())&is_both=\(needSingleList ? 0 : 1)"
        if let sDate = startDate, let eDate = endDate {
            serviceName += "&start_date=\(Utility.getStartOfDate(sDate).timeIntervalSince1970)&end_date=\(Utility.getEndOfDate(eDate).timeIntervalSince1970)"
        } else {
            serviceName += "&start_date=&end_date="
        }
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func sendVOIPPushNotification(to userID: Int, fromID: Int, fromName: String, appointmentID: Int, roomName: String, event: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "sendPushNotification"
        
        var parameters = [
            "user_id": userID,
            "opponentsID": "\(fromID)",
            "contactIdentifier": fromName,
            "roomName": roomName,
            "eventName": event
            ] as [String : AnyObject]
        
        if appointmentID > 0 {
            parameters["appointment_id"] = appointmentID as AnyObject
        }
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func completeAppointment(appointmentId: Int, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "completeUserAppointment"
        let parameters = [
            "appointment_id": appointmentId,
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func    createDoctorPrescription(appointmentId: Int, user_id: Int, familyMemberId: Int, complaints: String, history: String, age: String, treatment: String, investigation: String, advice: String, rating:Int, markAsCompleted: Bool, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "doctorPrescription"
        var parameters = [
            "appointment_id": appointmentId,
            "user_id": user_id,
            "family_member_id": familyMemberId,
            "complaints": complaints.replacingOccurrences(of: "\n", with: "\\n"),
            "history": history.replacingOccurrences(of: "\n", with: "\\n"),
            "age": age.replacingOccurrences(of: "\n", with: "\\n"),
            "treatment": treatment.replacingOccurrences(of: "\n", with: "\\n"),
            "investigation": investigation.replacingOccurrences(of: "\n", with: "\\n"),
            "advice": advice.replacingOccurrences(of: "\n", with: "\\n"),
            "rating": rating,
            "is_completed": markAsCompleted ? 1 : 0,
            ] as [String : AnyObject]
        
        if showEMR {
            parameters["is_emr"] = 1 as AnyObject
        }
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getTwilioAccessToken(completionBlock: @escaping APIClientCompletionHandler) -> Request {
        var email = User.shared.email
        if email == "" {
            email = "harami@bnanyWala.com"
        }
        
        let serviceName = "genrateTokenTwilio?identifier=\(email)"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getCorporateFamilyTree(serviceName: String, isPostReq: Bool, completionBlock: @escaping APIClientCompletionHandler) -> Request {
//        let serviceName = "allianzFamilyTree"
        let parameters = [
            "policy_no": User.shared.corporatePolicyNumber,
            "cert_id": User.shared.corporateCertificateId
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: isPostReq, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getCorporateBalance(serviceName: String, isPostReq: Bool, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        return sendRequest(serviceName, parameters: nil, isPostRequest: isPostReq, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func addDarazTransaction(amount: Double, orderNumber: Int, familyMemberId: Int, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "daraz/addTransaction"
        let parameters = [
            "amount": amount,
            "order_number": orderNumber,
            "Family_member_id": familyMemberId,
            ] as [String : AnyObject]
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func bookCorporateTransaction(amount: Double, creditUserSelectedMemberName: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "corporate_book_transaction"
        let parameters = [
            "bill_amount": amount,
            "transaction_date": Utility.getDateString(fromDate: Date(), format: "dd-MMM-yyyy"),
            "name": creditUserSelectedMemberName
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func completeCorporateTransaction(_ trasactionID: String, creditUserSelectedMemberName: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "corporate_complete_transaction"
        let parameters = [
            "transaction_id": trasactionID,
            "name": creditUserSelectedMemberName
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func cancelCorporateTransaction(_ trasactionID: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "corporate_cancel_transaction"
        let parameters = [
            "transaction_id": trasactionID
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    func uploadImage1(image: UIImage, _ completionBlock: @escaping (_ success: Bool,_ json: [String:Any]?) -> Void ) {
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: "image", fileName: "image.jpeg" , mimeType: "image/*")
        }, to: URL(string: "\(kStagingBaseUrl)upload_profile_picture")!) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                upload.responseJSON { response in
                    if let json = response.result.value as? [String:Any] {
                        print(json)
                        completionBlock(true, json)
                    }
                }
            case .failure(let encodingError):
                completionBlock(false, nil)
            }
        }
    }
    
    func uploadImage(image: UIImage, _ completionBlock: @escaping (_ success: Bool, _ response: AnyObject?) -> Void ) {
        
        guard let url = URL(string: "\(kStagingBaseUrl)upload_profile_picture") else {
            return
        }
        
        var token = ""
        if Utility.isKeyPresentInUserDefaults(key: kToken) {
            token = UserDefaults.standard.object(forKey: kToken) as! String
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: "image", fileName: "image.jpeg" , mimeType: "image/*")
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("proses", progress.fractionCompleted)
                })
                
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let err = response.error {
                        print("upload:", err)
                        completionBlock(true, response.result.value! as AnyObject)
                        
                    }
                    
                    if let s = response.result.value {
                        print("RESULT:", s)
                        completionBlock(true, response.result.value as AnyObject?)
                        
                    }
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                completionBlock(false, error as AnyObject)
            }
        }
    }
    
    
    //MARK: - Health Records
    
//    func uploadPerscription(fullName: String, phoneNumber: String, email: String, image: UIImage, prescriptionFor: String, _ completionBlock: @escaping (_ errorString: String?) -> Void){
    func uploadPerscription(apiUrl: String, image: UIImage, imageKey: String, parameters: [String: Any], _ completionBlock: @escaping (_ errorString: String?) -> Void){
        guard let url = URL(string: "\(kStagingBaseUrl)\(apiUrl)") else {
            return
        }
        
        var token = ""
        if Utility.isKeyPresentInUserDefaults(key: kToken) {
            token = UserDefaults.standard.object(forKey: kToken) as! String
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: imageKey, fileName: "image.jpeg" , mimeType: "image/*")
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("proses", progress.fractionCompleted)
                })
                
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    
                    if let err = response.error {
                        print("upload:", err)
                        completionBlock(err.localizedDescription)
                        return
                    }
                    
                    if let s = response.result.value  {
                        print("RESULT:", s)
                        
                        if let responseDict = s as? [String: Any] {
                            if let headerDict = responseDict["ResponseHeader"] as? [String: Any] {
                                if headerDict["ResponseCode"] as? Int == 200 {
                                    completionBlock(nil)
                                    return
                                }
                                else {
                                    completionBlock(headerDict["ResponseMessage"] as? String)
                                    return
                                }
                            }
                        }
                        
                        completionBlock("Invalid Data")
                    }
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                completionBlock(error.localizedDescription)
            }
        }
    }
    
    func uploadMultipleImagePerscription(apiUrl: String, isImage: Bool,image: [UIImage], imageKey: String, isVoiceNote: Bool, voiceNote: Data?, voicKey: String, parameters: [String: Any], _ completionBlock: @escaping (_ errorString: String?,_ successString: String? ,_ result: AnyObject?) -> Void){
        guard let url = URL(string: "\(kStagingBaseUrl)\(apiUrl)") else {
            return
        }
        
        var token = ""
        if Utility.isKeyPresentInUserDefaults(key: kToken) {
            token = UserDefaults.standard.object(forKey: kToken) as! String
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json",
            "Content-Type" :"text/html; charset=UTF-8"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            
            let count = image.count

            if isImage{
                for i in 0..<count{
                    multipartFormData.append(image[i].jpegData(compressionQuality: 0.5)!, withName: "\(imageKey)[\(String(i))]", fileName: "image\(String(i)).jpeg" , mimeType: "image/*")
                }
            }
            
            if isVoiceNote && voiceNote != nil{
                multipartFormData.append(voiceNote!, withName: voicKey, fileName: "myRecording.m4a" , mimeType: "audio/m4a")
            }
           
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
              upload.uploadProgress(closure: { (progress) in
                    print("proses", progress.fractionCompleted)
                })
                
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    
                    if let err = response.error {
                        print("upload:", err)
                        completionBlock(err.localizedDescription,nil ,nil)
                        return
                    }
                    
                    if let s = response.result.value  {
                        print("RESULT:", s)
                        
                        if let responseDict = s as? [String: Any] {
                            if let headerDict = responseDict["ResponseHeader"] as? [String: Any] {
                                if headerDict["ResponseCode"] as? Int == 200 {
                                    completionBlock(nil, headerDict["ResponseMessage"] as? String, responseDict["data"] as AnyObject)
                                    return
                                }
                                else {
                                    completionBlock(headerDict["ResponseMessage"] as? String, nil , headerDict["result"] as AnyObject)
                                    return
                                }
                            }
                        }
                        
                        completionBlock("Invalid Data", nil, nil)
                    }
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                completionBlock(error.localizedDescription, nil, nil)
            }
        }
    }
    @discardableResult
    func getHealthReports(reportType: String, listType: Int, page: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName: String
        
        if !showEMR && reportType == HealthReportType.prescription.api {
            if listType == 0 {
                serviceName = "get_prescription_details?page=\(page)&limit=20"
            }
            else {
                serviceName = "userPrescription?page=\(page)&limit=20"
            }
        }
        else {
            let _listType = listType == 0 ? "uploaded" : "received"
            serviceName = "getHealthReport?report_type=\(reportType)&type=\(_listType)&page=\(page)&limit=20"
        }
        
        return sendRequest(serviceName, parameters: nil , isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func deleteHealthReport(id: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "deleteReport?id=\(id)"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getHealthReportsCount(_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "getHealthNotification"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func markHealthReportsCountAsRead(reportType: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "readNotification?type=\(reportType)"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func saveVitalStats(_ stats: VitalStats, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "saveVitals"
        let parameters = [
            "time": Utility.getDateString(fromDate: stats.date, format: "yyyy-MM-dd HH:mm:ss"),
            "bp": stats.bloodPressure,
            "pulse": stats.pulseRate,
            "body_temp": stats.bodyTemprature,
            "weight": stats.weight,
            "height": stats.height,
            "blood_sugar_random": stats.sugarRandom,
            "blood_sugar_fasting": stats.sugarFasting,
            "resp_rate": stats.respirationRate,
            "sp02": stats.sp02
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getVitalStats(page: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "getVitals?page=\(page)&limit=10"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getHomeVisitList(status: HomeVisitStatus, page: Int, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "getHomeVisit?type=\(status.rawValue)&page=\(page)&limit=10"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    //MARK: - Corporate Related APIs
    
    @discardableResult
    func getCorporateList(_ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "get_all_corporate"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getCorporateSignupRequireFields(corporateName: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "corporate_fields?name=\(corporateName.lowercased())"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func corporateSignInUser(corporate: Corporate, id: Int, corporateName: String, phone: String, password: String, userName: String = "", _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "corporate_sign_in"
        let parameters = [
            "corporate_id": id,
            "corporate_name": corporateName.lowercased(),
            (corporate.otp ? "email" :"phone"):   phone,
            "password"  :   password,
            "name": userName
            ] as [String:AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func corporateSignUpUser(id: Int, fields: [CorporateTextFieldModel], _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "corporate_sign_up"
        var parameters: [String: AnyObject] = ["corporate_id": id as AnyObject]
        
        fields.forEach { (tf) in
            parameters[tf.key] = tf.text as AnyObject
        }
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getCorporateRuleSet(corporateName: String, _ completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "corporate_rule_set?name=\(corporateName.lowercased())"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getExclusionList(completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "exclusion_list"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func checkUserCanBookFreeGP(completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "checkUserGP/\(User.shared.id)"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    func sendCorporateOTP(employID: String, email: String, corporateId: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "verify_corporate_details"
        let params = [
            "employee_id": employID,
            "email": email,
            "corporate_id": corporateId
        ] as [String: AnyObject]
        
        return sendRequest(serviceName, parameters: params, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    func verifyCorporateOTP(employID: String, email: String, corporateId: String, otp: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "verify_otp_email"
        let params = [
            "employee_id": employID,
            "email": email,
            "corporate_id": corporateId,
            "otp": otp
        ] as [String: AnyObject]
        
        return sendRequest(serviceName, parameters: params, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    func sendCorporatePhoneOTP(userId: String, phone: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "send_otp_phone"
        let params = [
            "user_id": userId,
            "phone": phone
        ] as [String: AnyObject]
        
        return sendRequest(serviceName, parameters: params, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    func sendCorporatePhoneOTPWithUser(corporateId: String, phone: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "phone_otp"
        let params = [
            "corporate_id": corporateId,
            "phone": phone
        ] as [String: AnyObject]
        
        return sendRequest(serviceName, parameters: params, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    func verifyCorporatePhoneOTP(userId: String,  otp: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "verify_otp_phone"
        let params = [
            "user_id": userId,
            "otp": otp
        ] as [String: AnyObject]
        
        return sendRequest(serviceName, parameters: params, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    func setPasswordForOTPCorporate(userId: String,corporateId: String ,fields: [CorporateTextFieldModel], completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "otp_corporate_set_password"
        
//        fields.forEach { (tf) in
//            parameters[tf.key] = tf.text as AnyObject
//        }
        let passwordTxt = fields.first(where: {$0.key == "password"})
        let genderTxt = fields.first(where: {$0.key == "gender"})
        let params = [
            "user_id": userId,
            "corporate_id": corporateId,
            "password": passwordTxt?.text,
            "gender": genderTxt?.text
        ] as [String: AnyObject]
        
        return sendRequest(serviceName, parameters: params, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getFamilyMembers(completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "daraz/getFamilyMembers"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getFamilyMembersById(id: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "getFamilyMembersById?id=\(id)"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    func addFamilyMember(name: String, relation: String, date: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "corporate/addFamilyMembers"
        
        let params = [
            "name": name,
            "relation": relation,
            "dob": date
        ] as [String: AnyObject]
        
        return sendRequest(serviceName, parameters: params, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    func veifyCNIC(cnic: String, corporate_id: Int, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "find/cnic"
        
        let params = [
            "cnic": cnic,
            "corporate_id": corporate_id
        ] as [String: AnyObject]
        
        return sendRequest(serviceName, parameters: params, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    func phoneChangeRequest(user_id: String, phone: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "change/phone"
        
        let params = [
            "user_id": user_id,
            "phone": phone
        ] as [String: AnyObject]
        
        return sendRequest(serviceName, parameters: params, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    //MARK: - Select Pharmacy Related APIs
    
    @discardableResult
    func getAllPharmacies(completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "pharmacy/getAllPharmacies"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func pharmacySaveVisit(pharmacyId: Int, visitType: String, familyMemberId: Int, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "pharmacy/saveVisit"
        let params = [
            "outlet_id": pharmacyId,
            "visit_type": visitType,
            "family_member_id": familyMemberId
        ] as [String: AnyObject]
        
        return sendRequest(serviceName, parameters: params, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func labSaveVisit(labId: Int,completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "pharmacy/saveLabVisit"
        let params = [
            "lab_id": labId
        ] as [String: AnyObject]
        
        return sendRequest(serviceName, parameters: params, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func createNewWallet(completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "wallet/create"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getWalletBalance(completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "wallet/balance"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getTransactionHistory( completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "wallet/transactions"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func addMedIQWalletTransaction(amount: Int, orderNumber: String, orderType: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "wallet/addTransaction"
        
        let parameters = [
            "amount": amount,
            "order_number": orderNumber,
            "order_type": orderType,
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getAllClaims(completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "daraz/getAllClaims"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func getAllVisits(type: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "pharmacy/getAllVisits/\(type)"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    //MARK: - Hospital Related APIs
    @discardableResult
    func getAllHospital(serviceName: String, cityId: Int, lat: Double, lng: Double,completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let parameters = [
            "city_id": cityId,
            "lat": lat,
            "lng": lng
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }

    @discardableResult
    func getAllHospitalServices(hospitalId: Int, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "hospital/services"
        
        let parameters = [
            "hospital_id": hospitalId
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func sendNotificationHospital(hospitalId: Int, serviceId: Int, doctorName: String, service: String, amount: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "hospital/addOpdVisit"
        
        let parameters = [
            "hospital_id": hospitalId,
            "service_id": serviceId,
            "doctor": doctorName,
            "speciality": service,
            "amount": amount,
            "description": ""
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getHospitalPendingVisits(completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "hospital/pendingVisit"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false
                           , headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getDicounts(outlet_id: String, outlet_type: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "center/discount"
        
        let parameters = [
            "outlet_id": outlet_id,
            "outlet_type": outlet_type,
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true
                           , headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getClinicDetail(serviceName: String, clinicId: Int,completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let parameters = [
            "clinic_id": clinicId,
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func postBookClinicVisit(clinicId: Int, doctorId: Int, price: Int,completionBlock: @escaping APIClientCompletionHandler) -> Request {
        var serviceName = "clinic/visit"
        let parameters = [
            "clinic_id": clinicId,
            "doctor_id": doctorId,
            "price": price
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func postConfirmClinicVisit(clinicVisitId: String, paymentId: Int, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        var serviceName = "clinic/visit/complete"
        let parameters = [
            "payment_method_id": paymentId,
            "clinic_visit_id": clinicVisitId
            ] as [String : AnyObject]
        
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    // MARK: - Card Apis
    @discardableResult
    func getCardDetail(completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "card"
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func resetCardPin(currentPin: String, newPin: String, otp: String,completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "card/reset/pin"
        
        let parameters = [
            "current_pin": currentPin,
            "new_pin": newPin,
            "otp": otp
            ] as [String : AnyObject]
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func blockCard(currentPin: String, status: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "card/block"
        
        let parameters = [
            "pin": currentPin,
            "status": status,
            ] as [String : AnyObject]
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func sendOtpCardPin(currentPin: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "card/send/otp"
        
        let parameters = [
            "pin": currentPin
            ] as [String : AnyObject]
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    // MARK: - E-con Api
    
    @discardableResult
    func checkUserValdity(phone: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "econ/checkUser"
        
        let parameters = [
            "phone": phone
            ] as [String : AnyObject]
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func sendEconOtp(phone: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "econ/sendOtp"
        
        let parameters = [
            "phone": phone
            ] as [String : AnyObject]
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func verifyEconOtp(phone: String, otp: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "econ/verifyOtp"
        
        let parameters = [
            "phone": phone,
            "otp": otp
            ] as [String : AnyObject]
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func saveEconUser(phone: String, full_name: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "econ/user/save"
        
        let parameters = [
            "phone": phone,
            "full_name": full_name
            ] as [String : AnyObject]
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func unSubEconUser(phone: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "econ/user/unsubscribe"
        
        let parameters = [
            "phone": phone
            ] as [String : AnyObject]
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func subEconUser(phone: String, otp: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "econ/user/subscribe"
        
        let parameters = [
            "phone": phone,
            "otp": otp
            ] as [String : AnyObject]
        return sendRequest(serviceName, parameters: parameters, isPostRequest: true, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func checkOperatorRequest(phone: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "econ/checkOperator?phone=\(phone)"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func checkHE(completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "econ/headerEnrichment"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    
    @discardableResult
    func checkNumberRequest(phone: String, completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "econ/checkNumber?phone=\(phone)"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
    @discardableResult
    func getEconPackages(completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "econ/packages"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }

    // MARK: - Faq Api
    
    @discardableResult
    func getFaqQuestion(completionBlock: @escaping APIClientCompletionHandler) -> Request {
        let serviceName = "faq"
        
        return sendRequest(serviceName, parameters: nil, isPostRequest: false, headers: nil, completionBlock: completionBlock)
    }
    
}




