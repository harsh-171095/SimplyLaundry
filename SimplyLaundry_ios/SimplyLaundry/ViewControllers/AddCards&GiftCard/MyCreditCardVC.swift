//
//  MyCreditCardVC.swift
//  SimplyLaundry
//
//  Created by webclues on 12/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class MyCreditCardVC: UIViewController {
    
    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnManu:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var viewContent:UIView!
    
    @IBOutlet weak var tableViewObj:UITableView!
    @IBOutlet weak var consTableViewObjHeight: NSLayoutConstraint!
    
    // Variable Declarations and Initlizations
    var arrCardList = NSMutableArray()
    var selectedIndex : Int = 0
    var isUpdate : Bool = false

    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        processGetAllCreditCard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if isUpdate == true
        {
            processGetAllCreditCard()
        }
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
        
        lblVCTitle.setVCTitle("My Credit Cards")

        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        viewContent.isHidden = true
        
        //Order History Listing View Theme
        tableViewObj.register(UINib(nibName: "MyCreditCardsCell", bundle: nil), forCellReuseIdentifier: "MyCreditCardsCell")
        tableViewObj.register(UINib(nibName: "AddAddressCell", bundle: nil), forCellReuseIdentifier: "AddAddressCell")
        tableViewObj.separatorStyle = .none
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.backgroundColor = COLOR.White
        tableViewObj.isScrollEnabled = false
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }
    
    @IBAction func btnEditAddressClick(MyAddressListCell sender:UIButton)
    {
        let controler = self.storyboard?.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardVC
        controler.screenNo = 2
        controler.dicCardDetails = arrCardList[sender.tag] as! NSDictionary
        self.navigationController?.pushViewController(controler, animated: true)
    }
    
    @IBAction func btnDeleteAddressClick(MyAddressListCell sender:UIButton)
    {
        let dic = arrCardList[sender.tag] as! NSDictionary
        showMyAlertView(message: "Are you sure you want to remove this card?", title: [Alert_cancel,Alert_Ok]) { (action) in
            if action.title == Alert_Ok
            {
                self.processDeleteCreditCard(cardID: "\(dic.value(forKey: ResponceKey_get_all_credit_card.dataValues.payment_profile_id)!)")
            }
        }
    }
    
    @IBAction func btnCheckUnCheckAddressClick(MyAddressListCell sender:UIButton)
    {
        if selectedIndex != sender.tag
        {
            selectedIndex = sender.tag
            processSetCreditCardAsDefault(cardID: "\((arrCardList[sender.tag] as! NSDictionary).value(forKey: ResponceKey_get_all_credit_card.dataValues.payment_profile_id)!)")
        }
    }
    
    @IBAction func btnAddCardClick(AddAddressCell sender: UIButton)
    {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardVC
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func setCollectionViewHeight()
    {
        consTableViewObjHeight.constant = tableViewObj.contentSize.height + 35
        viewContent.isHidden = false
    }
    
    //MARK:- API Call Funtions
    func processGetAllCreditCard()
    {
        if Application_Delegate.navigationController.topViewController is MyCreditCardVC
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetAllCreditCard, dictParameter: parameters as NSDictionary)
        isUpdate = false
    }

    func processSetCreditCardAsDefault(cardID ID:String)
    {
        if Application_Delegate.navigationController.topViewController is MyCreditCardVC
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID(),"payment_profile_id":ID]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqSetDefaultCreditCard, dictParameter: parameters as NSDictionary)
    }

    func processDeleteCreditCard(cardID ID:String)
    {
        if Application_Delegate.navigationController.topViewController is MyCreditCardVC
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID(),"payment_profile_id":ID]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqDeleteCreditCard, dictParameter: parameters as NSDictionary)
    }

}
/*
 Extension Description :- Delegate method for table view.
 */
extension MyCreditCardVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCardList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrCardList.count == indexPath.row
        {
            let cell = tableViewObj.dequeueReusableCell(withIdentifier: "AddAddressCell") as! AddAddressCell
            cell.selectionStyle = .none
            cell.btnAddAddress.setTitle("ADD CARD     ", for: .normal) // 5 Blank Space after text
            cell.btnAddAddress.tag = indexPath.row
            cell.btnAddAddress.addTarget(self, action: #selector(btnAddCardClick(AddAddressCell:)), for: .touchUpInside)
            return cell
        }
        else{
            let cell = tableViewObj.dequeueReusableCell(withIdentifier: "MyCreditCardsCell") as! MyCreditCardsCell
            cell.selectionStyle = .none
            cell.reloadData(dictionary: arrCardList[indexPath.row] as! NSDictionary)
            cell.btnCheckUncheck.tag = indexPath.row
            cell.btnCheckUncheck.addTarget(self, action: #selector(btnCheckUnCheckAddressClick(MyAddressListCell:)), for: .touchUpInside)
            cell.btnEdit.tag = indexPath.row
            cell.btnEdit.addTarget(self, action: #selector(btnDeleteAddressClick(MyAddressListCell:)), for: .touchUpInside)
            if "\((arrCardList[indexPath.row] as! NSDictionary).value(forKey: ResponceKey_get_all_credit_card.dataValues.is_default)!)" == "1"
            {
                selectedIndex = indexPath.row
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton()
        btn.tag = indexPath.row
        btnCheckUnCheckAddressClick(MyAddressListCell: btn)
    }
}

/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension MyCreditCardVC : webServiceDataProviderDelegate
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
                        tableViewObj.reloadData()
                        callMethodAfterDelay(funcName: #selector(setCollectionViewHeight))
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
        else if reqTask == reqSetDefaultCreditCard
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    processGetAllCreditCard()
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
        else if reqTask == reqDeleteCreditCard
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    processGetAllCreditCard()
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
 Extension Description :- Delegate methods for add a new card
 */
extension MyCreditCardVC : AddCardVCDelegate
{
    @objc func updateCard()
    {
        isUpdate = true
    }
}
