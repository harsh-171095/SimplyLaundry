//
//  RagistrationsSecondVC.swift
//  SimplyLaundry
//
//  Created by webclues on 31/12/18.
//  Copyright © 2018 webclues. All rights reserved.
//

import UIKit
import DropDown
import GooglePlaces
import GooglePlacePicker
import GoogleMaps

@objc protocol RagistrationsSecondVCDelegate : class
{
    @objc optional func updateAddress()
}

class RagistrationsSecondVC: UIViewController, CLLocationManagerDelegate {
    
    weak var delegate : RagistrationsSecondVCDelegate?
    
    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnBack:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var scrollContent:UIScrollView!
    @IBOutlet weak var viewContent:UIView!
    
    @IBOutlet weak var viewGoogleAddress:UIView!
    @IBOutlet weak var txtGoogleAddress:UITextField!
    @IBOutlet weak var imgGoogleAddress:UIImageView!
    
    @IBOutlet weak var viewStreetAddress:UIView!
    @IBOutlet weak var txtStreetAddress:UITextField!
    @IBOutlet weak var imgStreetAddress:UIImageView!
    
    @IBOutlet weak var viewSuiteNumber:UIView!
    @IBOutlet weak var txtSuiteNumber:UITextField!
    @IBOutlet weak var imgSuiteNumber:UIImageView!
    
    @IBOutlet weak var viewCity:UIView!
    @IBOutlet weak var txtCity:UITextField!
    @IBOutlet weak var imgCity:UIImageView!

    @IBOutlet weak var viewPostalCode:UIView!
    @IBOutlet weak var txtPostalCode:UITextField!
    @IBOutlet weak var imgPostalCode:UIImageView!
    
    @IBOutlet weak var viewCountry:UIView!
    @IBOutlet weak var txtCountry:UITextField!
    @IBOutlet weak var imgCountry:UIImageView!
    @IBOutlet weak var btnSelectCountry:UIButton!
    
    @IBOutlet weak var viewState:UIView!
    @IBOutlet weak var txtState:UITextField!
    @IBOutlet weak var imgState:UIImageView!
    @IBOutlet weak var btnSelectState:UIButton!

    @IBOutlet weak var viewBuzzerCode:UIView!
    @IBOutlet weak var txtBuzzerCode:UITextField!
    
    @IBOutlet weak var viewSpecialInstructions:UIView!
    @IBOutlet weak var txtSpecialInstructions:UITextView!
    @IBOutlet weak var consViewSpecialInstructionHeight: NSLayoutConstraint! // Constraint: set 90 for Show and When hide set 0
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var viewButtonCircle:UIView!

    @IBOutlet weak var viewLogin:UIView!
    @IBOutlet weak var lblNewUserTitle:UILabel!
    @IBOutlet weak var btnLogin:UIButton!
    @IBOutlet weak var consViewLoginTop: NSLayoutConstraint!
    
    // Variable Declarations and Initlizations
    var screenNo : Int = 1 // 1: Ragistrations Second Screen, 2: Add Address Screen , 3: Edit Address Screen
    var dicRagistrationInfo : NSMutableDictionary = NSMutableDictionary()
    
