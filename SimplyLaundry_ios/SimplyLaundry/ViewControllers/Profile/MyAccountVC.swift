//
//  MyAccountVC.swift
//  SimplyLaundry
//
//  Created by webclues on 03/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit
import DropDown

protocol MyAccountVCDelegate: class
{
    func updateUserProfile(dicUserInfo:NSDictionary)
}

class MyAccountVC: UIViewController {
    
    // MyAccountVCDelegate Object
    weak var delegate : MyAccountVCDelegate?
    
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
    
    @IBOutlet weak var btnEditProfile:UIButton!
    @IBOutlet weak var consBtnEditProfileTop: NSLayoutConstraint! // Constraint: set 20 to Diplay and When Hidd set -20
    
    //Ability to idintify View Outlet's
    @IBOutlet weak var viewAbilityToIdintifyParent:UIView!
    @IBOutlet weak var lblAbilityToIdintifyTitle:UILabel!
    @IBOutlet weak var viewAbilityToIdintify:UIView!
    @IBOutlet weak var txtAbilityToIdintify:UITextField!
    @IBOutlet weak var imgAbilityToIdintify:UIImageView!
    @IBOutlet weak var btnAbilityToIdintify:UIButton!
    
    //Company Name View Outlet's
    @IBOutlet weak var viewCompanyNameParent:UIView!
    @IBOutlet weak var lblCompanyNameTitle:UILabel!
    @IBOutlet weak var viewCompanyName:UIView!
    @IBOutlet weak var txtCompanyName:UITextField!
    @IBOutlet weak var consViewCompanyNameTop: NSLayoutConstraint!
    
    //First Name View Outlet's
    @IBOutlet weak var viewFirstNameParent:UIView!
    @IBOutlet weak var lblFirstNameTitle:UILabel!
    @IBOutlet weak var viewFirstName:UIView!
    @IBOutlet weak var txtFirstName:UITextField!
    @IBOutlet weak var imgFirstName:UIImageView!
    
    //Last Name View Outlet's
    @IBOutlet weak var viewLastNameParent:UIView!
    @IBOutlet weak var lblLastNameTitle:UILabel!
    @IBOutlet weak var viewLastName:UIView!
    @IBOutlet weak var txtLastName:UITextField!
    @IBOutlet weak var imgLastName:UIImageView!

    //Email Address View Outlet's
    @IBOutlet weak var viewEmailIDParent:UIView!
    @IBOutlet weak var lblEmailIDTitle:UILabel!
    @IBOutlet weak var viewEmailID:UIView!
    @IBOutlet weak var txtEmailID:UITextField!
    @IBOutlet weak var imgEmailID:UIImageView!

    //Phone Number View Outlet's
    @IBOutlet weak var viewPhoneNoParent:UIView!
    @IBOutlet weak var lblPhoneNoTitle:UILabel!
    @IBOutlet weak var viewPhoneNo:UIView!
    @IBOutlet weak var txtPhoneNo:UITextField!
    @IBOutlet weak var imgPhoneNo:UIImageView!

    //Question View Outlet's
    @IBOutlet weak var viewQuestionParent:UIView!
    @IBOutlet weak var lblQuestionTitle:UILabel!
    @IBOutlet weak var viewQuestion:UIView!
    @IBOutlet weak var txtQuestion:UITextField!
    @IBOutlet weak var imgQuestion:UIImageView!
    @IBOutlet weak var btnQuestion:UIButton!
    
    //Other Notes View Outlet's
    @IBOutlet weak var viewOtherNotesParent:UIView!
    @IBOutlet weak var lblOtherNotesTitle:UILabel!
    @IBOutlet weak var viewOtherNotes:UIView!
    @IBOutlet weak var txtOtherNotes:UITextView!
    @IBOutlet weak var consViewOtherNotesTop: NSLayoutConstraint! // Constraint: set 90 for Show and When hide set 0
    
    @IBOutlet weak var viewSpecialInstructionsParent:UIView!
    @IBOutlet weak var lblSpecialInstructionsTitle:UILabel!
    @IBOutlet weak var viewSpecialInstructions:UIView!
    @IBOutlet weak var txtSpecialInstructions:UITextView!
    
