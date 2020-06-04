//
//  Extensions.swift
//  SimplyLaundry
//
//  Created by webclues on 28/12/18.
//  Copyright © 2018 webclues. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import CoreTelephony
import CoreLocation
import Contacts
import SDWebImage
import DropDown

let Application_Delegate = UIApplication.shared.delegate as! AppDelegate


func getDateFrom(string text:String,fromDateFormate Formate:String = "yyyy-MM-dd HH:mm:ss",getDateFormate getFormate:String = "EEEE dd, MMM, yyyy 'at' hh:mm a")-> String
{
    //get here date in formate EEEE dd, MMM, yyyy
    // EEEE = day's from Monday, Tusday,... to Sunday
    // dd = Day
    // MMMM = Full name of Month // MMM = Short Month Name like Jan, Fab, etc // mm = number of Month like 1, 2, to 12
    // yyyy = Full year // yy = Short year number like 18, 19, 20 etc.
    // hh = Hours in 12 // HH = Hours in 24
    // mm = Minutes
    // a = AM or PM
//    Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
//    09/12/2018                        --> MM/dd/yyyy
//    09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
//    Sep 12, 2:11 PM                   --> MMM d, h:mm a
//    September 2018                    --> MMMM yyyy
//    Sep 12, 2018                      --> MMM d, yyyy
//    Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
//    2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
//    12.09.18                          --> dd.MM.yy
//    10:41:02.112                      --> HH:mm:ss.SSS
    
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Formate
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    let newDate = dateFormatter.date(from: text)
    let NewdateFormatter = DateFormatter()
    NewdateFormatter.amSymbol = "AM"
    NewdateFormatter.pmSymbol = "PM"
    NewdateFormatter.dateFormat = getFormate
    let mydate = NewdateFormatter.string(from: newDate!)
    return mydate
}

func getDateFromString(string text:String,fromDateFormate Formate:String = "yyyy-MM-dd HH:mm:ss")-> Date
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Formate
    dateFormatter.timeZone = TimeZone.current//TimeZone(secondsFromGMT:0)!
    dateFormatter.locale = Locale.current
//    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    let newDate = dateFormatter.date(from: text)
    return newDate!
}

func getStringDateFromDATEObject(_ date:Date,getDateFormate getFormate:String = "EEEE dd, MMM, yyyy 'at' hh:mm a")-> String
{
    let NewdateFormatter = DateFormatter()
    NewdateFormatter.amSymbol = "AM"
    NewdateFormatter.pmSymbol = "PM"
    NewdateFormatter.dateFormat = getFormate
    NewdateFormatter.timeZone = TimeZone.current//TimeZone(secondsFromGMT:0)!
    NewdateFormatter.locale = Locale.current
    let mydate = NewdateFormatter.string(from: date)
    return mydate
}
// --------------------------- For Internet Check ---------------------------

func isInternetAvailable() -> Bool
{
    var zeroAddress = sockaddr_in()
    //var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress)
    {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags)
    {
        return false
    }
    
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}

// --------------------------- For Email Validation ---------------------------

func emailValidation(strEmail: String) -> Bool
{
    var isValidate: Bool
    let email : String = strEmail.lowercased()
    let emailRegEx = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
    //let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    isValidate = emailTest.evaluate(with: email)
    return isValidate
}

// --------------------------- For Display Alert ---------------------------

@available(iOS 10.0, *)
func showMyAlertView(message:String,title:[String] = [Alert_Ok],completion: @escaping (UIAlertAction) -> ())
{
    if let presentController = Application_Delegate.window?.rootViewController //navigationController.topViewController
    {
        let alertController = UIAlertController(title: APP_NAME, message: message, preferredStyle: .alert)
        for titleName in title
        {
            let saveAction = UIAlertAction(title: titleName, style: .default) { (action) in
                completion(action)
            }
            alertController.addAction(saveAction)
        }
        presentController.present(alertController, animated: true, completion: nil)
    }
}
// --------------------------- For Textfiled toolbar on top ---------------------------

func textfieldToolBar(txtField: UITextField, delegate: AnyObject)
{
    let keyboardDoneButtonView = UIToolbar()
    let spaceButton = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: delegate, action: Selector(("toolBarDoneClicked")))
    keyboardDoneButtonView.sizeToFit()
    keyboardDoneButtonView.items = [spaceButton, doneButton]
    
    txtField.inputAccessoryView = keyboardDoneButtonView
}

// --------------------------- For Textfiled toolbar on top ---------------------------

