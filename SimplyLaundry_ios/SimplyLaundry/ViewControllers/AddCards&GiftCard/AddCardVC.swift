//
//  AddCardVC.swift
//  SimplyLaundry
//
//  Created by webclues on 16/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

protocol AddCardVCDelegate: class
{
    func updateCard()
}

class AddCardVC: UIViewController {

    weak var delegate:AddCardVCDelegate?
    
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
    
    //MARK:- Add new card Outlet's
    @IBOutlet weak var viewAddNewCard:UIView!
    
    // Credit Card Number
    @IBOutlet weak var viewCreditCardNo:UIView!
    @IBOutlet weak var txtCreditCardNo:UITextField!
    @IBOutlet weak var imgCreditCardNo:UIImageView!
    
    // Card Expiration Date
    @IBOutlet weak var viewExpiDate:UIView!
    @IBOutlet weak var txtExpiDate:UITextField!
    
    // Card CVV Number
    @IBOutlet weak var viewCVVNo:UIView!
    @IBOutlet weak var txtCVVNo:UITextField!
    
    // Card Holder Name
    @IBOutlet weak var viewCardHolderName:UIView!
    @IBOutlet weak var txtCardHolderName:UITextField!
    @IBOutlet weak var imgCardHolderName:UIImageView!

    //Card Account Type
    @IBOutlet weak var viewAccountType:UIView!
    @IBOutlet weak var lblAccountTypeTitle:UILabel!
    @IBOutlet weak var btnIndividual:UIButton!
    @IBOutlet weak var btnBusiness:UIButton!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblButtonCircle: UILabel!
    
    // Variable Declarations and Initlizations
    var screenNo : Int = 1 // 1: Add Card Screen , 3: Edit Card Screen
    let ExpDatePickerView = UIPickerView()
    
    var arrExpMonthPicker : NSArray = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    var arrExpYearPicker : NSArray = NSArray()
    var dicCardDetails : NSDictionary = NSDictionary()
    var intExpYearIndex = Int()
    var intExpMonthIndex = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        setThemeAccrodingToScreen()
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
        viewContent.backgroundColor = COLOR.White
        scrollContent.backgroundColor = COLOR.White
        
        // set the add New card View Theme
        viewAddNewCard.backgroundColor = COLOR.clear
        
        //set the Credit Card Number Theme
        viewCreditCardNo.backgroundColor = COLOR.background_Gray
        viewCreditCardNo.setCornerRadius(corner: 5)
        txtCreditCardNo.setThemeFor("Credit Card Number*", keyboardType : .numberPad)
        txtCreditCardNo.delegate = self
        imgCreditCardNo.image = UIImage.init(named: "credit_card")
        
        //set the Credit Card expiretion Date Theme
        viewExpiDate.backgroundColor = COLOR.background_Gray
        viewExpiDate.setCornerRadius(corner: 5)
        txtExpiDate.setThemeFor("Expriation Date*", keyboardType : .numberPad)
        txtExpiDate.delegate = self
        
        //set the Credit Card CVV Number Theme
        viewCVVNo.backgroundColor = COLOR.background_Gray
        viewCVVNo.setCornerRadius(corner: 5)
        txtCVVNo.setThemeFor("CVV*", keyboardType : .numberPad)
        txtCVVNo.delegate = self
        
        //set the Credit Card Holder Name Theme
        viewCardHolderName.backgroundColor = COLOR.background_Gray
        viewCardHolderName.setCornerRadius(corner: 5)
        viewCardHolderName.isHidden = true
        txtCardHolderName.setThemeFor("Card Holder Name", returnKeyType : .done)
        txtCardHolderName.delegate = self
        imgCardHolderName.image = UIImage.init(named: "first_name")
        
        //set the Card type View Theme
        viewAccountType.backgroundColor = COLOR.clear
        
        lblAccountTypeTitle.setThemeForTitle("Account Type", isTitle : false)
        
