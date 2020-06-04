//
//  ViewController.swift
//  SimplyLaundry
//
//  Created by webclues on 28/12/18.
//  Copyright © 2018 webclues. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookCore
import FacebookLogin


class LoginVC: UIViewController {

    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    
    //Content view outlet's
    @IBOutlet weak var scrollContent:UIScrollView!
    @IBOutlet weak var viewContent:UIView!
    
    @IBOutlet weak var viewEmail:UIView!
    @IBOutlet weak var txtEmail:UITextField!
    
    @IBOutlet weak var viewPassword:UIView!
    @IBOutlet weak var txtPassword:UITextField!
    @IBOutlet weak var btnPasswordShow:UIButton!
    
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var viewLoginButtonCircle:UIView!
    
    @IBOutlet weak var lblSeparatorLeft:UILabel!
    @IBOutlet weak var lblORTitle:UILabel!
    @IBOutlet weak var lblSeparatorRight:UILabel!
    
    @IBOutlet weak var btnLoginWithFB: UIButton!
    @IBOutlet weak var btnLoginWithGoogle: UIButton!
    
    @IBOutlet weak var lblNewUserTitle:UILabel!
    @IBOutlet weak var btnRagistration:UIButton!
    
    // Variable Declarations
    var dicSocialLoginDetails : NSMutableDictionary = NSMutableDictionary()
    var intRegisteredVia : Int = 0 // 0: Normal Ragistration, 1: Google Ragistration, 2: Facebook Ragistration
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        callMethodAfterDelay(funcName: #selector(removeAllNotification))
    }

    override func viewWillAppear(_ animated: Bool) {
        ResponceKey_ReferrDetails.dicFereDetails = NSDictionary()
        arrAddressMain = NSArray()
    }
    