    var dropDownPop  = DropDown()
    var dicAddress : NSDictionary = NSDictionary()
    var locationManager: CLLocationManager!
    var currentLat : CLLocationDegrees!
    var currentLong : CLLocationDegrees!
    var arrLocation : NSMutableArray = NSMutableArray()
    let filter = GMSAutocompleteFilter()
    let placesClient = GMSPlacesClient()
    var addressSelected = GMSAddress()
    var strTextViewPlaceholder = "Special Instructions"
    var strFrom = ""
    var strCityName = ""
    public var placeBounds: GMSCoordinateBounds?
    var arrCountry = NSArray()
    var arrState = NSArray()
    var countryID = Int()
    var stateID = Int()
    var isAddressSelected : Bool = false
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
//        locationSetup()
        setThemeAccrodingToScreen()
        processGetCuntry()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK:- set Outlet's Theme
    /*
     Function Name :- setTheme
     Function Parameters :- (nil)
     Function Description :- This function used for set a Cotroller outlet's theme.
     */
    func setTheme()
    {
        //Parent theme
        self.view.addGradientsWithTwoColor()
        viewParent.backgroundColor = COLOR.White
        
        //header theme
        viewHeader.backgroundColor = COLOR.Green
        
        imgBackground.image = UIImage.init(named: "header_bg")
        
        btnBack.setTitle("", for: .normal)
        btnBack.setImage(UIImage.init(named: "back"), for: .normal)
        btnBack.tintColor = COLOR.White
        btnBack.addTarget(self, action: #selector(btnBackClick(_:)), for: .touchUpInside)
        
        lblVCTitle.setVCTitle("Registration")
        
        //content theme
        scrollContent.setThemeForScrollView()
        viewContent.backgroundColor = COLOR.White
        
        viewGoogleAddress.backgroundColor = COLOR.background_Gray
        viewGoogleAddress.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtGoogleAddress.setThemeFor("Google Address")
        txtGoogleAddress.delegate = self
        imgGoogleAddress.image = UIImage.init(named: "google_icon")
        
        viewStreetAddress.backgroundColor = COLOR.background_Gray
        viewStreetAddress.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtStreetAddress.setThemeFor("Street Address*")
        txtStreetAddress.delegate = self
        imgStreetAddress.image = UIImage.init(named: "street_address")
        
        viewSuiteNumber.backgroundColor = COLOR.background_Gray
        viewSuiteNumber.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtSuiteNumber.setThemeFor("Apt/Suite Number")
        txtSuiteNumber.delegate = self
        imgSuiteNumber.image = UIImage.init(named: "apt_suite_number")
  
        viewCity.backgroundColor = COLOR.background_Gray
        viewCity.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtCity.setThemeFor("City*")
        txtCity.delegate = self
        imgCity.image = UIImage.init(named: "city")

        viewPostalCode.backgroundColor = COLOR.background_Gray
        viewPostalCode.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtPostalCode.setThemeFor("Postal Code*")
        txtPostalCode.delegate = self
        imgPostalCode.image = UIImage.init(named: "postel_code")

        viewCountry.backgroundColor = COLOR.background_Gray
        viewCountry.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtCountry.setThemeFor("Country*")
        txtCountry.delegate = self
        imgCountry.image = UIImage.init(named: "down_arrow")
        btnSelectCountry.setTitle("", for: .normal)
        btnSelectCountry.addTarget(self, action: #selector(btnSelectCountryClick(_:)), for: .touchUpInside)
        
        viewState.backgroundColor = COLOR.background_Gray
        viewState.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtState.setThemeFor("State / Province*")
        txtState.delegate = self
        imgState.image = UIImage.init(named: "down_arrow")
        btnSelectState.setTitle("", for: .normal)
        btnSelectState.addTarget(self, action: #selector(btnSelectStateClick(_:)), for: .touchUpInside)

        viewBuzzerCode.backgroundColor = COLOR.background_Gray
        viewBuzzerCode.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtBuzzerCode.setThemeFor("Buzzer Code")
        txtBuzzerCode.delegate = self

        viewSpecialInstructions.backgroundColor = COLOR.background_Gray
        viewSpecialInstructions.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtSpecialInstructions.setThemeFor(strTextViewPlaceholder, returnKeyType : .continue)
        txtSpecialInstructions.delegate = self
        
        btnSignUp.setThemeForAppButton("LET'S DO SOME LAUNDRY")
        btnSignUp.addTarget(self, action: #selector(btnSignUpClick(_:)), for: .touchUpInside)
        viewButtonCircle.backgroundColor = COLOR.White
        viewButtonCircle.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: viewButtonCircle.frame.height / 2)
        
        lblNewUserTitle.text = "Already have an account?"
        lblNewUserTitle.textColor = COLOR.Gray
        lblNewUserTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_THIRTEEN)
        
        btnLogin.setTitle("LOGIN", for: .normal)
        btnLogin.backgroundColor = COLOR.clear
        btnLogin.setTitleColor(COLOR.Green, for: .normal)
        btnLogin.titleLabel?.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_THIRTEEN)
        btnLogin.addTarget(self, action: #selector(btnLoginClick(_:)), for: .touchUpInside)
    }
    
    /*
     Function Name :- setThemeAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set a theme for Controller initial screen values
     */
    func setThemeAccrodingToScreen()
    {
        if screenNo == 1 // Ragistration Second Screen
        {
            btnBack.isHidden = false
        }
        else if screenNo == 2 // Add Address Screen
        {
            btnBack.isHidden = false
            
            lblVCTitle.text = "Add Address"
            
            viewSpecialInstructions.isHidden = true
            consViewSpecialInstructionHeight.constant = 0
            consViewLoginTop.constant = -10
            btnSignUp.setTitle("ADD ADDRESS", for: .normal)
            viewLogin.isHidden = true
        }
        else if screenNo == 3 // Edit Address Screen
        {
            btnBack.isHidden = false
            
            lblVCTitle.text = "Edit Address"
            
            viewSpecialInstructions.isHidden = true
            consViewSpecialInstructionHeight.constant = 0
            consViewLoginTop.constant = -10
            btnSignUp.setTitle("SAVE", for: .normal)
            viewLogin.isHidden = true
            setDataAccrodingToScreen()
        }
    }
    
    /*
     Function Name :- setDataAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set the data for Controller initial screen values
     */
    func setDataAccrodingToScreen()
    {
        if let address1 = dicAddress.value(forKey: "address_line1") as? String
        {
            txtStreetAddress.text = address1
        }
        if let address2 = dicAddress.value(forKey: "address_line2") as? String
        {
            txtSuiteNumber.text = address2
        }
        if let city = dicAddress.value(forKey: "city") as? String
        {
            txtCity.text = city
        }
        if let postalCode = dicAddress.value(forKey: "postal_code") as? String
        {
            txtPostalCode.text = postalCode
        }
        if let country = dicAddress.value(forKey: "country_name") as? String
        {
            txtCountry.text = country
        }
        if let state = dicAddress.value(forKey: "state_name") as? String
        {
            txtState.text = state
        }
        if let buzzerCode = dicAddress.value(forKey: "buzzer_code") as? String
        {
            txtBuzzerCode.text = buzzerCode
        }
        if let state = dicAddress.value(forKey: "state_id") as? String
        {
            if state != ""
            {
                stateID = Int(state)!
            }
        }
        if let state = dicAddress.value(forKey: "country_id") as? String
        {
            if state != ""
            {
                countryID = Int(state)!
                processGetState(countryID: "\(countryID)")
            }
        }
        
    }
    
    //MARK:- Button Actions
    @IBAction func btnBackClick(_ sender:Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSignUpClick(_ sender:Any)
    {
        var strmessage = String()
        
        if (txtStreetAddress.text?.count)! == 0
        {
            strmessage = "Street Address Required."
        }
        else if (txtCity.text?.count)! == 0
        {
            strmessage = "City Required."
        }
        else if (txtPostalCode.text?.count)! == 0
        {
            strmessage = "Postal Code Required."
        }
        else if checkZipCode() == false
        {
            strmessage = "Please specify a valid postal code."
        }
        else if (txtCountry.text?.count)! == 0
        {
            strmessage = "Country Required."
        }
        else if (txtState.text?.count)! == 0
        {
            strmessage = "State/Province Required."
        }
        
        if strmessage.count > 0
        {
            showMyAlertView(message: strmessage, completion: { (action) in })
        }
        else{
            if screenNo == 1
            {
                dicRagistrationInfo.setValue(Str_Device_Type, forKey: "device_type")
                dicRagistrationInfo.setValue(DEVICE_ID, forKey: "device_id")
                dicRagistrationInfo.setValue(TAG_Device_Token, forKey: "device_token")
                dicRagistrationInfo.setValue(txtStreetAddress.text!, forKey: "address_line1")
                dicRagistrationInfo.setValue(txtSuiteNumber.text!, forKey: "address_line2")
                dicRagistrationInfo.setValue(txtCity.text!, forKey: "city")
                dicRagistrationInfo.setValue(txtPostalCode.text!, forKey: "postal_code")
                dicRagistrationInfo.setValue(countryID, forKey: "country_id")
                dicRagistrationInfo.setValue(stateID, forKey: "state_id")
                dicRagistrationInfo.setValue(txtBuzzerCode.text!, forKey: "buzzer_code")
                dicRagistrationInfo.setValue(txtSpecialInstructions.text! == strTextViewPlaceholder ? " " : txtSpecialInstructions.text!, forKey: "special_instruction")

                processCheckEmail()
            }
            else if screenNo == 2
            {
                processAddAddress()
            }
            else if screenNo == 3
            {
                processUpdateAddress()
            }
        }
    }
    
    @IBAction func btnSelectCountryClick(_ sender:Any)
    {
        self.view.endEditing(true)
        initDropDown(dataSource: getNSArrayToStringArray(array: arrCountry, forKey: "country_name"), textFiled: txtCountry) { (index, value) in
            self.imgCountry.image = UIImage.init(named: "down_arrow")
            self.countryID = Int("\((self.arrCountry[index] as! NSDictionary).value(forKey: "country_id")!)")!
            self.processGetState(countryID: "\(self.countryID)")
            self.txtState.text = ""
        }
    }
    
    @IBAction func btnSelectStateClick(_ sender:Any)
    {
        self.view.endEditing(true)
        initDropDown(dataSource: getNSArrayToStringArray(array: arrState, forKey: "state_name"), textFiled: txtState) { (index, value) in
           self.stateID = Int("\((self.arrState[index] as! NSDictionary).value(forKey: "state_id")!)")!
        }
    }
    
    @IBAction func btnLoginClick(_ sender:Any)
    {
        self.view.endEditing(true)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    @IBAction func btnTableView(didSelect sender:UIButton)
    {
        txtGoogleAddress.resignFirstResponder()
        isAddressSelected = true
        let dictTemp : NSDictionary = arrLocation.object(at: sender.tag) as! NSDictionary
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).searchLocationPlaceDetailAPI(strPlaceID: "\(dictTemp.value(forKey: "place_id")!)")
    }

    /*
     Function Name :- checkZipCode
     Function Parameters :- (nil)
     Function Description :- This function used to check entered Zip code is valied from US or canada.
     */
    func checkZipCode()-> Bool
    {
        let numaric = CharacterSet(charactersIn:"0123456789")
        let output: String = txtPostalCode.text!.trimmingCharacters(in: numaric.inverted)
        let isValid: Bool = (txtPostalCode.text! == output)
        if txtCountry.text!.lowercased() == "United States".lowercased()
        {
            print(isValid)
            if (txtPostalCode.text?.count)! < 5  ||  (txtPostalCode.text?.count)! > 5
            {
                return false
            }
            if isValid == false
            {
                return false
            }
        }
        else if txtCountry.text!.lowercased() == "Canada".lowercased()
        {
            if (txtPostalCode.text?.count)! < 6
            {
                return false
            }
            if isCheckZipCode(string:txtPostalCode.text!) == false
            {
                return false
            }
        }
        return true
    }
    
    //MARK:- API Call Funtions
    /*
     API Function Name :- processGetCuntry
     API Function Parameterts :- (nil)
     API Function Description :- This function used to call the API for getting a country list.
     */
    func processGetCuntry()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = [:]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_GET(reqTask: reqGetAllCountry, dictParameter: parameters as NSDictionary)
    }
    
    /*
     API Function Name :- processGetState
     API Function Parameterts :- (countryID : String)
     API Function Description :- This function used to call the API for getting a state list from country id.
     */
    func processGetState(countryID:String)
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["country_id":countryID]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetAllState, dictParameter: parameters as NSDictionary)
    }
    