    @IBOutlet weak var consViewbtnSaceAndBtnChangePSW: NSLayoutConstraint!// Constraint: set 160 to Diplay and When Hidd set 0
    @IBOutlet weak var viewbtnSaceAndBtnChangePSW: UIView!
    @IBOutlet weak var btnChangePassword: UIButton!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var viewButtonCircle: UIView!
    
    // Variable Declarations and Initlizations
    var dicUserInfo : NSDictionary = NSDictionary()
    var screenNo : Int = 1 // Screen Number =  1: My Account Screen, 2: Edit Profile Screen
    var RagistrationsType : Int = 0 //1:"Individual", 2:"Company"
    var strTextViewPlaceholder = "Other Notes*"
    var strSpecialInstructionsPlaceholder = "Special Instructions"
    var arrQuestionList = NSArray()
    var strQuestionID = String()
    var isUpdate = false
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        processRefreshToken()
        setDataAccrodingToScreen()
        if ResponceKey_get_how_hear_about_us.arrHowAboutUs.count > 0
        {
            arrQuestionList = NSArray(array: ResponceKey_get_how_hear_about_us.arrHowAboutUs)
            processGetUserInfo()
        }
        else{
            processGetQustionList()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        setDataAccrodingToScreen()
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
        
        lblVCTitle.setVCTitle("")
        
        btnBack.setTitle("", for: .normal)
        btnBack.setImage(UIImage.init(named: "back"), for: .normal)
        btnBack.addTarget(self, action: #selector(btnBackClick(_:)), for: .touchUpInside)
        
        //Content theme
        scrollContent.setThemeForScrollView()
        viewContent.backgroundColor = COLOR.White
        viewContent.isHidden = true
        
        btnEditProfile.setTitle("Edit Profile", for: .normal)
        btnEditProfile.setTitleColor(COLOR.Blue_light, for: .normal)
        btnEditProfile.backgroundColor = COLOR.clear
        btnEditProfile.titleLabel?.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        btnEditProfile.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        btnEditProfile.addTarget(self, action: #selector(btnEditProfileClick(_:)), for: .touchUpInside)
        btnEditProfile.isHidden = true
        
        viewAbilityToIdintifyParent.backgroundColor = COLOR.clear
        lblAbilityToIdintifyTitle.setThemeForTextFiledTitle("Ability to Identify")
        viewAbilityToIdintify.backgroundColor = COLOR.background_Gray
        viewAbilityToIdintify.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtAbilityToIdintify.setThemeFor("Select Ability to Identify*")
        txtAbilityToIdintify.delegate = self
        imgAbilityToIdintify.image = UIImage.init(named: "down_arrow")
        btnAbilityToIdintify.setTitle("", for: .normal)
        btnAbilityToIdintify.addTarget(self, action: #selector(btnAbilityToIdintifyClick(_:)), for: .touchUpInside)

        viewCompanyNameParent.backgroundColor = COLOR.clear
        viewCompanyNameParent.isHidden = true
        lblCompanyNameTitle.setThemeForTextFiledTitle("Company Name")
        viewCompanyName.backgroundColor = COLOR.background_Gray
        viewCompanyName.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtCompanyName.setThemeFor("Company Name*")
        txtCompanyName.delegate = self
        consViewCompanyNameTop.constant = -(viewCompanyNameParent.bounds.height)
        
        viewFirstNameParent.backgroundColor = COLOR.clear
        lblFirstNameTitle.setThemeForTextFiledTitle("First Name")
        viewFirstName.backgroundColor = COLOR.background_Gray
        viewFirstName.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtFirstName.setThemeFor("First Name*")
        txtFirstName.delegate = self
        imgFirstName.image = UIImage.init(named: "first_name")
        
        viewLastNameParent.backgroundColor = COLOR.clear
        lblLastNameTitle.setThemeForTextFiledTitle("Last Name")
        viewLastName.backgroundColor = COLOR.background_Gray
        viewLastName.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtLastName.setThemeFor("Last Name*")
        txtLastName.delegate = self
        imgLastName.image = UIImage.init(named: "first_name")
    
        viewEmailIDParent.backgroundColor = COLOR.clear
        lblEmailIDTitle.setThemeForTextFiledTitle("Email")
        viewEmailID.backgroundColor = COLOR.background_Gray
        viewEmailID.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtEmailID.setThemeFor("Email Address*")
        txtEmailID.delegate = self
        txtEmailID.autocorrectionType = .no
        txtEmailID.autocapitalizationType = .none
        imgEmailID.image = UIImage.init(named: "email_address")

        viewPhoneNoParent.backgroundColor = COLOR.clear
        lblPhoneNoTitle.setThemeForTextFiledTitle("Phone Number")
        viewPhoneNo.backgroundColor = COLOR.background_Gray
        viewPhoneNo.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtPhoneNo.setThemeFor("Phone Number*")
        txtPhoneNo.delegate = self
        imgPhoneNo.image = UIImage.init(named: "phone")

        viewQuestionParent.backgroundColor = COLOR.clear
        lblQuestionTitle.setThemeForTextFiledTitle("Select How did you hear about us?")
        viewQuestion.backgroundColor = COLOR.background_Gray
        viewQuestion.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtQuestion.setThemeFor("How did you hear about us?")
        txtQuestion.delegate = self
        imgQuestion.image = UIImage.init(named: "down_arrow")
        btnQuestion.setTitle("", for: .normal)
        btnQuestion.addTarget(self, action: #selector(btnSelectQuestionClick(_:)), for: .touchUpInside)
        
        viewOtherNotesParent.backgroundColor = COLOR.clear
        viewOtherNotesParent.isHidden = true
        lblOtherNotesTitle.setThemeForTextFiledTitle(strTextViewPlaceholder)
        viewOtherNotes.backgroundColor = COLOR.background_Gray
        viewOtherNotes.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtOtherNotes.setThemeFor(strTextViewPlaceholder)
        txtOtherNotes.delegate = self
        consViewOtherNotesTop.constant = -(viewOtherNotes.bounds.height)

        viewSpecialInstructionsParent.backgroundColor = COLOR.clear
        viewSpecialInstructionsParent.isHidden = false
        lblSpecialInstructionsTitle.setThemeForTextFiledTitle(strSpecialInstructionsPlaceholder)
        viewSpecialInstructions.backgroundColor = COLOR.background_Gray
        viewSpecialInstructions.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtSpecialInstructions.setThemeFor(strSpecialInstructionsPlaceholder)
        txtSpecialInstructions.delegate = self
        
        btnChangePassword.setTitle("Change Password", for: .normal)
        btnChangePassword.setTitleColor(COLOR.Blue_light, for: .normal)
        btnChangePassword.backgroundColor = COLOR.clear
        btnChangePassword.titleLabel?.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        btnChangePassword.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        btnChangePassword.addTarget(self, action: #selector(btnChangePasswordClick(_:)), for: .touchUpInside)
        btnChangePassword.isHidden = true
        
        btnSave.setThemeForAppButton("SAVE")
        btnSave.addTarget(self, action: #selector(btnSaveClick(_:)), for: .touchUpInside)
        viewButtonCircle.backgroundColor = COLOR.White
        viewButtonCircle.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: viewButtonCircle.frame.height / 2)
    }

    /*
     Function Name :- setDataAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set the data for Controller initial screen values
     */
    func setDataOfViewController(dictionary : NSDictionary)
    {
        let userDefult = NSMutableDictionary(dictionary: getUserInfo())
        if let ability : String = dictionary.value(forKey: "user_type") as? String
        {
            txtAbilityToIdintify.text = ability == "Company" ? "Business" : ability
            userDefult.setValue(ability, forKey: ResponceKey_Login_User.user_type)
            if ability == "Company"
            {
                self.consViewCompanyNameTop.constant = 10
                self.viewCompanyNameParent.isHidden = false
            }
            else{
                self.consViewCompanyNameTop.constant = -(self.viewCompanyNameParent.bounds.height)
                self.viewCompanyNameParent.isHidden = true
            }
        }
        if let firstName : String = dictionary.value(forKey: "company") as? String
        {
            txtCompanyName.text = firstName
        }
        if let firstName : String = dictionary.value(forKey: "firstname") as? String
        {
            txtFirstName.text = firstName
        }
        if let lastName : String = dictionary.value(forKey: "lastname") as? String
        {
            txtLastName.text = lastName
        }
        if let emailID : String = dictionary.value(forKey: "email") as? String
        {
            txtEmailID.text = emailID
            userDefult.setValue(emailID, forKey: ResponceKey_Login_User.email)
        }
        if let phoneNumber : String = dictionary.value(forKey: "phone") as? String
        {
            if screenNo == 1{
                txtPhoneNo.text = setSecurePhoneNumber(PhoneNumber: "\(phoneNumber)")
            }
            else{
                txtPhoneNo.text = "\(phoneNumber)"
            }
            userDefult.setValue(phoneNumber, forKey: ResponceKey_Login_User.phone)
        }
        
        if let specialInstructions : String = dictionary.value(forKey: "special_instruction") as? String
        {
            if txtSpecialInstructions.text.count > 0
            {
                txtSpecialInstructions.text = specialInstructions
                txtSpecialInstructions.textColor = COLOR.textFiled
            }
            else{
                txtSpecialInstructions.text = strSpecialInstructionsPlaceholder
                txtSpecialInstructions.textColor = COLOR.placeholder
            }
        }
        
        if let questionID : String = dictionary.value(forKey: ResponceKey_get_how_hear_about_ust.how_hear_about_us_id) as? String
        {
            if questionID.count != 0
            {
                strQuestionID = questionID

                let predicateSearch = NSPredicate(format: "\(ResponceKey_get_how_hear_about_ust.how_hear_about_us_id) CONTAINS[C] '\(strQuestionID)'")
                let array = NSMutableArray(array: arrQuestionList.filtered(using: predicateSearch) as NSArray)
                if array.count > 0
                {
                    txtQuestion.text = "\((array[0] as! NSDictionary).value(forKey: ResponceKey_get_how_hear_about_ust.label)!)"
                }
                if dictionary.value(forKey: "other_notes") as? String == ""
                {
                    txtOtherNotes.text = strTextViewPlaceholder
                    txtOtherNotes.textColor = COLOR.placeholder
                }
                else{
                    txtOtherNotes.text = dictionary.value(forKey: "other_notes") as? String
                    txtOtherNotes.textColor = COLOR.textFiled
                }
                if self.strQuestionID == "9"
                {
                    self.consViewOtherNotesTop.constant = 10
                    self.viewOtherNotesParent.isHidden = false
                }
                else{
                    self.consViewOtherNotesTop.constant = -(self.viewOtherNotesParent.bounds.height)
                    self.viewOtherNotesParent.isHidden = true
                }
            }
            else{
                if screenNo == 2
                {
                    if arrQuestionList.count > 0
                    {
                        self.strQuestionID = "\((self.arrQuestionList[0] as! NSDictionary).value(forKey: ResponceKey_get_how_hear_about_ust.how_hear_about_us_id)!)"
                        txtQuestion.text = "\((arrQuestionList[0] as! NSDictionary).value(forKey: ResponceKey_get_how_hear_about_ust.label)!)"
                    }
                    else{
                        self.strQuestionID = "1"
                    }
                }
            }
        }
        
        userDefult.setValue("\(txtFirstName.text!) \(txtLastName.text!)", forKey: ResponceKey_Login_User.display_name)
        setUserInfo(Data: userDefult)
        Application_Delegate.showSpinnerView(isShow: false)
    }
    
    func setSecurePhoneNumber(PhoneNumber string:String)-> String
    {
        if string != ""
        {
            let startIndex = string.index(string.startIndex, offsetBy: 0)
            let endIndex = string.index(string.endIndex, offsetBy: -4)
            let stringIndex = startIndex..<endIndex
            return "\(string[stringIndex])XXXX"
        }
        return ""
    }
    
    /*
     Function Name :- setDataAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set the data for Controller initial screen values
     */
    func setDataAccrodingToScreen()
    {
        if screenNo == 1
        {
            lblVCTitle.text = "My Profile"
            btnBack.setImage(UIImage.init(named: "side_menu"), for: .normal)
            
            btnEditProfile.isHidden = false
            consBtnEditProfileTop.constant = 20
            consViewbtnSaceAndBtnChangePSW.constant = 0
            viewbtnSaceAndBtnChangePSW.isHidden = true
            
            btnAbilityToIdintify.isUserInteractionEnabled = false
            txtAbilityToIdintify.isUserInteractionEnabled = false
            imgAbilityToIdintify.isHidden = true
            txtCompanyName.isUserInteractionEnabled = false
            txtFirstName.isUserInteractionEnabled = false
            txtLastName.isUserInteractionEnabled = false
            txtEmailID.isUserInteractionEnabled = false
            txtPhoneNo.isUserInteractionEnabled = false
            btnQuestion.isUserInteractionEnabled = false
            imgQuestion.isHidden = true
            txtOtherNotes.isUserInteractionEnabled = false
            txtSpecialInstructions.isUserInteractionEnabled = false
            
            btnChangePassword.isHidden = true
            btnSave.isHidden = true
            processGetQustionList()
        }
        else if screenNo == 2{
            lblVCTitle.text = "Edit Profile"
            btnBack.setImage(UIImage.init(named: "back"), for: .normal)
            
            consBtnEditProfileTop.constant = -(btnEditProfile.frame.height)
            btnEditProfile.isHidden = true
            consViewbtnSaceAndBtnChangePSW.constant = 160
            viewbtnSaceAndBtnChangePSW.isHidden = false
            
            btnAbilityToIdintify.isUserInteractionEnabled = true
            imgAbilityToIdintify.isHidden = false
            txtCompanyName.isUserInteractionEnabled = true
            txtFirstName.isUserInteractionEnabled = true
            txtLastName.isUserInteractionEnabled = true
            txtEmailID.isUserInteractionEnabled = true
            txtPhoneNo.isUserInteractionEnabled = true
            btnQuestion.isUserInteractionEnabled = true
            imgQuestion.isHidden = false
            txtOtherNotes.isUserInteractionEnabled = true
            txtSpecialInstructions.isUserInteractionEnabled = true
            
            btnChangePassword.isHidden = false
            btnSave.isHidden = false
            setDataOfViewController(dictionary: dicUserInfo)
            
            // set as user login with normal user or Social user
            // if user login with social user than ti can not abel to change password
            let userInfo : NSDictionary = getUserInfo()
            if let registeredVia : String = userInfo.value(forKey: strLoginUserKeyRegisteredVia) as? String
            {
                if registeredVia != "0"
                {
                    btnChangePassword.isHidden = true
                }
            }
            viewContent.isHidden = false
        }
        
    }
    
    //MARK:- Button Actions
    @IBAction func btnBackClick(_ sender: Any)
    {
        if screenNo == 1
        {
            sideMenuController?.toggle()
        }
        else if screenNo == 2
        {
           self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnEditProfileClick(_ sender: Any)
    {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountVC") as! MyAccountVC
        controller.delegate = self
        controller.screenNo = 2
        controller.dicUserInfo = self.dicUserInfo
        controller.arrQuestionList = self.arrQuestionList
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnAbilityToIdintifyClick(_ sender: Any)
    {
        self.view.endEditing(true)
        initDropDown(dataSource: ["Individual","Business"], textFiled: txtAbilityToIdintify) { (index, value) in
            self.RagistrationsType = index + 1
            if value == "Business"
            {
                self.consViewCompanyNameTop.constant = 10
                self.viewCompanyNameParent.isHidden = false
                self.txtCompanyName.becomeFirstResponder()
            }
            else{
                self.consViewCompanyNameTop.constant = -(self.viewCompanyNameParent.bounds.height)
                self.viewCompanyNameParent.isHidden = true
                self.txtFirstName.becomeFirstResponder()
            }
        }
    }

    @IBAction func btnSelectQuestionClick(_ sender:Any)
    {
        self.view.endEditing(true)
        initDropDown(dataSource: getNSArrayToStringArray(array: arrQuestionList, forKey: ResponceKey_get_how_hear_about_ust.label), textFiled: txtQuestion) { (index, value) in
            self.strQuestionID = "\((self.arrQuestionList[index] as! NSDictionary).value(forKey: ResponceKey_get_how_hear_about_ust.how_hear_about_us_id)!)"
            if value.lowercased() == "other".lowercased()
            {
                self.consViewOtherNotesTop.constant = 10
                self.viewOtherNotesParent.isHidden = false
            }
            else{
                self.consViewOtherNotesTop.constant = -(self.viewOtherNotesParent.bounds.height)
                self.viewOtherNotesParent.isHidden = true
            }
        }
    }
    
    @IBAction func btnChangePasswordClick(_ sender: Any)
    {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ChangePassowrdVC") as! ChangePassowrdVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnSaveClick(_ sender: Any)
    {
        var strmessage = String()
        if (txtAbilityToIdintify.text?.count)! == 0
        {
            strmessage = "Ability to Identify Required."
        }
        else if (txtFirstName.text?.count)! <= 0
        {
            strmessage = "First Name is Required."
        }
        else if (txtLastName.text?.count)! <= 0
        {
            strmessage = "Last name is required."
        }
        else if (txtEmailID.text?.count)! <= 0
        {
            strmessage = "Email Address is Required."
        }
        else if emailValidation(strEmail: txtEmailID.text!) == false{
            strmessage = "Enter Valid Email Address."
        }
        else if (txtPhoneNo.text?.count)! <= 0
        {
            strmessage = "Phone Number is Required."
        }
        else if (txtPhoneNo.text?.count)! < 12
        {
            strmessage = "Phone Number Minimum to 10 Numbers."
        }

        if txtAbilityToIdintify.text == "Business"
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
        
        if strmessage.count == 0
        {
            if CheckEmailUpadet() == true
            {
                processEditedEmail()
            }
            else
            {
                processUpdateUserInfo()
            }
        }
        else
        {
             showMyAlertView(message: strmessage) { (action) in }
        }
    }
    
    //MARK:- API Call Funtions
    func processGetUserInfo()
    {
        if isUpdate == false
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetProfileDetail, dictParameter: parameters as NSDictionary,isHeader: false)
        
        isUpdate = false
    }

    func processUpdateUserInfo()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID(),
                                        "user_type":RagistrationsType == 1 ? "Individual":"Company",
                                        "company":RagistrationsType == 1 ? "":txtCompanyName.text!,
                                        "firstname":txtFirstName.text!,
                                        "lastname":txtLastName.text!,
                                        "email":txtEmailID.text!,
                                        "phone":txtPhoneNo.text!,
                                        "how_hear_about_us_id":"\(strQuestionID)",
                                        "other_notes":"\(strQuestionID == "9" ? txtOtherNotes.text! : "" )",
            "special_instruction":"\(txtSpecialInstructions.text! == strSpecialInstructionsPlaceholder ? "" : txtSpecialInstructions.text!)"]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqUpdateProfileDetail, dictParameter: parameters as NSDictionary,isHeader: false)
        
    }
    
    func processEditedEmail()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID(),"email":txtEmailID.text!]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqCheckEditEmail, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    func processGetQustionList()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = [:]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetHowHearAboutUs, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    func processRefreshToken()
    {
        let parameters : [String:Any] = ["user_id":getUserID(),"device_token": TAG_Device_Token, "device_id": DEVICE_ID, "device_type": Str_Device_Type]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqRefreshToken, dictParameter: parameters as NSDictionary,isHeader: false)
        
    }
    //check here user is change that email address or Not if user change thet email-ID then it return true or else return false
    // if user change email-ID thn call processEditedEmail() functions.
    func CheckEmailUpadet()-> Bool
    {
        if dicUserInfo.value(forKey: "email") as! String != txtEmailID.text!
        {
            return true
        }
        return false
    }
    
}
/*
 Extension Description :- Delegate methods for the UITextFiled and UITextView
 */
extension MyAccountVC : UITextFieldDelegate, UITextViewDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFirstName || textField == txtLastName
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
        if textField == txtFirstName
        {
            txtLastName.becomeFirstResponder()
        }
        else if textField == txtLastName
        {
            txtEmailID.becomeFirstResponder()
        }
        else if textField == txtEmailID
        {
            txtPhoneNo.becomeFirstResponder()
        }
        else if textField == txtPhoneNo
        {
            textField.resignFirstResponder()
            btnSaveClick(btnSave)
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
        else if textView == txtSpecialInstructions
        {
            self.txtSpecialInstructions.textColor = COLOR.textFiled
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == txtOtherNotes
        {
            if txtOtherNotes.text.count <= 0 {
                txtOtherNotes.text = strTextViewPlaceholder
                txtOtherNotes.textColor = COLOR.placeholder
            }
        }
        else if textView == txtSpecialInstructions
        {
            if txtSpecialInstructions.text.count <= 0 {
                txtSpecialInstructions.text = strSpecialInstructionsPlaceholder
                txtSpecialInstructions.textColor = COLOR.placeholder
            }
        }
        
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView == txtOtherNotes
        {
            if txtOtherNotes.text == strTextViewPlaceholder {
                txtOtherNotes.textColor = COLOR.textFiled
                txtOtherNotes.text = ""
            }
        }
        else if textView == txtSpecialInstructions
        {
            if txtSpecialInstructions.text == strSpecialInstructionsPlaceholder {
                txtSpecialInstructions.textColor = COLOR.textFiled
                txtSpecialInstructions.text = ""
            }
        }
        
        return true
    }
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension MyAccountVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        
        if reqTask == reqGetProfileDetail
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        self.dicUserInfo = NSDictionary(dictionary: resKeyData)
                        self.setDataOfViewController(dictionary: resKeyData)
                        viewContent.isHidden = false
                    }
                }
                else
                {
                    Application_Delegate.showSpinnerView(isShow: false)
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
        else if reqTask == reqUpdateProfileDetail
        {
            Application_Delegate.showSpinnerView(isShow: false)
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    let alertController = UIAlertController(title: APP_NAME, message: "Your profile updated successfully", preferredStyle: .alert)
                    let saveAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alertController.addAction(saveAction)
                    self.present(alertController, animated: true, completion: nil)
                    if delegate != nil
                    {
                        let parameters : [String:Any] = ["user_id":getUserID(),
                                                         "user_type":RagistrationsType == 1 ? "Individual":"Company",
                                                         "company":RagistrationsType == 1 ? "":txtCompanyName.text!,
                                                         "firstname":txtFirstName.text!,
                                                         "lastname":txtLastName.text!,
                                                         "email":txtEmailID.text!,
                                                         "phone":txtPhoneNo.text!,
                                                         "how_hear_about_us_id":"\(strQuestionID)",
                                                        "other_notes":"\(strQuestionID == "9" ? txtOtherNotes.text! : "" )",
                                                        "special_instruction":"\(txtSpecialInstructions.text! == strSpecialInstructionsPlaceholder ? "" : txtSpecialInstructions.text!)"]
                        delegate?.updateUserProfile(dicUserInfo: parameters as NSDictionary)
                    }
                }
                else if statusCode == 5
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        setDataOfViewController(dictionary: dicUserInfo)
                        showMyAlertView(message: message) { (action) in
                            
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
        else if reqTask == reqCheckEditEmail
        {
            Application_Delegate.showSpinnerView(isShow: false)
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    self.processUpdateUserInfo()
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
        else if reqTask == reqGetHowHearAboutUs
        {
            processGetUserInfo()
            
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let ResKeyData : NSArray = responseData.value(forKey: ResKeyData) as? NSArray
                    {
                        _ = ResponceKey_get_how_hear_about_us.init(dic: ResKeyData)
                        Application_Delegate.showSpinnerView(isShow: true)
                        arrQuestionList = ResponceKey_get_how_hear_about_us.arrHowAboutUs
                    }
                }
                else
                {
                    Application_Delegate.showSpinnerView(isShow: false)
                    if let message :String = responseData.value(forKey: ResKeyMessage) as? String
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
/*
 Extension Description :- Delegate methods for the add new address response
 */
extension MyAccountVC : MyAccountVCDelegate
{
    func updateUserProfile(dicUserInfo: NSDictionary) {
        isUpdate = true
        processGetUserInfo()
    }
    
}