    @objc func removeAllNotification()
    {
        Application_Delegate.DeleteNotification()
//        UIApplication.init().applicationIconBadgeNumber = 0
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
        
        lblVCTitle.setVCTitle("Login")
        
        //content theme
        scrollContent.setThemeForScrollView()
        viewContent.backgroundColor = COLOR.White
        
        viewEmail.backgroundColor = COLOR.background_Gray
        viewEmail.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtEmail.setThemeWithImageNoCorrection("Email Address*", keyboardType : .emailAddress, imageName: "email_address")
        txtEmail.delegate = self
        
        viewPassword.backgroundColor = COLOR.background_Gray
        viewPassword.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtPassword.setThemeFor("Password*", returnKeyType : .continue)
        txtPassword.delegate = self
        txtPassword.autocorrectionType = .no
        txtPassword.autocapitalizationType = .none
        txtPassword.isSecureTextEntry = true
        btnPasswordShow.setThemeForPSWButton("SHOW")
        btnPasswordShow.addTarget(self, action: #selector(btnPasswordShowClick(_:)), for: .touchUpInside)
        
        btnForgotPassword.setTitle("Forgot Password?", for: .normal)
        btnForgotPassword.setTitleColor(COLOR.Blue_light, for: .normal)
        btnForgotPassword.titleLabel?.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_THIRTEEN)
        btnForgotPassword.addTarget(self, action: #selector(btnForgotPasswordClick(_:)), for: .touchUpInside)
        
        btnLogin.setThemeForAppButton("LOGIN")
        btnLogin.addTarget(self, action: #selector(btnLoginClick(_:)), for: .touchUpInside)
        
        viewLoginButtonCircle.backgroundColor = COLOR.White
        viewLoginButtonCircle.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: viewLoginButtonCircle.frame.height / 2)
        
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
        btnLoginWithGoogle.tintColor = COLOR.clear
        btnLoginWithGoogle.backgroundColor = COLOR.GoogleGrey
        btnLoginWithGoogle.addTarget(self, action: #selector(btnLoginWithGoogleClick(_:)), for: .touchUpInside)
        btnLoginWithGoogle.setCornerRadius(corner:5)
        
        lblNewUserTitle.text = "Don't have an account yet?"
        lblNewUserTitle.textColor = COLOR.Gray
        lblNewUserTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_THIRTEEN)
        
        btnRagistration.setTitle("REGISTER NOW", for: .normal)
        btnRagistration.backgroundColor = COLOR.clear
        btnRagistration.setTitleColor(COLOR.Green, for: .normal)
        btnRagistration.titleLabel?.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_THIRTEEN)
        btnRagistration.addTarget(self, action: #selector(btnRegistoratiobClick(_:)), for: .touchUpInside)
    }

    //MARK:- Button Actions
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
    
    @IBAction func btnForgotPasswordClick(_ sender:Any)
    {
//        self.view.endEditing(true)
        txtEmail.text = ""
        txtPassword.text = ""
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnLoginClick(_ sender:Any)
    {
        var strmessage = String()
        if (txtEmail.text?.count)! <= 0
        {
            strmessage = "Email Address is Required."
        }
        else if emailValidation(strEmail: txtEmail.text!) == false{
           strmessage = "Please Enter a Validate Email Address."
        }
        else if (txtPassword.text?.count)! <= 0
        {
            strmessage = "Password is Required."
        }
        
        if strmessage.count > 0
        {
            self.view.endEditing(true)
            showMyAlertView(message: strmessage) { (action) in }
        }
        else{
           processLogin()
        }
        
    }
    
    @IBAction func btnLoginWithFBClick(_ sender:Any)
    {
        setTheme()
        self.view.endEditing(true)
        LoginManager().logOut()
        
        LoginManager().logIn(readPermissions: [.publicProfile, .email], viewController: self) { result in
            self.loginManagerDidComplete(result)
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
    
    @IBAction func btnRegistoratiobClick(_ sender:Any)
    {
        self.view.endEditing(true)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RagistrationsFirstVC") as! RagistrationsFirstVC
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    //MARK:- API Calling
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
        if intRegisteredVia == 0
        {
            parameters["login"] = "\(txtEmail.text!)"
            parameters["password"] = "\(txtPassword.text!)"
            
        }
        else if intRegisteredVia == 1
        {
            parameters["login"] = "\(dicSocialLoginDetails.value(forKey: "email")!)"
            parameters["acc_id"] = "\(dicSocialLoginDetails.value(forKey: "google_id")!)"
        }
        else if intRegisteredVia == 2
        {
            parameters["login"] = "\(dicSocialLoginDetails.value(forKey: "email")!)"
            parameters["acc_id"] = "\(dicSocialLoginDetails.value(forKey: "fb_id")!)"
        }
        parameters["device_token"] = TAG_Device_Token
        parameters["device_id"] = DEVICE_ID
        parameters["device_type"] = Str_Device_Type
        
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqLogin, dictParameter: parameters as NSDictionary,isHeader: false)
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
                        self.dicSocialLoginDetails = ["fb_id":"\(responseDictionary.value(forKey: "id")!)",
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
 Extension Description :- Delegate methods for the UITextFiled
 */
extension LoginVC : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail
        {
            txtPassword.becomeFirstResponder()
        }
        else if textField == txtPassword
        {
            txtPassword.resignFirstResponder()
            btnLoginClick(btnLogin)
        }
        return true
    }
}

/*
 Extension Description :- Delegate methods for the Google SignIn
 */
extension LoginVC : GIDSignInDelegate, GIDSignInUIDelegate
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
            print(user.userID!)                 // For client-side use only!
            print(user.authentication.idToken!) // Safe to send to the server
            print(user.profile.name!)
            print(user.profile.givenName!)
            print(user.profile.familyName!)
            print(user.profile.email!)
            intRegisteredVia = 1
            self.dicSocialLoginDetails = ["google_id":"\(user.userID!)","device_token":"\(user.authentication.idToken!)","firstname":"\(user.profile.givenName!)","lastname":"\(user.profile.familyName!)","email":"\(user.profile.email!)"]
            processLogin()
        }
    }
}

/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension LoginVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqLogin
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let response : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        print(response)
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
                    if intRegisteredVia == 1 // ragistration With Google
                    {
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RagistrationsFirstVC") as! RagistrationsFirstVC
                        controller.screenNo = 2
                        controller.dicRagistrationInfo = NSMutableDictionary(dictionary: dicSocialLoginDetails)
                        self.navigationController?.pushViewController(controller, animated: true)

                    }
                    else if intRegisteredVia == 2 // ragistration With Facebook
                    {
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RagistrationsFirstVC") as! RagistrationsFirstVC
                        controller.screenNo = 3
                        controller.dicRagistrationInfo = NSMutableDictionary(dictionary: dicSocialLoginDetails)
                        self.navigationController?.pushViewController(controller, animated: true)

                    }
                    else{
                        if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                        {
                            showMyAlertView(message: message) { (action) in }
                        }
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
    }
}