    /*
     API Function Name :- processToRagistration
     API Function Parameterts :- (nil)
     API Function Description :- This function used to call the API for process to new user ragistration.
     */
    func processToRagistration()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters = dicRagistrationInfo
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqSignUp, dictParameter: parameters)
    }
    
    /*
     API Function Name :- processAddAddress
     API Function Parameterts :- (nil)
     API Function Description :- This function used to call the API for process to add new addresss.
     */
    func processAddAddress()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID(), "address_line1":txtStreetAddress.text!, "address_line2":txtSuiteNumber.text!, "city":txtCity.text!, "postal_code":txtPostalCode.text!, "country_id":countryID, "state_id":stateID, "buzzer_code":txtBuzzerCode.text!]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqAddUserAddress, dictParameter: parameters as NSDictionary,isHeader: false)
    }
 
    /*
     API Function Name :- processAddAddress
     API Function Parameterts :- (nil)
     API Function Description :- This function used to call the API for process to update addresss.
     */
    func processUpdateAddress()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID(), "address_id":dicAddress.value(forKey: "address_id")!, "address_line1":txtStreetAddress.text!, "address_line2":txtSuiteNumber.text!, "city":txtCity.text!, "postal_code":txtPostalCode.text!, "country_id":countryID, "state_id":stateID, "buzzer_code":txtBuzzerCode.text!]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqUpdateUserAddress, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    /*
     API Function Name :- processCheckPinCode
     API Function Parameterts :- (nil)
     API Function Description :- This function used to call the API for process to check postal code.
     */
    func processCheckPinCode()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["pincode":txtPostalCode.text!]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqCheckpincode, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    /*
     API Function Name :- processCheckEmail
     API Function Parameters :- nil
     API Function Description :- This function used to call the API for the check email address is exist or not.
     */
    func processCheckEmail()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["email":"\(dicRagistrationInfo.value(forKey: "email")!)"]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqCheckEmail, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    /*
     Function Name :- getIDFrom
     Function Parameters :- (key: Integer)
     Function Description :- This function used to get a selected country and state ID.
     */
    func getIDFrom(key string: Int)
    {
        if string == 1// Countr ID
        {
            let predicateSearch = NSPredicate(format: "\(ResponceKey_get_all_country.country_name) CONTAINS[C] '\(txtCountry.text!)'")
            let array = NSMutableArray(array: arrCountry.filtered(using: predicateSearch) as NSArray)
            if array.count > 0
            {
                if let responce : NSDictionary = array[0] as? NSDictionary
                {
                    countryID = Int("\(responce.value(forKey: ResponceKey_get_all_country.country_id)!)")!
                    processGetState(countryID: "\(countryID)")
                }
            }
            else{
                txtCountry.text = ""
                processGetState(countryID: "\((arrCountry[0] as! NSDictionary).value(forKey: ResponceKey_get_all_country.country_id)!)")
            }
        }
        else if string == 2// State ID
        {
            let predicateSearch = NSPredicate(format: "\(ResponceKey_get_all_state.state_name) CONTAINS[C] '\(txtState.text!)'")
            let array = NSMutableArray(array: arrState.filtered(using: predicateSearch) as NSArray)
            
            if array.count > 0
            {
                txtState.text = "\((array[0] as! NSDictionary).value(forKey: "state_name")!)"
                stateID = Int("\((array[0] as! NSDictionary).value(forKey: "state_id")!)")!
            }
            else{
                txtState.text = ""
            }
        }
    }
    
    /*
     Function Name :- locationSetup
     Function Parameters :- (nil)
     Function Description :- This function used to ask an Application Location Authorization.
     */
    func locationSetup()
    {
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        //locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        //placeBounds = GMSCoordinateBounds.init()
    }
    
    //MARK:- Locations Manager Methods
    /*
     Function Name :- locationManager
     Function Parameters :- (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
     Function Description :- Delegate mathod of location manager for updating current location.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if ((self.locationManager.location) != nil)
        {
            let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
            currentLat = locValue.latitude
            currentLong = locValue.longitude
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            //placeBounds?.includingCoordinate(locValue)
            placeBounds = GMSCoordinateBounds.init(coordinate: locValue, coordinate: locValue)
            locationManager.stopUpdatingLocation()
            // showToast(message: "Latitude : \(currentLat!) Longitude : \(currentLong!)")
        }
    }
    
    /*
     Function Name :- setAutoSreachDropDownData
     Function Parameters :- (array : NSArray)
     Function Description :- get Google Auto search place API array and convert NSArray to String array and initialize drop down.
     */
    func setAutoSreachDropDownData(array:NSArray)
    {
        initDropDown(dropDownPop: dropDownPop, dataSource: getNSArrayToStringArray(array: array, forKey: "description"), textFiled: txtGoogleAddress) { (index, value) in
            let btn = UIButton()
            btn.tag = index
            self.btnTableView(didSelect: btn)
        }
    }

}
/*
 Extension Description :- Delegate methods for the UITextFiled and UITextView
 */