func textviewToolBar(txtView: UITextView, delegate: AnyObject)
{
    let keyboardDoneButtonView = UIToolbar()
    let spaceButton = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: delegate, action: Selector(("toolBarDoneClicked")))
    keyboardDoneButtonView.sizeToFit()
    keyboardDoneButtonView.items = [spaceButton, doneButton]
    
    txtView.inputAccessoryView = keyboardDoneButtonView
}

func sortArrayWithKey(arrSort:NSArray, strKeyname: String, isAscending: Bool) -> NSArray
{
    let descriptor: NSSortDescriptor = NSSortDescriptor(key: strKeyname, ascending: isAscending)
    let sortedResults = arrSort.sortedArray(using: [descriptor]) as NSArray
    
    return sortedResults
}

// ---------------------------- For Get device country code ---------------------------

func getDeviceCountryCode() -> String
{
    var strCountryCode: String = ""
    
    if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String
    {
        let path = Bundle.main.path(forResource: "countries", ofType: "json")
        let jsonData : NSData = NSData(contentsOfFile: path!)!
        
        var jsonArr : NSArray!
        do
        {
            jsonArr = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray
        }
        catch let error as NSError
        {
            print(error)
        }
        
        let predicate = NSPredicate(format: "code == %@", countryCode)
        let filteredArray: [Any]! = jsonArr.filtered(using: predicate)
        
        let dictTemp: NSDictionary = filteredArray[0] as! NSDictionary
        
        strCountryCode = dictTemp.value(forKey: "dial_code") as! String
    }
    
    return strCountryCode
}


func convertDateStringtoDeviceTime (msgDate: String) -> String
{
    let dateFormatter = DateFormatter()
    let timeZone = NSTimeZone(name: "UTC")
    
    
    dateFormatter.timeZone = timeZone! as TimeZone
    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
    let date: Date? = dateFormatter.date(from: msgDate)
    let dateFormatterDest = DateFormatter()
    dateFormatterDest.dateFormat = "dd-MM-yyyy HH:mm"
    let dateNew = Date(timeIntervalSinceNow: (date?.timeIntervalSinceNow)!)
    let dateString: String = dateFormatterDest.string(from: dateNew)
    return dateString
}

func convertDatetoDeviceTime (selectedDate: Date) -> String
{
    let dateFormatterDest = DateFormatter()
    dateFormatterDest.dateFormat = "dd-MM-yyyy HH:mm"
    let dateNew = Date(timeIntervalSinceNow: (selectedDate.timeIntervalSinceNow))
    let dateString: String = dateFormatterDest.string(from: dateNew)
    return dateString
}

func addBorderAtBottom(sender: AnyObject)
{
    let bottomLayer: CALayer! = CALayer()
    if #available(iOS 12.0, *) {
        bottomLayer.frame = CGRect(x: 0, y: sender.frame.size.height-1, width: sender.frame.size.width, height: 1.0)
    } else {
        // Fallback on earlier versions
    }
    //  bottomLayer.backgroundColor = COLOR.borderColor.cgColor
    sender.layer.addSublayer(bottomLayer)
}

func addShadowEffect(sender: AnyObject)
{
    sender.layer.shadowColor = UIColor.black.cgColor
    sender.layer.shadowOpacity = 0.3
    sender.layer.shadowOffset = CGSize(width: 1, height: 1)
    sender.layer.shadowRadius = 2
}

func addDarkShadowEffect(sender: AnyObject)
{
    sender.layer.shadowColor = UIColor.black.cgColor
    sender.layer.shadowOpacity = 0.3
    sender.layer.shadowOffset = CGSize(width: -2, height: 2)
    sender.layer.shadowRadius = 4
}

func randomNumber(MIN: Int, MAX: Int)-> Int
{
    return Int(arc4random_uniform(UInt32(MAX)) + UInt32(MIN));
}

func getUserProfileDict() -> NSDictionary
{
    var dictUser: NSDictionary! = NSDictionary()
    if isKeyPresentInUserDefaults(key: "User_Detail")
    {
        if let dictTemp = UserDefaults.standard.value(forKey: "User_Detail") as? NSDictionary
        {
            dictUser = dictTemp
        }
    }
    return dictUser
}

func getRandomNumbers() -> NSString
{
    let Number = Int(arc4random_uniform(9999))
    return String(Number) as NSString
}

func isKeyPresentInUserDefaults(key: String) -> Bool
{
    return UserDefaults.standard.object(forKey: key) != nil
}