        btnIndividual.setThemeForRadioBtton("Individual")
        btnIndividual.addTarget(self, action: #selector(btnRadioChekUncheckClick(_:)), for: .touchUpInside)
        
        btnBusiness.setThemeForRadioBtton("Business", isSelected: false)
        btnBusiness.addTarget(self, action: #selector(btnRadioChekUncheckClick(_:)), for: .touchUpInside)

        //set the LET'S DO SOME LAUNDRY Theme
        btnSave.setThemeForAppButton("SAVE")
        btnSave.addTarget(self, action: #selector(btnSaveClick(_:)), for: .touchUpInside)
        lblButtonCircle.text = ""
        lblButtonCircle.backgroundColor = COLOR.White
        lblButtonCircle.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: lblButtonCircle.frame.height / 2)
        
        setDataOfViewController()
    }
    
    /*
     Function Name :- setThemeAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set a theme for Controller initial screen values
     */
    func setThemeAccrodingToScreen()
    {
        if screenNo == 1 // Add Card Screen
        {
            btnBack.isHidden = false
            lblVCTitle.text = "Add Card"
        }
        else if screenNo == 2 // Edit Card Screen
        {
            btnBack.isHidden = false
            lblVCTitle.text = "Edit Card"
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
        if let responce = dicCardDetails.value(forKey: "card_number") as? String
        {
            txtCreditCardNo.text = responce
        }
        if let responce = dicCardDetails.value(forKey: "valid_date") as? String
        {
            txtExpiDate.text = responce
        }
        if let responce = dicCardDetails.value(forKey: "cvv_No") as? String
        {
            txtCVVNo.text = responce
        }
    }
    
    /*
     Function Name :- setDataOfViewController
     Function Parameters :- (nil)
     Function Description :- set a card Exprition years.
     */
    func setDataOfViewController()
    {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        print(year)
        var strYear = ""
        var intYear = Int(year)
        
        for i in 1...50
        {
            if i == 1
            {
                strYear = "\(intYear)"
            }
            else
            {
                intYear = intYear + 1
                strYear = "\(strYear),\(intYear)"
            }
        }
        arrExpYearPicker = strYear.components(separatedBy: ",") as NSArray
        
        ExpDatePickerView.tag = 5
        self.setTimePicker(pickerView: ExpDatePickerView, textFiled: txtExpiDate, pickerDoneAction: #selector(btnDoneClick(pickerView:)), pickerCancelAction: #selector(btnCancelClick(pickerView:)))
    }
    
    //MARK:- Button Actions
    @IBAction func btnBackClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveClick(_ sender: Any)
    {
        var strMessge = String()
        if (txtCreditCardNo.text?.count)! == 0
        {
            strMessge = "Credit card number required."
        }
        else if txtCreditCardNo.text!.count < 18
        {
            strMessge = "15 digits credit cards are no longer used and it will be treated as an invalid card number"
        }
        else if (txtExpiDate.text?.count)! == 0
        {
            strMessge = "Expiration date required."
        }
        else if (txtCVVNo.text?.count)! == 0
        {
            strMessge = "CVV number required."
        }
        else if (txtCVVNo.text?.count)! < 3
        {
            strMessge = "Insert minimum CVV 3 digits."
        }
        
        if strMessge.count > 1
        {
            showMyAlertView(message: strMessge) { (action) in }
            return
        }
        processAddCreditCard()
    }
    
    @IBAction func btnRadioChekUncheckClick(_ sender : UIButton)
    {
        if sender == btnIndividual
        {
            btnIndividual.setImage(UIImage.init(named: "radio_button_selected"), for: .normal)
            btnBusiness.setImage(UIImage.init(named: "radio_button"), for: .normal)
        }
        else{
            btnIndividual.setImage(UIImage.init(named: "radio_button"), for: .normal)
            btnBusiness.setImage(UIImage.init(named: "radio_button_selected"), for: .normal)
        }
    }

    // MARK:- Picker View Ojective Functions
    @objc func btnDoneClick(pickerView sender:UIBarButtonItem)
    {
        self.view.endEditing(true)
        txtExpiDate.text = "\(arrExpMonthPicker[intExpMonthIndex])-\(arrExpYearPicker[intExpYearIndex])"
        txtCVVNo.resignFirstResponder()
    }
    
    @objc func btnCancelClick(pickerView sender:Any)
    {
        self.view.endEditing(true)
    }

    /*
     Function Name :- getIDFrom
     Function Parameters :- (key : String)
     Function Description :- get a ID from given key value.
     */
    func getIDFrom(key string: String)-> String
    {
        if string == RequestParameters_add_credit_card.card_customer_type
        {
            if btnIndividual.imageView?.image == UIImage.init(named: "radio_button_selected")
            {
                return RequestParameters_add_credit_card.card_customer_type_values.individual
            }
            else{
                return RequestParameters_add_credit_card.card_customer_type_values.business
            }
        }
        return String()
    }
    
    //MARK:- API Call Funtions
    func processAddCreditCard()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let cardNumber = txtCreditCardNo.text?.split(separator: " ")
        let month = txtExpiDate.text?.split(separator: "-")
        var strCardDetails = String()
        if (cardNumber?.count)! > 0
        {
            strCardDetails = "\(cardNumber![0])," + txtCVVNo.text! + ",\(cardNumber![1])," + "\(month![0])," + "\(cardNumber![2])," + "\(month![1])," + "\(cardNumber![3])"
            
            let data = (strCardDetails).data(using: String.Encoding.utf8)
            let base64 = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            print(base64)
            strCardDetails = base64
        }
        let parameters : [String:Any] = ["user_id":getUserID(),
                                         RequestParameters_add_credit_card.card_number: strCardDetails,
                                         RequestParameters_add_credit_card.card_customer_type: getIDFrom(key: RequestParameters_add_credit_card.card_customer_type)]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqAddCreditCard, dictParameter: parameters as NSDictionary)
    }

    //MARK:- API Call Funtions
    func processEdiCreditCard()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let card_number = getCardNumber(cardNumber: txtCreditCardNo.text!)
        let parameters : [String:Any] = ["user_id":getUserID(),
                                         RequestParameters_add_credit_card.card_number: card_number,
                                         RequestParameters_add_credit_card.card_expiry: txtExpiDate.text!,
                                         RequestParameters_add_credit_card.card_customer_type: getIDFrom(key: RequestParameters_add_credit_card.card_customer_type)]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqAddCreditCard, dictParameter: parameters as NSDictionary)
    }

    
}
/*
 Extension Description :- Delegate methods for the UITextFiled.
 */
