//
//  RagistrationsVC.swift
//  SimplyLaundry
//
//  Created by webclues on 29/12/18.
//  Copyright © 2018 webclues. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookLogin
import FacebookCore
import DropDown

class RagistrationsFirstVC: UIViewController {
    
    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    
    //Content view outlet's
    @IBOutlet weak var scrollContent:UIScrollView!
    @IBOutlet weak var viewContent:UIView!
    
    @IBOutlet weak var viewRegistrationType:UIView!
    @IBOutlet weak var btnIndividual:UIButton!
    @IBOutlet weak var btnBusiness:UIButton!
    
    //Company Name View Outlet's
    @IBOutlet weak var viewCompanyName:UIView!
    @IBOutlet weak var txtCompanyName:UITextField!
    @IBOutlet weak var consViewCompanyNameTop: NSLayoutConstraint!

    @IBOutlet weak var viewFristName:UIView!
    @IBOutlet weak var txtFristName:UITextField!
    @IBOutlet weak var imgFristName:UIImageView!
    
    @IBOutlet weak var viewLastName:UIView!
    @IBOutlet weak var txtLastName:UITextField!
    @IBOutlet weak var imgLastName:UIImageView!
    
    @IBOutlet weak var viewEmail:UIView!
    @IBOutlet weak var txtEmail:UITextField!
    @IBOutlet weak var imgEmail:UIImageView!
    
    @IBOutlet weak var viewPassword:UIView!
    @IBOutlet weak var txtPassword:UITextField!
    @IBOutlet weak var btnPasswordShow:UIButton!
    @IBOutlet weak var consViewPasswordTop: NSLayoutConstraint! // Constraint: set 30 for Show and When hide set (35 is txtPassword height) = -35
    
    @IBOutlet weak var viewReffarCode:UIView!
    @IBOutlet weak var txtReffarCode:UITextField!
    
    @IBOutlet weak var viewPhoneNo:UIView!
    @IBOutlet weak var txtPhoneNo:UITextField!
    @IBOutlet weak var imgPhoneNo:UIImageView!
    
    @IBOutlet weak var viewQuestion:UIView!
    @IBOutlet weak var txtQuestion:UITextField!
    @IBOutlet weak var imgQuestion:UIImageView!
    @IBOutlet weak var btnQuestion:UIButton!
    
    @IBOutlet weak var viewOtherNotes:UIView!
    @IBOutlet weak var txtOtherNotes:UITextView!
    @IBOutlet weak var consViewOtherNotesTop: NSLayoutConstraint! // Constraint: set 90 for Show and When hide set 0

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewButtonCircle:UIView!
    
    @IBOutlet weak var lblSeparatorLeft:UILabel!
    @IBOutlet weak var lblORTitle:UILabel!
    @IBOutlet weak var lblSeparatorRight:UILabel!
    
    @IBOutlet weak var btnLoginWithFB: UIButton!
    @IBOutlet weak var btnLoginWithGoogle: UIButton!
    
    @IBOutlet weak var lblNewUserTitle:UILabel!
    @IBOutlet weak var btnLogin:UIButton!
    
    // Variable Declarations
    var dicRagistrationInfo : NSMutableDictionary = NSMutableDictionary()
    var screenNo : Int = 1 // Screen Number =  1: Normal Ragistration, 2: Google Ragistration, 3: FB Ragistration
    var RagistrationsType : Int = 1
    var intRegisteredVia : Int = 0 // 0: Normal Ragistration, 1: Google Ragistration, 2: Facebook Ragistration
    var strTextViewPlaceholder = "Other Notes*"
    var arrQuestionList = NSArray()
    var strQuestionID = String()
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        setDataAccrodingToScreen()
        processGetQustionList()
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
        
        lblVCTitle.setVCTitle("Registration")

        //content theme
        scrollContent.setThemeForScrollView()
        viewContent.backgroundColor = COLOR.White
        
        viewRegistrationType.backgroundColor = COLOR.clear
        