func getStringUserDefaults(Key:String) -> String
{
    var value: String = ""
    
    if let keyValue = UserDefaults.standard.value(forKey: Key) as? String
    {
        value = keyValue
    }
    return value
}

func SetUserDefaults(Key:String,value:AnyObject)
{
    let userDefaults : UserDefaults = UserDefaults.standard
    userDefaults.setValue(value, forKey: Key)
    userDefaults.synchronize()
}

func GetUserDefaults(Key:String) -> AnyObject
{
    var value: AnyObject = "" as AnyObject
    
    if let keyValue = UserDefaults.standard.value(forKey: Key)
    {
        value = keyValue as AnyObject
    }
    return value
}

func getAuthTocken() -> String
{
    if let strAuthTocken : Int =  getUserInfo().value(forKey: ResponceKey_Login_User.auth_token) as? Int
    {
        return "\(strAuthTocken)"
    }
    else
    {
        return ""
    }
}

func convertToDictionary(text: String) -> NSDictionary
{
    if let data = text.data(using: .utf8)
    {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
        } catch {
        }
    }
    return NSDictionary()
}

func removeKeyFromUserDefaults(keyName: String)
{
    if isKeyPresentInUserDefaults(key: keyName)
    {
        UserDefaults.standard.removeObject(forKey: keyName)
    }
}


//MARK:- Get User informations

func getUserInfo()->NSDictionary
{
    if let dictionary : NSDictionary = UserDefaults.standard.value(forKey: User_Info) as? NSDictionary
    {
        return dictionary
    }
    return NSDictionary()
}

func getUserID()-> String
{
    if let Login_User_ID : String = getUserInfo().value(forKey: User_ID) as? String
    {
        return Login_User_ID
    }
    else{
        return "\(getUserInfo().value(forKey: User_ID)!)"
    }
}
func setUserInfo(Data:Any)
{
    UserDefaults.standard.set(Data, forKey: User_Info)
    UserDefaults.standard.synchronize()
}


func calculateHeight(forLbl text: String?, width: Float) -> Float {
    let constraint = CGSize(width: CGFloat(width), height: 20000.0)
    var size: CGSize
    let context = NSStringDrawingContext()
    let boundingBox: CGSize? = text?.boundingRect(with: constraint, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)], context: context).size
    size = CGSize(width: ceil((boundingBox?.width)!), height: ceil((boundingBox?.height)!))
    return Float(size.height)
}

func getNSArrayToStringArray(array:NSArray,forKey key:String)->[String]
{
    let searchKey = key
    let arraySelectedService : [String] = array.value(forKeyPath: searchKey) as! [String]
    
    return arraySelectedService
}

func getCardNumber(cardNumber number: String)-> String
{
    let splitPhoneNo = number.split(separator: " ")
    let cardNumber = splitPhoneNo.joined(separator: "")

    return "\(cardNumber)"
}

func isCheckZipCode(string:String) -> Bool {
    var lowerCaseLetter: Bool = false
    var upperCaseLetter: Bool = false
    var digit: Bool = false
    var specialCharacter: Bool = false
    
    for char in string.unicodeScalars {
        if !lowerCaseLetter {
            lowerCaseLetter = CharacterSet.lowercaseLetters.contains(char)
        }
        if !upperCaseLetter {
            upperCaseLetter = CharacterSet.uppercaseLetters.contains(char)
        }
        if !digit {
            digit = CharacterSet.decimalDigits.contains(char)
        }
        
        if !specialCharacter {
            specialCharacter = CharacterSet.punctuationCharacters.contains(char)
        }
    }
    if (digit && (lowerCaseLetter || upperCaseLetter)) {
        //do what u want
        return true
    }
    else {
        return false
    }
}

func initDropDown(dropDownPop : DropDown = DropDown(), dataSource:[String],textFiled:UITextField,isTextAutoFill : Bool = true,_ success : ((Int,String)->())?)
{
    dropDownPop.reloadAllComponents()
    dropDownPop.selectRow(0)
    dropDownPop.anchorView = textFiled
    dropDownPop.dataSource = dataSource
    dropDownPop.bottomOffset = CGPoint.init(x: 0, y: textFiled.frame.maxY)
    dropDownPop.direction = .any
    dropDownPop.dismissMode = .onTap
    dropDownPop.selectionAction =
    { (index: Int, item: String) in
        
        print("Selected item: \(item) at index: \(index)")
        if success != nil
        {
            success!(index,item)
        }
        if isTextAutoFill == true
        {
            textFiled.text = item
        }
        
    }
    dropDownPop.show()
}