extension AddCardVC : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == txtCreditCardNo
        {
            if string != ""
            {
                let maxLength = 19
                let currentString: NSString = textField.text! as NSString
                let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                if newString.length == 5
                {
                    txtCreditCardNo.text?.append(" ")
                }
                else if newString.length == 10
                {
                    txtCreditCardNo.text?.append(" ")
                }
                else if newString.length == 15
                {
                    txtCreditCardNo.text?.append(" ")
                }
                
                if newString.length > maxLength
                {
                    self.view.endEditing(true)
                }
                return newString.length <= maxLength
            }
        }
        else if textField == txtCVVNo
        {
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length > maxLength
            {
                self.view.endEditing(true)
            }
            return newString.length <= maxLength
        }
        else if textField == txtCardHolderName
        {
            let maxLength = 35
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length > maxLength
            {
                self.view.endEditing(true)
            }
            return newString.length <= maxLength
        }
        
        return true
    }
}
/*
 Extension Description :- Delegate method for picker view.
 */
extension AddCardVC : UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0
        {
            return arrExpMonthPicker.count
        }
        else
        {
            return arrExpYearPicker.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0
        {
            return (arrExpMonthPicker[row] as! String)
        }
        else{
            return (arrExpYearPicker[row] as! String)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0
        {
            intExpMonthIndex = row
        }
        else
        {
            intExpYearIndex = row
        }
    }
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension AddCardVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqAddCreditCard
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if delegate != nil
                    {
                        delegate?.updateCard()
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
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            if statusCode == aouthStatus
                            {
                                Application_Delegate.processLogout()
                            }
                        }
                        Application_Delegate.showSpinnerView(isShow: false)
                    }
                }
            }
        }
    }
}
