//
//  LCConstants.swift
//  HomeMedics
//
//  Created byDevBatch on 6/19/17.
//  Copyright © 2017DevBatch. All rights reserved.
//

import Foundation
import UIKit

let kGoogleClientID = "792539681945-lreonvma99dtou90cajagq32297jigqh.apps.googleusercontent.com"

enum LeftMenu: Int {
    case profile = 0
    case home
    case earning
    case backDetails
    case rating
    case identification
    case privacyPolicy
    case termsAndConditions
    case insurance
    case support
    case logOut
}

enum LCMessageType: Int {
    case error = 0
    case success
    case info
}

enum ProductType : String {
    case Medicine = "Medicines"
    case Equipment = "Equipments"
    case Test = "LabsTest"
    case Miscellenaous = "OtherMedicines"
}

enum WebViewType : String {
    case termsCondition = "Terms"
    case aboutUs = "About"
}

enum PaymentMethod: Int {
    case jazzCashWallet = 1
    case easyPaisaWallet = 5
    case creditCard = 11
    case cashOnDelivery = 4
    case bankTransfer = 8
    case hblKonnect = 9
    case free = 10
    case medIQWallet = 12
}

/**
 Ports
 Old: 44380
 New: 8443
 */

let kDeviceToken = "kDeviceToken"
let kIsUserLoggedIn = "kIsUserLoggedIn"
let kLiveBaseUrl = ""
let kLocalBaseUrl = "http://192.168.0.12:85/api/"
let kStagingBaseUrl = "https://mediq.com.pk:44380/api/"
let kImageDownloadBaseUrl = "https://mediq.com.pk:44380/"
let kImageDownloadProfileBaseUrl = "https://mediq.com.pk:44380/"
let kDeeplinkingUrlPrefix = "https://mediq.com.pk/home/order_id/order_number="
let kToken  = "kToken"
let kUserIsSocial = "kUserIsSocial"
let kUserAvatar = "kUserAvatar"
let kUserSocialAvatar = "kUserSocialAvatar"
let kUserFullName = "kUserFullName"
let kUserLastName = "kUserLastName"
let kUserEmail = "kUserEmail"
let kUserId = "kUserId"
let kUserMobile = "kUserMobile"
let kUserProfileImageUrl = "kUserProfileImageUrl"
let kBillingId = "kBillingId"
let kShippingId = "kShippingId"
let kPushNotificationOrderId = "kPushNotificationOrderId"
let kNewAppointmentBookedForDoctor = "kNewAppointmentBookedForDoctor"
let kAppointmentIsSceduled = "kAppointmentIsSceduled"
let kReceivedPrescriptionFromDoctor = "ReceivedPrescriptionFromDoctor"
let kAppWasLaunchedBefore = "AppWasLaunchedBefore"
let kAccept = "accept"
let kReject = "reject"

let kSocialSignEnableDate = "12-Aug-2022"

//Deeplink
let kClientName = "kClientName"
let kPakcageId = "kPackageId"
let kPageName = "kPageName"

enum BadgePosition: String {
    case topRight
    case topLeft
    case right
    case left
}

let kNNotificationIdentifier = "kNotificationIdentifier"
let kUploadImageNotification = "kUploadImageNotification"
let kCartIsUpdatedNotification = "kCartIsUpdatedNotification"
let kTeleConsultantFeePaid = "kTeleConsultantFeePaid"

let kCheckIfAutoNavigationRequired = "kCheckIfAutoNavigationRequired"


let kNoMessageImage = "no_msg"

let kCornerRadius : CGFloat = 2.0
var kOffSet = 20
let kLocation = "location"
let kSavedCookies = "savedCookies"

let kNotificationChangeBarButton = "kNotificationChangeBarButton"

let kErrorSessionExpired = "User is not authenticated."

let kJazzCashLimit = 50000.0
let kMinCashLimitWithoutDelieveryCharges = 2500.0
let kAdditionalDelieveryCharges = 250.0
let kTestSampleCollectionCharges = 0.0//300.0

let lightBlueColor = UIColor(red: 0.80, green: 0.89, blue: 0.97, alpha: 1.00)
let purpleColor = UIColor(red: 0.26, green: 0.18, blue: 0.46, alpha: 1.00)
let greenOnlineColor = UIColor(red: 0.07, green: 0.75, blue: 0.49, alpha: 1.00)

let showEMR = true


// Credit User Login: 923002160839/allianz