        btnIndividual.setThemeForRadioBtton("Individual",isSelected: true)
        btnIndividual.addTarget(self, action: #selector(btnChekUncheckClick(_:)), for: .touchUpInside)
        
        btnBusiness.setThemeForRadioBtton("Business")
        btnBusiness.addTarget(self, action: #selector(btnChekUncheckClick(_:)), for: .touchUpInside)
        
        viewCompanyName.backgroundColor = COLOR.background_Gray
        viewCompanyName.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        viewCompanyName.isHidden = true
        txtCompanyName.setThemeFor( "Company Name*")
        txtCompanyName.delegate = self
        consViewCompanyNameTop.constant = -(viewCompanyName.bounds.height)

        viewFristName.backgroundColor = COLOR.background_Gray
        viewFristName.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtFristName.setThemeFor("First Name*")
        txtFristName.delegate = self
        imgFristName.image = UIImage.init(named: "first_name")

        viewLastName.backgroundColor = COLOR.background_Gray
        viewLastName.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtLastName.setThemeFor("Last Name*")
        txtLastName.delegate = self
        imgLastName.image = UIImage.init(named: "first_name")

        viewEmail.backgroundColor = COLOR.background_Gray
        viewEmail.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtEmail.setThemeFor("Email Address*", keyboardType : .emailAddress)
        txtEmail.delegate = self
        txtEmail.autocorrectionType = .no
        txtEmail.autocapitalizationType = .none
        imgEmail.image = UIImage.init(named: "email_address")
        
        viewPassword.backgroundColor = COLOR.background_Gray
        viewPassword.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtPassword.setThemeFor("Password*")
        txtPassword.delegate = self
        txtPassword.autocorrectionType = .no
        txtPassword.autocapitalizationType = .none
        txtPassword.isSecureTextEntry = true
        btnPasswordShow.setThemeForPSWButton("SHOW")
        btnPasswordShow.addTarget(self, action: #selector(btnPasswordShowClick(_:)), for: .touchUpInside)
        
        viewReffarCode.backgroundColor = COLOR.background_Gray
        viewReffarCode.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtReffarCode.setThemeFor("Referral Code")
        txtReffarCode.delegate = self
        
        viewPhoneNo.backgroundColor = COLOR.background_Gray
        viewPhoneNo.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtPhoneNo.setThemeFor("Phone Number*", keyboardType : .numberPad, returnKeyType : .default)
        txtPhoneNo.delegate = self
        imgPhoneNo.image = UIImage.init(named: "phone")
        
        viewQuestion.backgroundColor = COLOR.background_Gray
        viewQuestion.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtQuestion.setThemeFor("Select How did you hear about us?")
        txtQuestion.delegate = self
        imgQuestion.image = UIImage.init(named: "down_arrow")
        btnQuestion.setTitle("", for: .normal)
        btnQuestion.addTarget(self, action: #selector(btnSelectQuestionClick(_:)), for: .touchUpInside)

        viewOtherNotes.backgroundColor = COLOR.background_Gray
        viewOtherNotes.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        viewOtherNotes.isHidden = true
        txtOtherNotes.setThemeFor(strTextViewPlaceholder, returnKeyType : .continue)
        txtOtherNotes.delegate = self
        consViewOtherNotesTop.constant = -(viewOtherNotes.bounds.height)
        
        btnNext.setThemeForAppButton("NEXT")
        btnNext.addTarget(self, action: #selector(btnNextClick(_:)), for: .touchUpInside)
        
        viewButtonCircle.backgroundColor = COLOR.White
        viewButtonCircle.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: viewButtonCircle.frame.height / 2)
        
        lblSeparatorLeft.text = "------------------------------------------------------------------"
        lblSeparatorLeft.textColor = COLOR.Gray
        lblSeparatorLeft.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        lblSeparatorLeft.numberOfLines = 1
        lblSeparatorLeft.lineBreakMode = .byWordWrapping
        
        lblORTitle.text = "OR"
        lblORTitle.textColor = COLOR.Balck
        lblORTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        
        lblSeparatorRight.text = "------------------------------------------------------------------"
        lblSeparatorRight.textColor = COLOR.Gray
        lblSeparatorRight.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        lblSeparatorRight.numberOfLines = 1
        lblSeparatorRight.lineBreakMode = .byWordWrapping
        
        btnLoginWithFB.setTitle("", for: .normal)
        btnLoginWithFB.setImage(UIImage(named: "facebook"), for: .normal)
        btnLoginWithFB.backgroundColor = COLOR.FBBlue
        btnLoginWithFB.tintColor = COLOR.clear
        btnLoginWithFB.addTarget(self, action: #selector(btnLoginWithFBClick(_:)), for: .touchUpInside)
        btnLoginWithFB.setCornerRadius(corner:5)

        btnLoginWithGoogle.setTitle("", for: .normal)
        btnLoginWithGoogle.setImage(UIImage(named: "google"), for: .normal)
        btnLoginWithGoogle.backgroundColor = COLOR.GoogleGrey
        btnLoginWithGoogle.tintColor = COLOR.clear
        btnLoginWithGoogle.addTarget(self, action: #selector(btnLoginWithGoogleClick(_:)), for: .touchUpInside)
        btnLoginWithGoogle.setCornerRadius(corner:5)

        lblNewUserTitle.text = "Already have an account?"
        lblNewUserTitle.textColor = COLOR.Gray
        lblNewUserTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_THIRTEEN)
        
        btnLogin.setTitle("LOGIN", for: .normal)
        btnLogin.backgroundColor = COLOR.clear
        btnLogin.setTitleColor(COLOR.Green, for: .normal)
        btnLogin.titleLabel?.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_THIRTEEN)
        btnLogin.addTarget(self, action: #selector(btnLoginClick(_:)), for: .touchUpInside)
    }
    
    //MARK:- Button Actions
    @IBAction func btnChekUncheckClick(_ sender : UIButton)
    {
        if sender == btnIndividual // For Individual
        {
            RagistrationsType = 1
            btnIndividual.setImage(UIImage.init(named: "radio_button_selected"), for: .normal)
            btnBusiness.setImage(UIImage.init(named: "radio_button"), for: .normal)
            consViewCompanyNameTop.constant = -(viewCompanyName.bounds.height)
            viewCompanyName.isHidden = true
        }
        else{ // For Business
            RagistrationsType = 2
            btnIndividual.setImage(UIImage.init(named: "radio_button"), for: .normal)
            btnBusiness.setImage(UIImage.init(named: "radio_button_selected"), for: .normal)
            consViewCompanyNameTop.constant = 20
            viewCompanyName.isHidden = false
        }
    }
    
    @IBAction func btnPasswordShowClick(_ sender:Any)
    {
        if txtPassword.isSecureTextEntry == true
        {
            txtPassword.isSecureTextEntry = false
            btnPasswordShow.setTitle("HIDE", for: .normal)
        }
        else{
            txtPassword.isSecureTextEntry = true
            btnPasswordShow.setTitle("SHOW", for: .normal)
        }
    }
    
    @IBAction func btnSelectQuestionClick(_ sender:Any)
    {
        self.view.endEditing(true)
        initDropDown(dataSource: getNSArrayToStringArray(array: arrQuestionList, forKey: ResponceKey_get_how_hear_about_ust.label), textFiled: txtQuestion) { (index, value) in
            self.strQuestionID = "\((self.arrQuestionList[index] as! NSDictionary).value(forKey: ResponceKey_get_how_hear_about_ust.how_hear_about_us_id)!)"
            if self.strQuestionID == "9"
            {
                self.consViewOtherNotesTop.constant = 20
                self.viewOtherNotes.isHidden = false
            }
            else{
                self.consViewOtherNotesTop.constant = -(self.viewOtherNotes.bounds.height)
                self.viewOtherNotes.isHidden = true
            }
        }
    }
    
    @IBAction func btnNextClick(_ sender:Any)
    {
        var strmessage = String()
        if (txtFristName.text?.count)! <= 0
        {
            strmessage = "First Name is Required."
        }
        else if (txtLastName.text?.count)! <= 0
        {
            strmessage = "Last Name is Required."
        }
        else if (txtEmail.text?.count)! <= 0
        {
            strmessage = "Email Address is Required."
        }
        else if emailValidation(strEmail: txtEmail.text!) == false{
            strmessage = "Enter Valid Email Address."
        }
        else if (txtPhoneNo.text?.count)! <= 0
        {
            strmessage = "Phone Number is Required."
        }
        else if (txtPhoneNo.text?.count)! < 12
        {
            strmessage = "Phone Number minimum to 10 Number."
        }
        else if screenNo == 1
        {
            if (txtPassword.text?.count)! <= 0
            {
                strmessage = "Password is Required."
            }
            else if (txtPassword.text?.count)! < 8
            {
                strmessage = "Password Minimum to 8 character."
            }
        }
        
        if RagistrationsType == 2
        {
            if (txtCompanyName.text?.count)! <= 0
            {
                strmessage = "Company Name is Required."
            }
        }
        if strQuestionID == "9"
        {
            if (txtOtherNotes.text?.count)! <= 0 || txtOtherNotes.text == strTextViewPlaceholder
            {
                strmessage = "Other Notes is Required."
            }
        }
        
        if strmessage.count > 0
        {
            self.view.endEditing(true)
            showMyAlertView(message: strmessage) { (action) in }
        }
        else{
            self.view.endEditing(true)
            dicRagistrationInfo = ["user_type":"\(RagistrationsType == 1 ? "Individual":"Company" )",
                "company":RagistrationsType == 1 ? "":txtCompanyName.text!,
                "firstname":"\(txtFristName.text!)",
                "lastname":"\(txtLastName.text!)",
                "email":"\(txtEmail.text!)",
                "password":"\(txtPassword.text!)",
                "referral_code":"\(txtReffarCode.text!)",
                "phone":"\(txtPhoneNo.text!)",
                "registered_via":intRegisteredVia,
                "how_hear_about_us_id":"\(strQuestionID)",
                "other_notes":"\(strQuestionID == "9" ? txtOtherNotes.text! : "")"
            ]
            
            if screenNo == 1
            {
                processCheckEmail()
            }
            else if screenNo == 2 || screenNo == 3 {
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "RagistrationsSecondVC") as! RagistrationsSecondVC
                controller.dicRagistrationInfo = NSMutableDictionary(dictionary: dicRagistrationInfo)
                self.navigationController?.pushViewController(controller, animated: true)
            }
            
        }
        
    }
    
    @IBAction func btnLoginWithFBClick(_ sender:Any)
    {
        setTheme()
        self.view.endEditing(true)
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { result in
            self.loginManagerDidComplete(result)
            loginManager.logOut()
        }

    }
    
    @IBAction func btnLoginWithGoogleClick(_ sender:Any)
    {
        setTheme()
        self.view.endEditing(true)
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func btnLoginClick(_ sender:Any)
    {
        self.view.endEditing(true)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    //MARK:- Supporting functions
    /*
     Function Name :- setDataAccrodingToScreen()
     Function Parameters :- nil
     Function Description :- This function used to set a theme for Controller initial screen values
     */
    func setDataAccrodingToScreen()
    {
        if screenNo == 2 // Ragistration With Google
        {
            intRegisteredVia = 1
            consViewPasswordTop.constant = -45
            txtFristName.text = (dicRagistrationInfo.value(forKey: "firstname") as! String)
            txtLastName.text = (dicRagistrationInfo.value(forKey: "lastname") as! String)
            txtEmail.text = (dicRagistrationInfo.value(forKey: "email") as! String)
            txtEmail.isUserInteractionEnabled = false
            viewPassword.isHidden = true
        }
        else if screenNo == 3 // Ragistration With FB
        {
            intRegisteredVia = 2
            consViewPasswordTop.constant = -45
            txtFristName.text = (dicRagistrationInfo.value(forKey: "firstname") as! String)
            txtLastName.text = (dicRagistrationInfo.value(forKey: "lastname") as! String)
            txtEmail.text = (dicRagistrationInfo.value(forKey: "email") as! String)
            txtEmail.isUserInteractionEnabled = false
            viewPassword.isHidden = true
        }
        Application_Delegate.showSpinnerView(isShow: false)
    }
    
    /*
     Function Name :- processCheckEmail
     Function Parameters :- nil
     Function Description :- This function used to call the API for the check email address is exist or not.
     */
    func processCheckEmail(){
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["email":"\(txtEmail.text!)"]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqCheckEmail, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    /*
     Function Name :- processLogin
     Function Parameterts :- optional parameterts (auth : String)
     Function Description :- This function used to call the API for login and if the user is already lagging in another device then give an authorization.
     */
    func processLogin(auth:String = "")
    {
        self.view.endEditing(true)
        Application_Delegate.showSpinnerView(isShow: true)
        var parameters : [String:Any] = ["device_type":Str_Device_Type,"registered_via":intRegisteredVia]
        if auth != ""
        {
            parameters["auth_details"] = auth
        }
            
        if intRegisteredVia == 1
        {
            parameters["login"] = "\(dicRagistrationInfo.value(forKey: "email")!)"
            parameters["acc_id"] = "\(dicRagistrationInfo.value(forKey: "google_id")!)"
        }
        else if intRegisteredVia == 2
        {
            parameters["login"] = "\(dicRagistrationInfo.value(forKey: "email")!)"
            parameters["acc_id"] = "\(dicRagistrationInfo.value(forKey: "fb_id")!)"
        }
        
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqLogin, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    /*
     Function Name :- processCheckRefer
     Function Parameterts :- nil
     Function Description :- This function used to call the API for check refer code is valid or not.
     */
    func processCheckRefer()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["referral_code":"\(txtReffarCode.text!)"]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqVerifyReferralCode, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    /*
     Function Name :- processGetQustionList
     Function Parameterts :- nil
     Function Description :- This function used to call the API for getting a questions list for user get a reference for this application.
     */
    func processGetQustionList()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = [:]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetHowHearAboutUs, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    //MARK:- Login and Ragistration with Facebook mrthod
    /*
     Function Name :- loginManagerDidComplete
     Function Parameterts :- (result : facebook Login Result)
     Function Description :- This function used to logn or signup with Facebook.
     */
    func loginManagerDidComplete(_ result: LoginResult) {
        Application_Delegate.showSpinnerView(isShow: false)
        switch result {
        case .cancelled:
            print("Cancell")
        case .failed(let error):
            print("Login failed with error \(error)")
        case .success(let grantedPermissions, _, _):
            Application_Delegate.showSpinnerView(isShow: true)
            print("Login succeeded with granted permissions: \(grantedPermissions)")
            let graphRequest:GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"id,interested_in,gender,birthday,email,age_range,name, first_name, last_name, picture.width(480).height(480)"], accessToken: AccessToken.current, httpMethod: .POST, apiVersion: .defaultVersion)
            
            graphRequest.start({ (urlResponse, requestResult) in
                
                switch requestResult
                {
                case .failed(let error):
                    print("error in graph request:", error)
                    break
                case .success(let graphResponse):
                    if let responseDictionary : NSDictionary = graphResponse.dictionaryValue as NSDictionary?
                    {
                        print("Facebook Responce:- \(responseDictionary)")
                        self.intRegisteredVia = 2
                        self.dicRagistrationInfo = ["fb_id":"\(responseDictionary.value(forKey: "id")!)",
                            "firstname":"\(responseDictionary.value(forKey: "first_name")!)",
                            "lastname":"\(responseDictionary.value(forKey: "last_name")!)",
                            "email":"\(responseDictionary.value(forKey: "email")!)"]
                        self.processLogin()
                    }
                }
            })
        }
    }
    
}
/*
 Extension Description :- Delegate methods for the UITextFiled and UITextView
 */
extension RagistrationsFirstVC : UITextFieldDelegate, UITextViewDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFristName || textField == txtLastName
        {
            let maxLength = 35
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length <= maxLength
            {
                let myCharSet=CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
                let output: String = string.trimmingCharacters(in: myCharSet.inverted)
                let isValid: Bool = (string == output)
                print("\(isValid)")
                
                return isValid
            }
            return newString.length <= maxLength
        }
        else if textField == txtCompanyName
        {
            let myCharSet=CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .")
            let output: String = string.trimmingCharacters(in: myCharSet.inverted)
            let isValid: Bool = (string == output)
            print("\(isValid)")
            
            return isValid
        }
        else if textField == txtPhoneNo
        {
            if string != ""
            {
                let maxLength = 12
                let currentString: NSString = textField.text! as NSString
                let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                if newString.length == 4
                {
                    txtPhoneNo.text?.append("-")
                }
                else if newString.length == 8
                {
                    txtPhoneNo.text?.append("-")
                }
                if newString.length <= maxLength
                {
                    let myCharSet=CharacterSet(charactersIn:"0123456789-")
                    let output: String = string.trimmingCharacters(in: myCharSet.inverted)
                    let isValid: Bool = (string == output)
                    print("\(isValid)")
                    
                    return isValid
                }
                return newString.length <= maxLength
            }
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFristName
        {
            txtLastName.becomeFirstResponder()
        }
        else if textField == txtLastName
        {
            txtEmail.becomeFirstResponder()
        }
        else if textField == txtEmail
        {
            txtPassword.becomeFirstResponder()
        }
        else if textField == txtPassword
        {
            txtReffarCode.becomeFirstResponder()
        }
        else if textField == txtReffarCode
        {
            txtPhoneNo.becomeFirstResponder()
        }
        else if textField == txtPhoneNo
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
        if textView == txtOtherNotes
        {
            self.txtOtherNotes.textColor = COLOR.textFiled
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtOtherNotes.text.count > 0 {
        } else {
            txtOtherNotes.text = strTextViewPlaceholder
            txtOtherNotes.textColor = COLOR.placeholder
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if txtOtherNotes.text == strTextViewPlaceholder {
            txtOtherNotes.textColor = COLOR.textFiled
            txtOtherNotes.text = ""
        }
        return true
    }
}

/*
Extension Description :- Delegate methods for the Google SignIn
 */
extension RagistrationsFirstVC : GIDSignInDelegate, GIDSignInUIDelegate
{
    //MARK: - Google Delegate Methods
    func sign(inWillDispatch signIn: GIDSignIn?) throws {
        //        myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) {
        if let aController = viewController {
            present(aController, animated: true) {() -> Void in }
        }
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) {
        dismiss(animated: true) {() -> Void in }
        Application_Delegate.showSpinnerView(isShow: false)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            Application_Delegate.showSpinnerView(isShow: false)
        } else {
            // Perform any operations on signed in user here.
            print(user.userID)                 // For client-side use only!
            print(user.authentication.idToken) // Safe to send to the server
            print(user.profile.name)
            print(user.profile.givenName)
            print(user.profile.familyName)
            print(user.profile.email)
            Application_Delegate.showSpinnerView(isShow: true)
            self.screenNo = 2
            self.intRegisteredVia = 1
            self.dicRagistrationInfo = ["google_id":"\(user.userID!)","device_token":"\(user.authentication.idToken!)","firstname":"\(user.profile.givenName!)","lastname":"\(user.profile.familyName!)","email":"\(user.profile.email!)"]
            processLogin()
        }
    }
    
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension RagistrationsFirstVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqCheckEmail
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if (txtReffarCode.text?.count)! != 0
                    {
                        processCheckRefer()
                    }
                    else{
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RagistrationsSecondVC") as! RagistrationsSecondVC
                        controller.dicRagistrationInfo = NSMutableDictionary(dictionary: dicRagistrationInfo)
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                }
                else if statusCode == 5
                {
                    if let message :String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                         showMyAlertView(message: message) { (action) in }
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
        else if reqTask == reqVerifyReferralCode
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "RagistrationsSecondVC") as! RagistrationsSecondVC
                    controller.dicRagistrationInfo = NSMutableDictionary(dictionary: dicRagistrationInfo)
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                else if statusCode == 5
                {
                    if let message :String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                         showMyAlertView(message: message) { (action) in }
                    }
                }
            }
        }
        else if reqTask == reqGetHowHearAboutUs
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let ResKeyData : NSArray = responseData.value(forKey: ResKeyData) as? NSArray
                    {
                        _ = ResponceKey_get_how_hear_about_us.init(dic: ResKeyData)
                        arrQuestionList = ResponceKey_get_how_hear_about_us.arrHowAboutUs
                        strQuestionID = "0"
                    }
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
        if reqTask == reqLogin
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
                else if statusCode == 10
                {
                    let message : String = (responseData.value(forKey: "message") as? String)!
                    showMyAlertView(message: message,title: [Alert_no,Alert_yes]) { (action) in
                        if action.title == Alert_yes{
                            self.processLogin(auth: "yes")
                        }
                    }
                }
                else if statusCode == 5
                {
                    self.screenNo = 2
                    setTheme()
                    setDataAccrodingToScreen()
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
    }
}
