//
//  global.swift
//  SimplyLaundry
//
//  Created by webclues on 28/12/18.
//  Copyright © 2018 webclues. All rights reserved.
//

import Foundation
import UIKit

let APP_NAME = "Simply Laundry"
let Str_Device_Type = "ios"
let DEVICE_ID =  UIDevice.current.identifierForVendor!.uuidString
let APP_DEVICE = "2"
var TAG_Device_Token = "123456789"
let fromPush = "fromPush"
let push_type = "type"
let push_type_message = "new_message"

let GoogleClient_ID = "512098181173-3349od87gq86u21sna2fmsdo6f75o56l.apps.googleusercontent.com"
let google_api_key = "AIzaSyBGkB0VP1Vj46As9gXFQC9eTLXDkRCF22c"

let Place_API_key = "AIzaSyDDmX0B57CdFDyhW-YyHc4R7KhWMayihI8" // Simply Laundry

let Place_API = "https://maps.googleapis.com/maps/api/place"
let Place_API_Type_detail = "/details"
let Place_API_autocomplete = "/autocomplete"
var Place_API_SearchInArea = "components=country:CA|country:US"
let reqTask_PlaceDetail_API = "PlaceDetailAPI"


//MARK:- LoginUser Dictionary Key

let User_Info = "Login_User_Info"
let User_ID = "user_id"
let User_auth_token = "auth_token"


//MARK:- API Variables
let isLiveURL = false
let webQAMainURL = "https://webcluestech.com/qa/simplylaundry/" //QA server
let webLiveMainURL = "https://simply-laundry.com/" //Live server

let baseMainURL = "web_service/"

let SERVER_URL = isLiveURL ? webLiveMainURL+baseMainURL : webQAMainURL+baseMainURL
let referCodeURL = isLiveURL ? webLiveMainURL+"register?referral_code=" : webQAMainURL+"register?referral_code="

//let Payment_URL = "https://webcluestech.com/qa/simplylaundry/order_management/"
let Payment_URL = "https://simply-laundry.com/paypal/paypal.php"
let paypal_Pament_url = "https://api.paypal.com/v1/billing-agreements/agreement-tokens"
let get_paypal_Token = "https://api.paypal.com/v1/oauth2/token"
let getAgreementTokens = "https://api.paypal.com/v1/billing-agreements/agreement-tokens"
let getAgreements = "https://api.paypal.com/v1/billing-agreements/agreements"


//Reqvest parameters
let reqGetGlobal = "get_global"
let reqCheckEmail = "check_email"
let reqVerifyReferralCode = "verify_referral_code"
let reqLogin = "login"
let reqGetAllCountry = "get_all_country"
let reqGetAllState = "get_all_state"
let reqSignUp = "sign_up"
let reqLogout = "logout"
let reqForgotPassword = "forgot_password"
let reqGetProfileDetail = "get_profile_detail"
let reqUpdateProfileDetail = "update_profile_detail"
let reqCheckEditEmail = "check_edit_email"
let reqCheckOldPassword = "check_old_password"
let reqChangePassword = "change_password"
let reqGetAllMyAddress = "get_all_my_address"
let reqSetDefaultAddress = "set_default_address"
let reqAddUserAddress = "add_user_address"
let reqUpdateUserAddress = "update_user_address"
let reqDeleteAddress = "delete_address"
let reqCheckpincode = "checkpincode"
let reqAddCreditCard = "add_credit_card"
let reqGetAllCreditCard = "get_all_credit_card"
let reqSetDefaultCreditCard = "set_default_credit_card"
let reqDeleteCreditCard = "delete_credit_card"
let reqCheckPromocode = "check_promocode"
let reqPlaceOrder = "place_order"
let reqGetAllCategory = "get_all_category"
let ReqGetAllPriceDetails = "get_all_price_details"
let reqGetReferCode = "get_refer_code"
let reqGetUserPreference = "get_user_preference"
let reqBuyPackage = "buy_package"
let reqPackDetail = "pack_detail"
let reqDeletePackage = "delete_package"
let reqContactUs = "contact_us"
let reqAddPreference = "add_preference"
let reqUserCredit = "user_credit"
let reqCheckGiftcode = "check_giftcode"
let reqBuyGiftCard = "buy_gift_card"
let reqOrderHistory = "order_history"
let reqOrderDetail = "order_detail"
let reqChangeOrderStatus = "change_order_status"
let reqPages = "pages"
let reqCancelOrder = "cancel_order"
let reqGetInvoice = "get_invoice"
let reqRefreshToken = "refresh_token"
let reqGetHowHearAboutUs = "get_how_hear_about_us"
let reqGetCheckPermission = "get_check_permission"
let reqGetGiftCard = "get_gift_card"
let reqCancelGiftCard = "cancel_gift_card"
let reqGeneratePDF = "generatePDF"
let reqAddIncompleteOrder = "add_incomplete_order"

let reqGetPackages = "get_packages"
let reqGetAllServices = "get_all_services"
let reqGetDeliveryOption = "get_delivery_option"
let reqGetTimeSlot = "get_time_slot"

