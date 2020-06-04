//
//  BuyPackagesVC.swift
//  SimplyLaundry
//
//  Created by webclues on 29/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit
import DropDown

protocol BuyPackagesVCDelegate: class
{
    func updatePackages()
}

class BuyPackagesVC: UIViewController {
    
    weak var delegate: BuyPackagesVCDelegate?
    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnBack:UIButton!

    //Content View Outlet's
    @IBOutlet weak var viewContent:UIView!

    //Packages Content View Outlet's
    @IBOutlet weak var viewPackageContent:UIView!
    
    //Title View Outlet's
    @IBOutlet weak var viewTitle:UIView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblPackagePrice:UILabel!
    
    @IBOutlet weak var lblServices:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var lblDescription:UILabel!
    
    //MARK:- Card view Outlet's
    @IBOutlet weak var viewSelectCardParent:UIView!
    @IBOutlet weak var lblSelectCardTitle:UILabel!
    @IBOutlet weak var btnAddCard:UIButton!
    @IBOutlet weak var viewSelectCard:UIView!
    @IBOutlet weak var txtSelectCard:UITextField!
    @IBOutlet weak var imgSelectCard:UIImageView!
    @IBOutlet weak var btnSelectCard:UIButton!

    //Submit button
    @IBOutlet weak var btnSubmit:UIButton!
    @IBOutlet weak var lblButtonCircle:UILabel!
    
    // Variable Declarations and Initlizations
    var dicPackagesDetails = NSDictionary()
    var arrCardList = NSMutableArray()
    var strCardProfileID : String = String()
    
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
        
        lblVCTitle.setVCTitle("Buy Package")

        btnBack.setTitle("", for: .normal)
        btnBack.setImage(UIImage.init(named: "back"), for: .normal)
        btnBack.addTarget(self, action: #selector(btnBackClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        viewContent.isHidden = true

        viewPackageContent.backgroundColor = COLOR.background_Gray
        viewPackageContent.setCornerRadius(corner:5)
        viewTitle.backgroundColor = COLOR.Green
        
        lblTitle.text = ""
        lblTitle.textColor = COLOR.White
        lblTitle.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_SIXTEEN)
        