extension RagistrationsSecondVC : UITextFieldDelegate, UITextViewDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == txtPostalCode
        {
            let maxLength = 6
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if textField == txtBuzzerCode
        {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        if textField == txtGoogleAddress
        {
            let strSearch : String!
            strSearch = textField.text?.appending(string).lowercased()
            if strSearch.count > 1
            {
                isAddressSelected = false
                WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).searchLocationPlaceAPI(strPlace: strSearch)
            }
            else{
                self.dropDownPop.hide()
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtGoogleAddress
        {
            txtStreetAddress.becomeFirstResponder()
        }
        else if textField == txtStreetAddress
        {
            txtSuiteNumber.becomeFirstResponder()
        }
        else if textField == txtSuiteNumber
        {
            txtCity.becomeFirstResponder()
        }
        else if textField == txtCity
        {
            txtPostalCode.becomeFirstResponder()
        }
        else if textField == txtPostalCode
        {
            btnSelectCountryClick(btnSelectCountry)
        }
        else if textField == txtState
        {
            self.view.endEditing(true)
        }
        return true
    }
    
    //MARK:- TextView Delegate methods
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        if textView == txtSpecialInstructions
        {
            self.txtSpecialInstructions.textColor = COLOR.textFiled
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtSpecialInstructions.text.count > 0 {
        } else {
            txtSpecialInstructions.text = strTextViewPlaceholder
            txtSpecialInstructions.textColor = COLOR.placeholder
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if txtSpecialInstructions.text == strTextViewPlaceholder {
            txtSpecialInstructions.textColor = COLOR.textFiled
            txtSpecialInstructions.text = ""
        }
        return true
    }
    
}

/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension RagistrationsSecondVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqGetAllCountry
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let array : NSArray = responseData.value(forKey: ResKeyData) as? NSArray
                    {
                        arrCountry = array.sorted(by: { (data1, data2) -> Bool in
                            ((data1 as! NSDictionary).value(forKey: "country_name") as! String).compare((data2 as! NSDictionary).value(forKey: "country_name") as! String) == .orderedAscending
                        }) as NSArray
                    }
                }
                else
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in }
                    }
                }
            }
        }
        else if reqTask == reqGetAllState
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let array : NSArray = responseData.value(forKey: ResKeyData) as? NSArray
                    {
                        arrState = array.sorted(by: { (data1, data2) -> Bool in
                            ((data1 as! NSDictionary).value(forKey: "state_name") as! String).compare((data2 as! NSDictionary).value(forKey: "state_name") as! String) == .orderedAscending
                        }) as NSArray
                        getIDFrom(key: 2)
                    }
                }
                else
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in }
                    }
                }
            }
        }
        else if reqTask == reqCheckEmail
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    processToRagistration()
                }
                else
                {
                    if let message :String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in }
                    }
                }
            }
        }
        else if reqTask == reqSignUp
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let response : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        setUserInfo(Data: response)
                        let controller = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "CleanMyClothesFirstVC") as! CleanMyClothesFirstVC
                        Application_Delegate.navigationController.pushViewController(controller, animated: true)
                    }
                }
                else
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in }
                    }
                }
            }
        }
        else if reqTask == reqAddUserAddress
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if delegate != nil
                    {
                        delegate?.updateAddress!()
                    }
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
                else
                {
                    Application_Delegate.showSpinnerView(isShow: false)
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message, completion: { (action) in
                            if statusCode == aouthStatus
                            {
                                Application_Delegate.processLogout()
                            }
                        })
                    }
                }
            }
        }
        else if reqTask == reqUpdateUserAddress
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        if delegate != nil
                        {
                            delegate?.updateAddress!()
                        }
                        showMyAlertView(message: message) { (action) in
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
                else
                {
                    Application_Delegate.showSpinnerView(isShow: false)
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message, completion: { (action) in
                            if statusCode == aouthStatus
                            {
                                Application_Delegate.processLogout()
                            }
                        })
                    }
                }
            }
        }
        else if reqTask == reqCheckpincode // Check Postal Code API reponce
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if screenNo == 1
                    {
//                        processToRagistration()
                        processCheckEmail()
                    }
                    else if screenNo == 2
                    {
                        processAddAddress()
                    }
                    else if screenNo == 3
                    {
                        processUpdateAddress()
                    }
                }
                else{
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in }
                    }
                }
            }
        }
        else if reqTask == reqTask_PlaceDetail_API
        {
            if let dictResult : NSDictionary = responseData.value(forKey: "result") as? NSDictionary
            {
                let location:NSDictionary = (dictResult.value(forKey: "geometry") as! NSDictionary).value(forKey: "location") as! NSDictionary
                
                if let arrTemp : NSArray = dictResult.value(forKey: "address_components") as? NSArray
                {
                    print(arrTemp)
                    txtStreetAddress.text = ""
                    txtSuiteNumber.text = ""
                    txtCity.text = ""
                    txtPostalCode.text = ""
                    var street_number = String()
                    var address = String()
                    for dicTemp in arrTemp
                    {
                        if let arrstreet_number : NSArray = (dicTemp as AnyObject).value(forKey: "types") as? NSArray
                        {
                            if arrstreet_number.firstObject as! String == "street_number"
                            {
                                street_number = "\((dicTemp as! NSDictionary).value(forKey: "long_name")!)"
                            }
                            if arrstreet_number.firstObject as! String == "sublocality_level_1"
                            {
                                if address.count > 0
                                {
                                    address.append(", \((dicTemp as! NSDictionary).value(forKey: "long_name")! )")
                                }
                                else{
                                    address.append("\((dicTemp as! NSDictionary).value(forKey: "long_name")! )")
                                }
                            }
                            if arrstreet_number.firstObject as! String == "administrative_area_level_2"
                            {
//                                txtSuiteNumber.text = (dicTemp as! NSDictionary).value(forKey: "long_name") as? String
                            }
                            if arrstreet_number.firstObject as! String == "route"
                            {
                                if address.count > 0
                                {
                                    address.append(", \((dicTemp as! NSDictionary).value(forKey: "long_name")! )")
                                }
                                else{
                                    address.append("\((dicTemp as! NSDictionary).value(forKey: "long_name")! )")
                                }
                            }
                            if arrstreet_number.firstObject as! String == "locality"
                            {
                                txtCity.text = (dicTemp as! NSDictionary).value(forKey: "long_name") as? String
                            }
                            if arrstreet_number.firstObject as! String == "administrative_area_level_1" // State Name
                            {
                                if let state : String = (dicTemp as! NSDictionary).value(forKey: "long_name") as? String
                                {
                                    self.txtState.text = state
                                }
                            }
                            if arrstreet_number.firstObject as! String == "country" // Country Name
                            {
                                if let country : String = (dicTemp as! NSDictionary).value(forKey: "long_name") as? String
                                {
                                    self.txtCountry.text = country
                                    getIDFrom(key: 1)
                                }
                            }
                            if arrstreet_number.firstObject as! String == "postal_code"
                            {
                                if let zip : String = (dicTemp as! NSDictionary).value(forKey: "long_name") as? String
                                {
                                    self.txtPostalCode.text = ""
                                    let split = zip.split(separator: " ")
                                    
                                    if split.count > 1
                                    {
                                        self.txtPostalCode.text = split.joined()
                                    }
                                    else{
                                        self.txtPostalCode.text =  "\(zip)"
                                    }
                                }
                            }
                            if address.count > 0
                            {
                                if street_number.count > 0
                                {
                                    txtStreetAddress.text = "\(street_number) \(address)"
                                }
                                else{
                                    txtStreetAddress.text = address
                                }
                            }
                        }
                    }
                }
                
                let lat:Double = (location.value(forKey: "lat") as! Double)
                let lng:Double = (location.value(forKey: "lng") as! Double)
                currentLat = lat
                currentLong = lng
                if currentLat != nil || currentLong != nil
                {
                }
            }
        }
        else if reqTask == Place_API_autocomplete
        {
            if let dictResult : NSArray = responseData.value(forKey: "predictions") as? NSArray
            {
                let array = NSMutableArray()
                for result in dictResult
                {
                    let dict = NSMutableDictionary()
                    dict.setValue("\((result as! NSDictionary).value(forKey: "description")!)", forKey: "description")
                    dict.setValue("\((result as! NSDictionary).value(forKey: "place_id")!)", forKey: "place_id")
                    array.add(dict)
                    print("Result \(array)")
                }
                self.arrLocation = array
                if self.arrLocation.count > 0
                {
                    self.setAutoSreachDropDownData(array: NSArray(array:self.arrLocation))
                    if self.isAddressSelected == false
                    {
                        self.dropDownPop.show()
                    }
                }
                else
                {
                    self.dropDownPop.hide()
                }
            }
            else{
                self.dropDownPop.hide()
            }
        }
    }
}

