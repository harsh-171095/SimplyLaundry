//
//  GiftCardVC.swift
//  SimplyLaundry
//
//  Created by webclues on 26/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit
import DropDown

class GiftCardVC: UIViewController {

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

    //Referral Name View Outlet's
    @IBOutlet weak var viewReferralNameParent:UIView!
    @IBOutlet weak var lblReferralNameTitle:UILabel!
    @IBOutlet weak var viewReferralName:UIView!
    @IBOutlet weak var txtReferralName:UITextField!
    @IBOutlet weak var imgReferralName:UIImageView!

    //Referee Name View Outlet's
    @IBOutlet weak var viewRefereeNameParent:UIView!
    @IBOutlet weak var lblRefereeNameTitle:UILabel!
    @IBOutlet weak var viewRefereeName:UIView!
    @IBOutlet weak var txtRefereeName:UITextField!
    @IBOutlet weak var imgRefereeName:UIImageView!

    //Referee Email Address View Outlet's
    @IBOutlet weak var viewRefereeEmailIDParent:UIView!
    @IBOutlet weak var lblRefereeEmailIDTitle:UILabel!
    @IBOutlet weak var viewRefereeEmailID:UIView!
    @IBOutlet weak var txtRefereeEmailID:UITextField!
    @IBOutlet weak var imgRefereeEmailID:UIImageView!

    //Add Note View Outlet's
    @IBOutlet weak var viewAddNoteParent:UIView!
    @IBOutlet weak var lblAddNoteTitle:UILabel!
    @IBOutlet weak var viewAddNote:UIView!
    @IBOutlet weak var txtAddNote:UITextView!

    //Amount of Gift Card View Outlet's
    @IBOutlet weak var viewGiftCardAmountParent:UIView!
    @IBOutlet weak var lblGiftCardAmountTitle:UILabel!
    @IBOutlet weak var tableViewObj:UITableView!
    @IBOutlet weak var consTableViewObjHeight: NSLayoutConstraint!

    //MARK:- Card view Outlet's
    @IBOutlet weak var viewSelectCardParent:UIView!
    @IBOutlet weak var lblSelectCardTitle:UILabel!
    @IBOutlet weak var btnAddCard:UIButton!
    @IBOutlet weak var viewSelectCard:UIView!
    @IBOutlet weak var txtSelectCard:UITextField!
    @IBOutlet weak var imgSelectCard:UIImageView!
    @IBOutlet weak var btnSelectCard:UIButton!

    //MARK:- Check Uncheck New Card Outlet's
    @IBOutlet weak var btnTermsCheckUnCheck:UIButton!
    @IBOutlet weak var btnSelectTerms:UIButton!

    //Submit button
    @IBOutlet weak var btnSubmit:UIButton!
    @IBOutlet weak var lblButtonCircle:UILabel!


    // Variable Declarations and Initlizations
    var strEnquiryPlacehoder = "Add Note"
    var arrCardList : NSArray = NSArray()
    var arrGiftCradAmountListing : NSArray = NSArray()
    var intGictCardIndex = Int()
    var strCardProfileID = String()

    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        processGetAllCreditCard()
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