        lblPackagePrice.text = ""
        lblPackagePrice.textColor = COLOR.White
        lblPackagePrice.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_SIXTEEN)
        
        lblServices.setThemeForTitle( isTitle: false, numberOfLines: 0)
        lblServices.textAlignment = .left
        
        lblPrice.setThemeForTitle( isTitle: false, numberOfLines: 0)
        lblPrice.textAlignment = .right
        
        lblDescription.setThemeForTitle( isTitle: false, numberOfLines: 0)
        
        //set the Select Card View Theme
        viewSelectCardParent.backgroundColor = COLOR.clear
        lblSelectCardTitle.setThemeForTextFiledTitle("Select Card")
        btnAddCard.backgroundColor = COLOR.clear
        btnAddCard.setTitle("ADD CARD", for: .normal)
        btnAddCard.setTitleColor(COLOR.Blue, for: .normal)
        btnAddCard.titleLabel?.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        btnAddCard.addTarget(self, action: #selector(btnAddCardClick(_:)), for: .touchUpInside)
        viewSelectCard.backgroundColor = COLOR.White
        viewSelectCard.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtSelectCard.setThemeFor( "Please Select Credit Card", returnKeyType : .default)
        imgSelectCard.image = UIImage.init(named: "down_arrow")
        btnSelectCard.setTitle("", for: .normal)
        btnSelectCard.addTarget(self, action: #selector(btnSelectCardClick(_:)), for: .touchUpInside)
        
        btnSubmit.setThemeForAppButton("BUY PACKAGE RECURRING")
        btnSubmit.addTarget(self, action: #selector(btnBuyPackagesClick(PackagesCell:)), for: .touchUpInside)
        
        lblButtonCircle.text = ""
        lblButtonCircle.backgroundColor = COLOR.White
        lblButtonCircle.setCornerRadius()
        
        reloadPackages(dictionary: dicPackagesDetails)
    }
    
    /*
     Function Name :- reloadPackages
     Function Parameters :- (dictionary: NSDictionary)
     Function Description :- Set a package data.
     */
    func reloadPackages(dictionary: NSDictionary)
    {
        let array = NSArray(array: dictionary.value(forKey: ResponceKey_get_packages.package_price) as! NSArray)
        let services : NSMutableString = NSMutableString()
        let price : NSMutableString = NSMutableString()
        for i in 0..<array.count
        {
            if i == 0
            {
                services.append("\((array[i] as! NSDictionary).value(forKey: ResponceKey_get_packages.package_price_value.service_name)!)")
                if "\((array[i] as! NSDictionary).value(forKey: ResponceKey_get_packages.package_price_value.price)!)".count < 1
                {
                    price.append(" ")
                }
                else{
                    price.append("\((array[i] as! NSDictionary).value(forKey: ResponceKey_get_packages.package_price_value.price)!)/lb")
                }
            }
            else{
                services.append(",\n\((array[i] as! NSDictionary).value(forKey: ResponceKey_pack_detail.package_price_value.service_name)!)")
                if "\((array[i] as! NSDictionary).value(forKey: ResponceKey_pack_detail.package_price_value.price)!)".count < 1
                {
                    price.append("-")
                }
                else{
                    if "\((array[i-1] as! NSDictionary).value(forKey: ResponceKey_pack_detail.package_price_value.price)!)".count < 1
                    {
                        price.append("\n$\((array[i] as! NSDictionary).value(forKey: ResponceKey_pack_detail.package_price_value.price)!)/lb ")
                    }
                    else{
                        price.append(",\n$\((array[i] as! NSDictionary).value(forKey: ResponceKey_pack_detail.package_price_value.price)!)/lb ")
                    }
                    
                }
            }
        }
        lblServices.text = services as String
        lblPrice.text = price as String
        lblTitle.text = "\(dictionary.value(forKey: ResponceKey_get_packages.package_name)!)"
        lblDescription.text = "\(dictionary.value(forKey: ResponceKey_get_packages.package_description)!)"
        lblPackagePrice.text = "$\(dictionary.value(forKey: ResponceKey_get_packages.package_amount)!)"
        
    }
    
    //MARK:- Button Actions
    @IBAction func btnBackClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBuyPackagesClick(PackagesCell sender: UIButton)
    {
        processBuyPackages()
    }

    @IBAction func btnSelectCardClick(_ sender: Any)
    {
        self.view.endEditing(true)
        initDropDown(dataSource: getNSArrayToStringArray(array: arrCardList, forKey: ResponceKey_get_all_credit_card.dataValues.payment_card_no), textFiled: txtSelectCard) { (index, value) in
            self.strCardProfileID = "\((self.arrCardList[index] as! NSDictionary).value(forKey: ResponceKey_get_all_credit_card.dataValues.payment_profile_id)!)"
        }
    }

    @IBAction func btnAddCardClick(_ sender: UIButton)
    {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardVC
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }

    //MARK:- API Call Funtions
    func processGetAllCreditCard()
    {
        if Application_Delegate.navigationController.topViewController is BuyPackagesVC
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetAllCreditCard, dictParameter: parameters as NSDictionary)
    }

    func processBuyPackages()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID(),
                                         "id":dicPackagesDetails.value(forKey: ResponceKey_get_packages.id)!,
                                         "email":getUserInfo().value(forKey: ResponceKey_Login_User.email)!,
                                         "card_number":strCardProfileID]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqBuyPackage, dictParameter: parameters as NSDictionary)
    }
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension BuyPackagesVC : webServiceDataProviderDelegate
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
                        arrCardList = NSMutableArray(array: resKeyData)
                        let predicateSearch = NSPredicate(format: "\(ResponceKey_get_all_credit_card.dataValues.is_default) CONTAINS[C] '1'")
                        let array = NSMutableArray(array: resKeyData.filtered(using: predicateSearch) as NSArray)
                        if array.count > 0
                        {
                            txtSelectCard.text = "\((array[0] as! NSDictionary).value(forKey: ResponceKey_get_all_credit_card.dataValues.payment_card_no)!)"
                            strCardProfileID = "\((array[0] as! NSDictionary).value(forKey: ResponceKey_get_all_credit_card.dataValues.payment_profile_id)!)"
                        }
                        viewContent.isHidden = false
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
        if reqTask == reqBuyPackage
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if delegate != nil{
                        delegate?.updatePackages()
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
                    }
                }
            }
        }
    }
}
/*
 Extension Description :- Delegate methods for update add card data.
 */
extension BuyPackagesVC : AddCardVCDelegate
{
    @objc func updateCard() {
        processGetAllCreditCard()
    }
}