let reqPaypalButton = "paypalButton"

//Responce Parameters
let ResKeyMessage = "message"
let ResKeyStatus_code = "status_code"
let reqStatus = "status"
let ResKeyData = "data"

let successStatus = 1
let aouthStatus = 100

//MARK:- Alert View title
let Alert_Ok = "OK"
let Alert_yes = "YES"
let Alert_no = "NO"
let Alert_cancel = "CANCEL"
let reponceServerMessage = "Something went to wrong please try again."

//MARK:- Login User UserDefult key
let strLoginUserKeyAuthToken = "auth_token"
let strLoginUserKeyDisplayName = "display_name"
let strLoginUserKeyPhone = "phone"
let strLoginUserKeyRegisteredVia = "registered_via"
let strLoginUserKeyUserID = "user_id"

//MARK:- Font Name

let SourceSansPro_Black = "SourceSansPro-Black"
let SourceSansPro_BlackIt = "SourceSansPro-BlackIt"
let SourceSansPro_Bold = "SourceSansPro-Bold"
let SourceSansPro_BoldIt = "SourceSansPro-BoldIt"
let SourceSansPro_ExtraLight = "SourceSansPro-ExtraLight"
let SourceSansPro_ExtraLightIt = "SourceSansPro-ExtraLightIt"
let SourceSansPro_It = "SourceSansPro-It"
let SourceSansPro_Light = "SourceSansPro-Light"
let SourceSansPro_LightIt = "SourceSansPro-LightIt"
let SourceSansPro_Regular = "SourceSansPro-Regular"
let SourceSansPro_Semibold = "SourceSansPro-Semibold"
let SourceSansPro_SemiboldIt = "SourceSansPro-SemiboldIt"


//MARK:- Font Size

let FONT_SIZE_TEN : CGFloat = 10
let FONT_SIZE_ELEVEN : CGFloat = 11
let FONT_SIZE_TWELVE : CGFloat = 12
let FONT_SIZE_THIRTEEN : CGFloat = 13
let FONT_SIZE_FOURTEEN : CGFloat = 14
let FONT_SIZE_FIFTEEN : CGFloat = 15
let FONT_SIZE_SIXTEEN : CGFloat = 16
let FONT_SIZE_SEVENTEEN : CGFloat = 17
let FONT_SIZE_EIGHTEEN : CGFloat = 18
let FONT_SIZE_NINETEEN : CGFloat = 19
let FONT_SIZE_TWENTY : CGFloat = 20
let FONT_SIZE_TWENTY_FOUR : CGFloat = 24



//MARK:- For Device Size
struct SCREEN_SIZE
{
    static let WIDTH = UIScreen.main.bounds.size.width
    static let HEIGHT = UIScreen.main.bounds.size.height
}
//
struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

//struct DeviceType
//{
//    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
//    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
//    static let IS_IPHONE_6_7          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
//    static let IS_IPHONE_6P_7P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
//    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
//    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
//}



//MARK:- HEX Color
let GreenHex =  "#76bc21"
let BlueHex = "#385cad"
let GrayHex = "#757575"
let WhiteHex = "#f1f2f4"
let greyBGHex = "#EEF3F4"
let yellowHex = "#ffc107"
let BlueLightHex = "#09a9f4"
let FBBlueHex = "#485992"
let GoogleGreyHex = "#f5f5f5"
let OrangeHex = "#f44336"
let reOrderBlueHex = "#2196F3"
let SkyBlueHex = "#AAD2F4"
let KellyGreenHex = "#4CAF50"
let statusBlueHex = "#145ead"
let statusYellowHex = "#ffeb3b"
//MARK:- Color
struct COLOR
{
    static let FBBlue = hexStringToUIColor(hex: FBBlueHex)
    static let GoogleGrey = hexStringToUIColor(hex: GoogleGreyHex)
    
    static let Green = hexStringToUIColor(hex: GreenHex)
    static let Blue = hexStringToUIColor(hex: BlueHex)
    static let Blue_light = hexStringToUIColor(hex: BlueLightHex)
    static let Gray = hexStringToUIColor(hex: GrayHex)
    static let background_Gray = hexStringToUIColor(hex: WhiteHex)
    static let yellow = hexStringToUIColor(hex: yellowHex)
    static let Orange = hexStringToUIColor(hex: OrangeHex)
    static let reOrderBlue = hexStringToUIColor(hex: reOrderBlueHex)
    static let SkyBlue = hexStringToUIColor(hex: SkyBlueHex)
    static let KellyGreen = hexStringToUIColor(hex: KellyGreenHex)
    static let statusBlue = hexStringToUIColor(hex: statusBlueHex)
    static let statusYellow = hexStringToUIColor(hex: "009688")
    static let placeholder = Gray.withAlphaComponent(0.5)
    static let textFiled = Balck
    static let Red = UIColor.red
    static let White = UIColor.white
    static let clear = UIColor.clear
    static let Balck = UIColor.black
    
}
//MARK:- For Hexa To UIColor conversion
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

// Variable Declarations and Initlizations
let arrRepeatOrder = ["Every Week","Every 2 Week","Every Month"]