        lblVCTitle.setVCTitle("Gift Cards")

        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)

        //Content theme
        scrollContent.setThemeForScrollView()
        viewContent.backgroundColor = COLOR.White

        //Set Theme For Referral Name Parent View And It's Outlet's
        viewReferralNameParent.backgroundColor = COLOR.clear
        lblReferralNameTitle.setThemeForTextFiledTitle("Referral Name")
        lblReferralNameTitle.isHidden = true
        viewReferralName.backgroundColor = COLOR.background_Gray
        viewReferralName.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtReferralName.setThemeFor("Referral Name*")
        txtReferralName.delegate = self
        imgReferralName.image = UIImage.init(named: "first_name")

        //Set Theme For Referee Name Parent And It's Outlet's
        viewRefereeNameParent.backgroundColor = COLOR.clear
        lblRefereeNameTitle.setThemeForTextFiledTitle("Referee Name")
        lblRefereeNameTitle.isHidden = true
        viewRefereeName.backgroundColor = COLOR.background_Gray
        viewRefereeName.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtRefereeName.setThemeFor("Referee Name*")
        txtRefereeName.delegate = self
        imgRefereeName.image = UIImage.init(named: "first_name")

        //Set Theme For Referee Email Address Parent And It's Outlet's
        viewRefereeEmailIDParent.backgroundColor = COLOR.clear
        lblRefereeEmailIDTitle.setThemeForTextFiledTitle("Referee Email Address")
        lblRefereeEmailIDTitle.isHidden = true
        viewRefereeEmailID.backgroundColor = COLOR.background_Gray
        viewRefereeEmailID.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtRefereeEmailID.setThemeFor("Referee Email Address*", keyboardType : .emailAddress)
        txtRefereeEmailID.delegate = self
        imgRefereeEmailID.image = UIImage.init(named: "email_address")

        //Set Theme For Service View And It's Outlet's
        viewAddNoteParent.backgroundColor = COLOR.clear
        lblAddNoteTitle.setThemeForTextFiledTitle("Add Note")
        lblAddNoteTitle.isHidden = true
        viewAddNote.backgroundColor = COLOR.background_Gray
        viewAddNote.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtAddNote.setThemeFor(strEnquiryPlacehoder)
        txtAddNote.delegate = self

        //Set Theme For Service View And It's Outlet's
        viewGiftCardAmountParent.backgroundColor = COLOR.clear

        lblGiftCardAmountTitle.setThemeForTextFiledTitle("Amount of Gift card*")
        tableViewObj.register(UINib(nibName: "ExtraServiceCell", bundle: nil), forCellReuseIdentifier: "ExtraServiceCell")
        tableViewObj.separatorStyle = .none
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.backgroundColor = COLOR.White
        tableViewObj.isScrollEnabled = false

        //set the Select Card View Theme
        viewSelectCardParent.backgroundColor = COLOR.clear
        lblSelectCardTitle.setThemeForTextFiledTitle("Select Card")
        btnAddCard.backgroundColor = COLOR.clear
        btnAddCard.setTitle("ADD CARD", for: .normal)
        btnAddCard.setTitleColor(COLOR.Blue, for: .normal)
        btnAddCard.titleLabel?.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        btnAddCard.addTarget(self, action: #selector(btnAddCardClick(_:)), for: .touchUpInside)
        viewSelectCard.backgroundColor = COLOR.background_Gray
        viewSelectCard.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtSelectCard.setThemeFor("Please Select Credit Card*")
        imgSelectCard.image = UIImage.init(named: "down_arrow")
        btnSelectCard.setTitle("", for: .normal)
        btnSelectCard.addTarget(self, action: #selector(btnSelectCardClick(_:)), for: .touchUpInside)

        // set the new Card check and Uncheck Theme
        btnTermsCheckUnCheck.setTitle("", for: .normal)
        btnTermsCheckUnCheck.setImage(UIImage.init(named: "checkbox"), for: .normal)
        btnTermsCheckUnCheck.addTarget(self, action: #selector(btnCheckUnCheckClick(_:)), for: .touchUpInside)
        btnTermsCheckUnCheck.titleLabel?.numberOfLines = 0
        btnTermsCheckUnCheck.titleLabel?.lineBreakMode = .byWordWrapping
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE
        {
            btnTermsCheckUnCheck.imageEdgeInsets = UIEdgeInsets(top: -15, left:0, bottom: 0, right: 0)
        }
        
        btnSelectTerms.backgroundColor = COLOR.clear
        btnSelectTerms.setTitle("Terms and Conditions", for: .normal)
        btnSelectTerms.setTitleColor(COLOR.clear, for: .normal)
        btnSelectTerms.addTarget(self, action: #selector(btnSelectTermsClick(_:)), for: .touchUpInside)

        btnSubmit.setThemeForAppButton("BUY GIFT CARD")
        btnSubmit.addTarget(self, action: #selector(btnSubmitClick(_:)), for: .touchUpInside)
        lblButtonCircle.text = ""
        lblButtonCircle.backgroundColor = COLOR.White
        lblButtonCircle.setCornerRadius()

        setDataOfViewController()

    }

    func setDataOfViewController()
    {
        let attributedSuccessMessage = NSMutableAttributedString(string: "  Accept our " , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
        let attributedSuccessMessage1 = NSMutableAttributedString(string: "Terms and Conditions" , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FIFTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Blue_light])
        let attributedSuccessMessage2 = NSMutableAttributedString(string: " for the gift card." , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
        attributedSuccessMessage.append(attributedSuccessMessage1)
        attributedSuccessMessage.append(attributedSuccessMessage2)

        btnTermsCheckUnCheck.setAttributedTitle(attributedSuccessMessage, for: .normal)
        arrGiftCradAmountListing = [["title":"50.00"], ["title":"100.00"], ["title":"200.00"], ["title":"300.00"], ["title":"400.00"], ["title":"500.00"]]
        intGictCardIndex = 0
        tableViewObj.reloadData()
        callMethodAfterDelay(funcName: #selector(setTableViewHeight))
        
        if let userName : String = getUserInfo().value(forKey: ResponceKey_Login_User.display_name) as? String
        {
            txtReferralName.text = userName
        }
    }

    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }
    
    @IBAction func btnSubmitClick(_ sender:Any)
    {
        var strMessge = String()
        if (txtReferralName.text?.count)! == 0
        {
            strMessge = "Referral name required."
        }
        else if (txtRefereeName.text?.count)! == 0
        {
            strMessge = "Referee name required."
        }
        else if (txtRefereeEmailID.text?.count)! == 0
        {
            strMessge = "Referee email address required."
        }
        else if emailValidation(strEmail: txtRefereeEmailID.text!) == false
        {
            strMessge = "Enter valid Email Address."
        }
        else if (txtSelectCard.text?.count)! == 0
        {
            strMessge = "Please select card."
        }
        else if self.btnTermsCheckUnCheck.imageView!.image != UIImage.init(named: "checkbox_done")
        {
            strMessge = "Please check Terms and Conditions."
        }
        
        if strMessge.count > 1
        {
            showMyAlertView(message: strMessge) { (action) in }
            return
        }
        processBuyCreditCard()
    }
    
    @IBAction func btnSelectCardClick(_ sender: Any)
    {
        self.view.endEditing(true)
        initDropDown(dataSource: getNSArrayToStringArray(array: arrCardList, forKey: ResponceKey_get_all_credit_card.dataValues.payment_card_no), textFiled: txtSelectCard) { (index, value) in
            self.strCardProfileID = "\((self.arrCardList[index] as! NSDictionary).value(forKey: ResponceKey_get_all_credit_card.dataValues.payment_profile_id)!)"
        }
    }

    @IBAction func btnSelectTermsClick(_ sender: Any)
    {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
        controller.intScreenNo = 3
        controller.isSidemanu = false
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnCheckUnCheckClick(_ sender: UIButton)
    {
        if sender.imageView!.image == UIImage.init(named: "checkbox")
        {
            sender.setImage(UIImage.init(named: "checkbox_done"), for: .normal)
        }
        else{
            sender.setImage(UIImage.init(named: "checkbox"), for: .normal)
        }
    }

    @IBAction func btnAddCardClick(_ sender: UIButton)
    {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardVC
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
        
    @objc func setTableViewHeight()
    {
        consTableViewObjHeight.constant = CGFloat(29 * arrGiftCradAmountListing.count)
        Application_Delegate.showSpinnerView(isShow: false)
    }

    //MARK:- API Call Funtions
    func processGetAllCreditCard()
    {
        if Application_Delegate.navigationController.topViewController is GiftCardVC
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetAllCreditCard, dictParameter: parameters as NSDictionary)
    }
    
    func processBuyCreditCard()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID(),
                                         "name":txtReferralName.text!,
                                         "ref_name":txtRefereeName.text!,
                                         "email":txtRefereeEmailID.text!,
                                         "add_note":txtAddNote.text! == strEnquiryPlacehoder ? "" : txtAddNote.text!,
                                         "amount":(arrGiftCradAmountListing[intGictCardIndex] as! NSDictionary).value(forKey: "title")!,
                                         "card_number":strCardProfileID]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqBuyGiftCard, dictParameter: parameters as NSDictionary)
    }
    
}
/*
 Extension Description :- Delegate methods for the UITextFiled and UITextView
 */
extension GiftCardVC : UITextFieldDelegate, UITextViewDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtReferralName{
            txtReferralName.becomeFirstResponder()
        }
        else if textField == txtReferralName{
            txtReferralName.becomeFirstResponder()
        }
        else if textField == txtReferralName{
            txtAddNote.becomeFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtReferralName || textField == txtRefereeName
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

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == txtAddNote
        {
            self.txtAddNote.textColor = COLOR.textFiled
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtAddNote.text.count > 0 {
        } else {
            txtAddNote.text = strEnquiryPlacehoder
            txtAddNote.textColor = COLOR.placeholder
        }
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == strEnquiryPlacehoder {
            txtAddNote.textColor = COLOR.textFiled
            txtAddNote.text = ""
        }
        return true
    }

}
/*
 Extension Description :- Delegate method for table view.
 */
extension GiftCardVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGiftCradAmountListing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "ExtraServiceCell") as! ExtraServiceCell
        cell.selectionStyle = .none
        if intGictCardIndex == indexPath.row{
            cell.reloadGiftCardAmountData(dictionary: arrGiftCradAmountListing[indexPath.row] as! NSDictionary,isDefault: true)
        }
        else{
            cell.reloadGiftCardAmountData(dictionary: arrGiftCradAmountListing[indexPath.row] as! NSDictionary)
        }
        cell.btnCheckUnCkeck.tag = indexPath.row
        cell.btnCheckUnCkeck.addTarget(self, action: #selector(btnChechUncheckRadioClick(ExtraServiceCell:)), for: .touchUpInside)
        return cell
    }
    
    @IBAction func btnChechUncheckRadioClick(ExtraServiceCell sender:UIButton)
    {
        intGictCardIndex = sender.tag
        tableViewObj.reloadData()
    }
}

