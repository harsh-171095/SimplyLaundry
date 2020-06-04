//
//  ContactUsVC.swift
//  SimplyLaundry
//
//  Created by webclues on 10/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class ContactUsVC: UIViewController {

    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnManu:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var scrollContent:UIScrollView!
    @IBOutlet weak var viewContent:UIView!

    //First Name View Outlet's
    @IBOutlet weak var viewNameParent:UIView!
    @IBOutlet weak var lblNameTitle:UILabel!
    @IBOutlet weak var viewName:UIView!
    @IBOutlet weak var txtName:UITextField!
    @IBOutlet weak var imgName:UIImageView!
    
    //Last Name View Outlet's
    @IBOutlet weak var viewEmailIDParent:UIView!
    @IBOutlet weak var lblEmailIDTitle:UILabel!
    @IBOutlet weak var viewEmailID:UIView!
    @IBOutlet weak var txtEmailID:UITextField!
    @IBOutlet weak var imgEmailID:UIImageView!

    //First Name View Outlet's
    @IBOutlet weak var viewEnquiryParent:UIView!
    @IBOutlet weak var lblEnquiryTitle:UILabel!
    @IBOutlet weak var viewEnquiry:UIView!
    @IBOutlet weak var txtEnquiry:UITextView!
    
    //Submit button
    @IBOutlet weak var btnSubmit:UIButton!
    @IBOutlet weak var lblButtonCircle:UILabel!

    
    // Variable Declarations and Initlizations
    var strReferCode : String = "H854"
    var strEnquiryPlacehoder = "Type here...."
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        setContactUSData()
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
        
        lblVCTitle.setVCTitle("Contact Us")

        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        scrollContent.setThemeForScrollView()
        viewContent.backgroundColor = COLOR.White
        
        viewNameParent.backgroundColor = COLOR.clear
        lblNameTitle.setThemeForTextFiledTitle("Your Name")
        viewName.backgroundColor = COLOR.background_Gray
        viewName.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtName.setThemeFor("Name*")
        txtName.delegate = self
        imgName.image = UIImage.init(named: "first_name")
                
        viewEmailIDParent.backgroundColor = COLOR.clear
        lblEmailIDTitle.setThemeForTextFiledTitle("Your Email")
        viewEmailID.backgroundColor = COLOR.background_Gray
        viewEmailID.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtEmailID.setThemeFor("Email Address*", keyboardType : .emailAddress)
        txtEmailID.delegate = self
        imgEmailID.image = UIImage.init(named: "email_address")

        viewEnquiryParent.backgroundColor = COLOR.clear
        lblEnquiryTitle.setThemeForTextFiledTitle("Enquiry")
        viewEnquiry.backgroundColor = COLOR.background_Gray
        viewEnquiry.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtEnquiry.setThemeFor(strEnquiryPlacehoder, returnKeyType : .default)
        txtEnquiry.delegate = self
        
        btnSubmit.setThemeForAppButton("SUBMIT")
        btnSubmit.addTarget(self, action: #selector(btnSubmitClick(_:)), for: .touchUpInside)
        
        lblButtonCircle.text = ""
        lblButtonCircle.backgroundColor = COLOR.White
        lblButtonCircle.setCornerRadius()
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }

    @IBAction func btnSubmitClick(_ sender: Any)
    {
        var strMessge = String()
        if (txtName.text?.count)! == 0
        {
            strMessge = "Name is required."
        }
        else if (txtEmailID.text?.count)! == 0
        {
            strMessge = "Email Address is required."
        }
        else if emailValidation(strEmail: txtEmailID.text!) == false
        {
            strMessge = "Enter valid email address."
        }
        else if txtEnquiry.text! == strEnquiryPlacehoder
        {
            strMessge = "Enquiry is required."
        }
        
        if strMessge.count > 1{
            showMyAlertView(message: strMessge) { (action) in }
            return
        }
        
        processContactUser()
    }
    
    //MARK:- Supporting functions
    /*
     Function Name :- setContactUSData
     Function Parameters :- (nil)
     Function Description :- set a login user name and email address
     */
    func setContactUSData()
    {
        let dic = getUserInfo()
        if let userName : String = dic.value(forKey: strLoginUserKeyDisplayName) as? String
        {
            txtName.text = userName
        }
        
        if let emailId : String = dic.value(forKey: "email") as? String
        {
            txtEmailID.text = emailId
        }
    }
    
    //MARK:- API Call Funtions
    func processContactUser()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["email":txtEmailID.text!,
                                         "name":txtName.text!,
                                         "enquiry":txtEnquiry.text! == strEnquiryPlacehoder ? " " : txtEnquiry.text!]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqContactUs, dictParameter: parameters as NSDictionary,isHeader: false)
        
    }

}
/*
 Extension Description :- Delegate methods for the UITextFiled and UITextView
 */
extension ContactUsVC : UITextFieldDelegate, UITextViewDelegate
{
    //TextFiled Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtName
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
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    //TextView Delegate Mathods
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == txtEnquiry
        {
            self.txtEnquiry.textColor = COLOR.textFiled
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtEnquiry.text.count > 0 {
        } else {
            txtEnquiry.text = strEnquiryPlacehoder
            txtEnquiry.textColor = COLOR.placeholder
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == strEnquiryPlacehoder {
            txtEnquiry.textColor = COLOR.textFiled
            txtEnquiry.text = ""
        }
        return true
    }

}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension ContactUsVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        
        if reqTask == reqContactUs
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            self.goBackToViewController(ViewController: CleanMyClothesFirstVC.self)
                        }
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
