//
//  ForgotPasswordVC.swift
//  SimplyLaundry
//
//  Created by webclues on 29/12/18.
//  Copyright © 2018 webclues. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    //Content view outlet's
    @IBOutlet weak var viewContent:UIView!
    
    @IBOutlet weak var lblVCInstractionTitle:UILabel!
    
    @IBOutlet weak var viewEmail:UIView!
    @IBOutlet weak var txtEmail:UITextField!
    
    @IBOutlet weak var btnSendCode: UIButton!
    @IBOutlet weak var viewButtonCircle:UIView!

    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
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
        
        lblVCTitle.setVCTitle("Forgot Password")
        
        btnBack.setTitle("", for: .normal)
        btnBack.setImage(UIImage.init(named: "back"), for: .normal)
        btnBack.tintColor = COLOR.White
        btnBack.addTarget(self, action: #selector(btnBackClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        
        lblVCInstractionTitle.text = "We will send new password to your registered email address."
        lblVCInstractionTitle.textColor = COLOR.Gray
        lblVCInstractionTitle.numberOfLines = 0
        lblVCInstractionTitle.lineBreakMode = .byWordWrapping
        lblVCInstractionTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        
        viewEmail.backgroundColor = COLOR.background_Gray
        viewEmail.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtEmail.setThemeWithImageNoCorrection("Email Address*", keyboardType : .emailAddress, imageName: "email_address")
        
        btnSendCode.setThemeForAppButton("SEND PASSWORD")
        btnSendCode.addTarget(self, action: #selector(btnSendCodeClick(_:)), for: .touchUpInside)
        
        viewButtonCircle.backgroundColor = COLOR.White
        viewButtonCircle.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: viewButtonCircle.frame.height / 2)
    }
    
    //MARK:- Button Actions
    @IBAction func btnBackClick(_ sender:Any)
    {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSendCodeClick(_ sender:Any)
    {
        var strmessage = String()
        if (txtEmail.text?.count)! <= 0
        {
            strmessage = "Email Address is Required."
        }
        else if emailValidation(strEmail: txtEmail.text!) == false{
            strmessage = "Enter Valid Email Address."
        }
        
        if strmessage.count > 0
        {
            self.view.endEditing(true)
            showMyAlertView(message: strmessage) { (action) in }
        }
        else{
            self.view.endEditing(true)
            processForgotPassword()
        }
        
    }

    //MARK:- API Call Funtions
    /*
     Function Name :- processForgotPassword
     Function Parameterts :- nil
     Function Description :- This function used to call the API for forgot password.
     */
    func processForgotPassword(){
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["email":"\(txtEmail.text!)"]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqForgotPassword, dictParameter: parameters as NSDictionary,isHeader: false)

    }
    
}
/*
 Extension Description :- Delegate methods for the UITextFiled.
 */
extension ForgotPasswordVC : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail
        {
            txtEmail.resignFirstResponder()
            self.view.endEditing(true)
        }
        return true
    }
}

/*
 Extension Description :- Delegate methods for the Response of API Calling.
 */
extension ForgotPasswordVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqForgotPassword
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                self.txtEmail.text = ""
                if statusCode == successStatus
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
                else if statusCode == 5
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
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
    }
}
