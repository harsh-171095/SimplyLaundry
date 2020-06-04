//
//  ChangePassowrdVC.swift
//  SimplyLaundry
//
//  Created by webclues on 03/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class ChangePassowrdVC: UIViewController {
    
    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header View Outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnBack:UIButton!
    
    //Content View Outlet's
    @IBOutlet weak var scrollContent:UIScrollView!
    @IBOutlet weak var viewContent:UIView!
    
    //Old Password View Outlet's
    @IBOutlet weak var viewOldPasswordParent:UIView!
    @IBOutlet weak var lblOldPasswordTitle:UILabel!
    @IBOutlet weak var viewOldPassword:UIView!
    @IBOutlet weak var txtOldPassword:UITextField!
    @IBOutlet weak var btnOldPasswordShow:UIButton!
    
    //New Password View Outlet's
    @IBOutlet weak var viewNewPasswordParent:UIView!
    @IBOutlet weak var lblNewPasswordTitle:UILabel!
    @IBOutlet weak var viewNewPassword:UIView!
    @IBOutlet weak var txtNewPassword:UITextField!
    @IBOutlet weak var btnNewPasswordShow:UIButton!
    
    //Confrim Password View Outlet's
    @IBOutlet weak var viewConfrimPasswordParent:UIView!
    @IBOutlet weak var lblConfrimPasswordTitle:UILabel!
    @IBOutlet weak var viewConfrimPassword:UIView!
    @IBOutlet weak var txtConfrimPassword:UITextField!
    @IBOutlet weak var btnConfrimPasswordShow:UIButton!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var viewButtonCircle: UIView!
    
    // Variable Declarations and Initlizations
    
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
        
        lblVCTitle.setVCTitle("Change Password")
        
        btnBack.setTitle("", for: .normal)
        btnBack.setImage(UIImage.init(named: "back"), for: .normal)
        btnBack.addTarget(self, action: #selector(btnBackClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        scrollContent.backgroundColor = COLOR.White
        
        viewOldPasswordParent.backgroundColor = COLOR.clear
        lblOldPasswordTitle.text = "Old Password"
        lblOldPasswordTitle.textColor = COLOR.Gray
        lblOldPasswordTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        viewOldPassword.backgroundColor = COLOR.background_Gray
        viewOldPassword.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtOldPassword.setThemeFor("Old Password*")
        txtOldPassword.isSecureTextEntry = true
        txtOldPassword.delegate = self
        txtOldPassword.autocorrectionType = .no
        txtOldPassword.autocapitalizationType = .none
        btnOldPasswordShow.setThemeForPSWButton("SHOW")
        btnOldPasswordShow.addTarget(self, action: #selector(btnPasswordShowClick(_:)), for: .touchUpInside)
        
        viewNewPasswordParent.backgroundColor = COLOR.clear
        lblNewPasswordTitle.setThemeForTextFiledTitle("New Password")
        viewNewPassword.backgroundColor = COLOR.background_Gray
        viewNewPassword.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtNewPassword.setThemeFor("New Password*")
        txtNewPassword.isSecureTextEntry = true
        txtNewPassword.delegate = self
        txtNewPassword.autocorrectionType = .no
        txtNewPassword.autocapitalizationType = .none
        btnNewPasswordShow.setThemeForPSWButton("SHOW")
        btnNewPasswordShow.addTarget(self, action: #selector(btnPasswordShowClick(_:)), for: .touchUpInside)

        viewConfrimPasswordParent.backgroundColor = COLOR.clear
        lblConfrimPasswordTitle.setThemeForTextFiledTitle("Confirm Password")
        viewConfrimPassword.backgroundColor = COLOR.background_Gray
        viewConfrimPassword.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtConfrimPassword.setThemeFor("Confirm Password*", returnKeyType : .continue)
        txtConfrimPassword.isSecureTextEntry = true
        txtConfrimPassword.delegate = self
        txtConfrimPassword.autocorrectionType = .no
        txtConfrimPassword.autocapitalizationType = .none
        btnConfrimPasswordShow.setThemeForPSWButton("SHOW")
        btnConfrimPasswordShow.addTarget(self, action: #selector(btnPasswordShowClick(_:)), for: .touchUpInside)

        btnSave.setThemeForAppButton("SAVE")
        btnSave.addTarget(self, action: #selector(btnSaveClick(_:)), for: .touchUpInside)
        viewButtonCircle.backgroundColor = COLOR.White
        viewButtonCircle.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: viewButtonCircle.frame.height / 2)
    }
    
    //MARK:- Button Actions
    @IBAction func btnBackClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK:- Button Actions
    @IBAction func btnPasswordShowClick(_ sender:UIButton)
    {
        if sender.titleLabel?.text == "SHOW"
        {
            if sender == btnOldPasswordShow
            {
                txtOldPassword.isSecureTextEntry = false
            }
            else if sender == btnNewPasswordShow
            {
                txtNewPassword.isSecureTextEntry = false
            }
            else if sender == btnConfrimPasswordShow
            {
                txtConfrimPassword.isSecureTextEntry = false
            }
            sender.setTitle("HIDE", for: .normal)
        }
        else{
            if sender == btnOldPasswordShow
            {
                txtOldPassword.isSecureTextEntry = true
            }
            else if sender == btnNewPasswordShow
            {
                txtNewPassword.isSecureTextEntry = true
            }
            else if sender == btnConfrimPasswordShow
            {
                txtConfrimPassword.isSecureTextEntry = true
            }
            sender.setTitle("SHOW", for: .normal)
        }
    }

    @IBAction func btnSaveClick(_ sender: Any)
    {
        var strMessage = String()
        if (txtOldPassword.text?.count)! == 0
        {
            strMessage = "Old Password Required"
        }
        else if (txtNewPassword.text?.count)! == 0
        {
            strMessage = "New Password Required"
        }
        else if (txtNewPassword.text?.count)! < 8
        {
            strMessage = "New Password Minimum to 8 Character."
        }
        else if (txtConfrimPassword.text?.count)! == 0
        {
            strMessage = "Confirm Password Required"
        }
        else if (txtNewPassword.text!) != (txtConfrimPassword.text!)
        {
            strMessage = "Confirm Password Does Not Match."
        }

        if strMessage.count > 1
        {
            showMyAlertView(message: strMessage) { (action) in }
            return
        }
        processCheckOldPassword()
    }
   
    //MARK:- API Call Funtions
    func processCheckOldPassword()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID(),"old_password":txtOldPassword.text!]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqCheckOldPassword, dictParameter: parameters as NSDictionary,isHeader: false)
        
    }
    
    func processUpdatePassword()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID(),"password":txtNewPassword.text!]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqChangePassword, dictParameter: parameters as NSDictionary,isHeader: false)
    }

}
/*
 Extension Description :- Delegate methods for the UITextFiled.
 */
extension ChangePassowrdVC : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtOldPassword
        {
            txtNewPassword.becomeFirstResponder()
        }
        else if textField == txtNewPassword
        {
            txtConfrimPassword.becomeFirstResponder()
        }
        else if textField == txtConfrimPassword
        {
            textField.resignFirstResponder()
            btnSaveClick(btnSave)
        }
        return true
    }
}
/*
 Extension Description :- Delegate methods for the add new address response
 */
extension ChangePassowrdVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqCheckOldPassword
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    processUpdatePassword()
                }
                else if statusCode == 5
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in }
                        self.setTheme()
                    }
                }
                else
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            if statusCode == aouthStatus
                            {
                                Application_Delegate.processLogout()
                            }
                        }
                    }
                }
            }
        }
        else if reqTask == reqChangePassword
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    showMyAlertView(message: "Your password updated successfully") { (action) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                else
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            if statusCode == aouthStatus
                            {
                                Application_Delegate.processLogout()
                            }
                        }
                    }
                }
            }
        }
    }
}