extension GiftCardVC : AddCardVCDelegate
{
    @objc func updateCard() {
        processGetAllCreditCard()
    }
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension GiftCardVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqGetAllCreditCard
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSArray = responseData.value(forKey: ResKeyData) as? NSArray
                    {
                        viewContent.isHidden = false
                        arrCardList = NSArray(array: resKeyData)
                        if arrCardList.count > 0
                        {
                            let predicateSearch = NSPredicate(format: "\(ResponceKey_get_all_credit_card.dataValues.is_default) CONTAINS[C] '1'")
                            let array = NSMutableArray(array: resKeyData.filtered(using: predicateSearch) as NSArray)
                            if array.count > 0
                            {
                                txtSelectCard.text = "\((array[0] as! NSDictionary).value(forKey: ResponceKey_get_all_credit_card.dataValues.payment_card_no)!)"
                                strCardProfileID = "\((array[0] as! NSDictionary).value(forKey: ResponceKey_get_all_credit_card.dataValues.payment_profile_id)!)"
                            }
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
        else if reqTask == reqBuyGiftCard
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                           // self.goBackToViewController(ViewController: CleanMyClothesFirstVC.self)
                            let controller = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "OrderHistoryVC") as! OrderHistoryVC
                            Application_Delegate.navigationController.pushViewController(controller, animated: false)
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
