//
//  MyCreditVC.swift
//  SimplyLaundry
//
//  Created by webclues on 26/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class MyCreditVC: UIViewController {
    
    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    @IBOutlet weak var lblNotData:UILabel!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnManu:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var scrollContent:UIScrollView!
    @IBOutlet weak var viewContent:UIView!
    
    @IBOutlet weak var viewSelectLaundry:UIView!
    @IBOutlet weak var btnRedeemGiftCard:UIButton!
    @IBOutlet weak var btnTotalCradit:UIButton!
    
    @IBOutlet weak var tableViewObj:UITableView!
    @IBOutlet weak var consTableViewObjHeight: NSLayoutConstraint!
    
    //Parent view outlet's
    @IBOutlet weak var viewRedeemGiftCardPopPerent:UIView!
    
    //Content view outlet's
    @IBOutlet weak var viewRedeemGiftCardContent:UIView!
    @IBOutlet weak var lblReDeemGiftCardTitle:UILabel!
    @IBOutlet weak var btnCancelPop:UIButton!
    
    //MARK:- RedeemGiftCard view Outlet's
    @IBOutlet weak var viewGiftCardCodeParent:UIView!
    @IBOutlet weak var lblGiftCardCodeTitle:UILabel!
    @IBOutlet weak var viewGiftCardCodeTitle:UIView!
    @IBOutlet weak var txtGiftCardCodeTitle:UITextField!
    
    @IBOutlet weak var btnRedeemCode:UIButton!

    // Variable Declarations and Initlizations
    var dicMyCredits = NSDictionary()
    var arrListing = NSMutableArray()
    var isServicesSelected :Int = 0
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        processGetUserCredits()
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
        
        lblNotData.text = "No Credit"
        lblNotData.textColor = COLOR.Green
        lblNotData.textAlignment = .center
        lblNotData.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_SIXTEEN)
        lblNotData.isHidden = true
        
        //header theme
        viewHeader.backgroundColor = COLOR.Green
        
        imgBackground.image = UIImage.init(named: "header_bg")
        
        lblVCTitle.setVCTitle("My Credits")
        
        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        viewContent.isHidden = true
        scrollContent.setThemeForScrollView()
        scrollContent.isScrollEnabled = false
        
        viewSelectLaundry.backgroundColor = COLOR.White

        btnRedeemGiftCard.setThemeForAppButton("REDEEM GIFT CARD")
        btnRedeemGiftCard.addTarget(self, action: #selector(btnRedeemGiftCardClick(_:)), for: .touchUpInside)

        btnTotalCradit.setTitle("Total Credit: $0.00", for: .normal)
        btnTotalCradit.setTitleColor(COLOR.White, for: .normal)
        btnTotalCradit.backgroundColor = COLOR.Gray
        btnTotalCradit.titleLabel?.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        btnTotalCradit.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        btnTotalCradit.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        
        tableViewObj.register(UINib(nibName: "MyCreditsCell", bundle: nil), forCellReuseIdentifier: "MyCreditsCell")
        tableViewObj.separatorStyle = .none
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.backgroundColor = COLOR.White
        tableViewObj.maskToBounds = false
        tableViewObj.isScrollEnabled = true
        tableViewObj.isHidden = true
        
        //Redeem Gift Card popup
        viewRedeemGiftCardPopPerent.backgroundColor = COLOR.Balck.withAlphaComponent(0.5)
        viewRedeemGiftCardPopPerent.isHidden = true
        //Content theme
        viewRedeemGiftCardContent.backgroundColor = COLOR.White
        viewRedeemGiftCardContent.setCornerRadius(corner:5)
        
        lblReDeemGiftCardTitle.setThemeForTitle("Redeem Gift Card", isTitle : false)

        btnCancelPop.setTitle("", for: .normal)
        btnCancelPop.setImage(UIImage.init(named: "cancel_popup"), for: .normal)
        btnCancelPop.tintColor = COLOR.Gray
        btnCancelPop.addTarget(self, action: #selector(btnPopCancelClick(_:)), for: .touchUpInside)
        
        //set the Gift Card Code parent View Theme
        viewGiftCardCodeParent.backgroundColor = COLOR.clear
        lblGiftCardCodeTitle.setThemeForTextFiledTitle("Enter Gift Card Code")
        viewGiftCardCodeTitle.backgroundColor = COLOR.background_Gray
        viewGiftCardCodeTitle.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtGiftCardCodeTitle.setThemeFor("A2402", returnKeyType : .default)
        
        btnRedeemCode.setThemeForAppButton("REDEEM")
        btnRedeemCode.addTarget(self, action: #selector(btnPopRedeemGiftCardClick(_:)), for: .touchUpInside)
    }
    
    /*
     Function Name :- setDataAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set the data for Controller initial screen values
     */
    func setDataOfViewController()
    {
        arrListing.removeAllObjects()
        
        var intCredit : Double = Double()
        var doubleDabit : Double = Double()

        if dicMyCredits.count > 0
        {
            arrListing.add(["header":"1"])
            (dicMyCredits.value(forKey: ResponceKey_user_credit.credit_detail) as! NSArray).forEach({ (data) in
                arrListing.add(data)
            })
            
            if arrListing.count > 1
            {
                lblNotData.isHidden = true
                for i in 0..<arrListing.count
                {
                    let dictionary = arrListing[i] as! NSDictionary
                    if i != 0
                    {
                        if "\(dictionary.value(forKey: ResponceKey_user_credit.credit_detail_values.transaction_type)!)" == ResponceKey_user_credit.values.credited
                        {
                            intCredit += Double("\(dictionary.value(forKey: ResponceKey_user_credit.credit_detail_values.credits)!)")!
                        }
                        else{
                            doubleDabit += Double("\(dictionary.value(forKey: ResponceKey_user_credit.credit_detail_values.credits)!)")!
                        }
                    }
                }
                btnTotalCradit.setTitle("Total Credit: $\(dicMyCredits.value(forKey: ResponceKey_user_credit.total_amount)!)", for: .normal)
                tableViewObj.isScrollEnabled = true
            }
            else{
                lblNotData.isHidden = false
                tableViewObj.isScrollEnabled = false
                btnTotalCradit.setTitle("Total Credit: $\(dicMyCredits.value(forKey: ResponceKey_user_credit.total_amount)!)", for: .normal)
            }
            tableViewObj.reloadData()
            tableViewObj.isHidden = false
        }
        else{
            lblNotData.isHidden = false
            tableViewObj.reloadData()
            tableViewObj.isScrollEnabled = false
//            callMethodAfterDelay(funcName: #selector(setTableViewHeight))
            btnTotalCradit.setTitle("Total Credit: $0.00", for: .normal)
        }
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }
    
    @IBAction func btnRedeemGiftCardClick(_ sender: Any)
    {
        viewRedeemGiftCardPopPerent.isHidden = false
    }

    @IBAction func btnPopRedeemGiftCardClick(_ sender: Any)
    {
        if (txtGiftCardCodeTitle.text?.count)! == 0
        {
            showMyAlertView(message: "Gift Code is required.") { (action) in }
            return
        }
        self.view.endEditing(true)
        processCheckGiftCode(GiftCode: txtGiftCardCodeTitle.text!)
    }
    
    @IBAction func btnPopCancelClick(_ sender: Any)
    {
        viewRedeemGiftCardPopPerent.isHidden = true
        txtGiftCardCodeTitle.text = ""
    }
    
    @objc func setTableViewHeight()
    {
        consTableViewObjHeight.constant = tableViewObj.contentSize.height
        Application_Delegate.showSpinnerView(isShow: false)
        tableViewObj.isHidden = false
    }
    
    //MARK:- API Call Funtions
    func processGetUserCredits(isLoderDisplay: Bool = true)
    {
        if isLoderDisplay == true
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqUserCredit, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    func processCheckGiftCode(GiftCode: String)
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID(),
                                         "email":"\(getUserInfo().value(forKey: ResponceKey_Login_User.email)!)",
                                         "gift_code":GiftCode]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqCheckGiftcode, dictParameter: parameters as NSDictionary,isHeader: false)
    }

}
/*
 Extension Description :- Delegate method for table view.
 */
extension MyCreditVC : UITableViewDelegate, UITableViewDataSource
{
    //Diplay sections cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrListing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "MyCreditsCell") as! MyCreditsCell
        cell.selectionStyle = .none
        if indexPath.row == 0
        {
         cell.reloadMyCardHeader()
        }
        else{
            cell.reloadMyCardData(dictionary: arrListing[indexPath.row] as! NSDictionary)
        }
        return cell
    }
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension MyCreditVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqUserCredit
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        dicMyCredits = resKeyData
                        setDataOfViewController()
                        viewContent.isHidden = false
                    }
                }
                else if statusCode == 5
                {
                    setDataOfViewController()
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
        else if reqTask == reqCheckGiftcode
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in }
                        viewRedeemGiftCardPopPerent.isHidden = true
                        txtGiftCardCodeTitle.text = ""
                        processGetUserCredits(isLoderDisplay: false)
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
