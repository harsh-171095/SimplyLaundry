//
//  SideManuVC.swift
//  SimplyLaundry
//
//  Created by webclues on 01/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit
import SideMenuController

class SideManuVC: UIViewController {
    
    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnManu:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var viewContent:UIView!
    @IBOutlet weak var tableViewObj:UITableView!
    
    // Variable Declarations and Initlizations
    
    var arrMenuList : NSMutableArray = NSMutableArray()
    var arrSubMenuList : NSMutableArray = NSMutableArray()
    var arrGiftCard: NSMutableArray = NSMutableArray()
    
    var sectionNumber : Int = -1
    var indexRow :Int = -1
    
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
        
        lblVCTitle.text = " "
        lblVCTitle.textColor = COLOR.White
        lblVCTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_TWENTY_FOUR - 2)
        
        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        tableViewObj.register(UINib(nibName: "SideManuCell", bundle: nil), forCellReuseIdentifier: "SideManuCell")
        tableViewObj.register(UINib(nibName: "SideSubManuCell", bundle: nil), forCellReuseIdentifier: "SideSubManuCell")
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.separatorStyle = .none
        tableViewObj.backgroundColor = COLOR.clear
        
        arrMenuList = [["img_left":"clean_my_Cloths","title":"Clean My Clothes","img_right":"","isExpande":false,"data":[]],
                       ["img_left":"price_list","title":"Price List","img_right":"","isExpande":false,"data":[]],
                       ["img_left":"my_account","title":"My Account","img_right":"down_arrow","isExpande":true,"isOpen":false,"data":[
                        ["title":"My Profile"],
                        ["title":"My Addresses"],
                        ["title":"My Orders"],
                        ["title":"My Packages"],
                        ["title":"My Credits"],
                        ["title":"My Credit Cards"],
                        ["title":"Order Preferences"]]],
                       ["img_left":"packages","title":"Packages","img_right":"","isExpande":false,"data":[]],
                       ["img_left":"gift_cards","title":"Gift Cards","img_right":"down_arrow","isExpande":true,"isOpen":false,"data":[
                        ["title":"Send Gift Card"],
                        ["title":"My Gift Card"]]],
                       ["img_left":"refer_freind","title":"Refer Friends","img_right":"","isExpande":false,"data":[]],
                       ["img_left":"contact_us","title":"Contact Us","img_right":"","isExpande":false,"data":[]],
                       ["img_left":"faq's","title":"FAQ's","img_right":"","isExpande":false,"data":[]],
                       ["img_left":"privacy","title":"Privacy Policy","img_right":"","isExpande":false,"data":[]],
                       ["img_left":"terms","title":"Terms & Conditions","img_right":"","isExpande":false,"data":[]],
                       ["img_left":"logout","title":"Logout","img_right":"","isExpande":false,"data":[]]]
        
        arrSubMenuList = [["title":"My Profile"],
                          ["title":"My Addresses"],
                          ["title":"My Orders"],
                          ["title":"My Packages"],
                          ["title":"My Credits"],
                          ["title":"My Credit Cards"],
                          ["title":"Order Preferences"]]
        arrGiftCard = [["title":"Send Gift Card"],
                       ["title":"My Gift Card"]]
        
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }
    
    //MARK:- Supporting functions
    func processLogout()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqLogout, dictParameter: parameters as NSDictionary,isHeader: false)
    }
}
extension SideManuVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrMenuList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "SideManuCell") as! SideManuCell
        cell.selectionStyle = .none
        cell.reloadData(dictionary: arrMenuList[section] as! NSDictionary)
        cell.btnDidSelect.tag = section
        cell.btnDidSelect.addTarget(self, action: #selector(tableViewSction(didSelect:)), for: .touchUpInside)
        return cell
    }
    
    @objc func tableViewSction(didSelect sender:UIButton){
        if sender.tag == 2 //Click on My Accounts then Display Sub Manu of that screen
        {
            let dic : NSMutableDictionary = NSMutableDictionary(dictionary: arrMenuList[sender.tag] as! NSDictionary)
            if dic.value(forKey: "isExpande") as! Bool == true{
                if dic.value(forKey: "isOpen") as! Bool == true
                {
                    dic.setValue("down_arrow", forKey: "img_right")
                    dic.setValue(false, forKey: "isOpen")
                }
                else{
                    dic.setValue("up_arrow", forKey: "img_right")
                    dic.setValue(true, forKey: "isOpen")
                }
                arrMenuList.replaceObject(at: sender.tag, with: dic)
                tableViewObj.reloadData()
                return
            }
        }
        else if sender.tag == 4 //Click on Gift Card Screen then Display Sub Manu of that screen
        {
            let dic : NSMutableDictionary = NSMutableDictionary(dictionary: arrMenuList[sender.tag] as! NSDictionary)
            if dic.value(forKey: "isExpande") as! Bool == true{
                if dic.value(forKey: "isOpen") as! Bool == true
                {
                    dic.setValue("down_arrow", forKey: "img_right")
                    dic.setValue(false, forKey: "isOpen")
                }
                else{
                    dic.setValue("up_arrow", forKey: "img_right")
                    dic.setValue(true, forKey: "isOpen")
                }
                arrMenuList.replaceObject(at: sender.tag, with: dic)
                tableViewObj.reloadData()
                return
            }
        }
        let dic : NSMutableDictionary = NSMutableDictionary(dictionary: arrMenuList[2] as! NSDictionary)
        dic.setValue("down_arrow", forKey: "img_right")
        dic.setValue(false, forKey: "isOpen")
        arrMenuList.replaceObject(at: 2, with: dic)
        let dic1 : NSMutableDictionary = NSMutableDictionary(dictionary: arrMenuList[4] as! NSDictionary)
        dic1.setValue("down_arrow", forKey: "img_right")
        dic1.setValue(false, forKey: "isOpen")
        arrMenuList.replaceObject(at: 4, with: dic1)
        tableViewObj.reloadData()
        
        var controller = UIViewController()
        sideMenuController?.toggle()
        if sender.tag == 0 //Click on Clean My Clothes Screen as HOME Screen
        {
            if (Application_Delegate.navigationController.topViewController is CleanMyClothesFirstVC) == true
            {
                return
            }
            controller = self.storyboard?.instantiateViewController(withIdentifier: "CleanMyClothesFirstVC") as! CleanMyClothesFirstVC
        }
        else if sender.tag == 1 //Click on Price List Screen
        {
            if (Application_Delegate.navigationController.topViewController is PriceListVC) == true
            {
                return
            }
            controller = self.storyboard?.instantiateViewController(withIdentifier: "PriceListVC") as! PriceListVC
        }
        else if sender.tag == 3 //Click on Packages Screen
        {
            if (Application_Delegate.navigationController.topViewController is PackagesVC) == true
            {
                return
            }
            controller = self.storyboard?.instantiateViewController(withIdentifier: "PackagesVC") as! PackagesVC
            
        }
        else if sender.tag == 5 //Click on Refer Friends Screen
        {
            if (Application_Delegate.navigationController.topViewController is ReferFriendsVC) == true
            {
                return
            }
            controller = self.storyboard?.instantiateViewController(withIdentifier: "ReferFriendsVC") as! ReferFriendsVC
        }
        else if sender.tag == 6 //Click on Contact Us Screen
        {
            if (Application_Delegate.navigationController.topViewController is ContactUsVC) == true
            {
                return
            }
            controller = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        }
        else if sender.tag == 7 //Click on FAQ Screen
        {
            let controllerObj = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
            controllerObj.intScreenNo = 2
            controller = controllerObj
        }
        else if sender.tag == 8//Click on Privacy Policy
        {
            let controllerObj = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
            controllerObj.intScreenNo = 1
            controller = controllerObj
        }
        else if sender.tag == 9//Click on Terms & Condition
        {
            let controllerObj = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
            controllerObj.intScreenNo = 3
            controller = controllerObj
        }
        else if sender.tag == 10 //Click on Logout
        {
            showMyAlertView(message: "Are you sure you want to logout?",title: [Alert_cancel,Alert_Ok]) { (action) in
                if action.title == Alert_Ok{
                    self.processLogout()
                }
            }
            return
        }
        Application_Delegate.navigationController.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dic = arrMenuList[section] as! NSDictionary
        if dic.value(forKey: "isExpande") as! Bool == true
        {
            if dic.value(forKey: "isOpen") as! Bool == true
            {
                return (dic.value(forKey: "data") as! NSArray).count
            }
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "SideSubManuCell") as! SideSubManuCell
        cell.selectionStyle = .none
        if indexPath.section == 2
        {
            cell.reloadData(dictionary: arrSubMenuList[indexPath.row] as! NSDictionary)
            
        }
        else{
            cell.reloadData(dictionary: arrGiftCard[indexPath.row] as! NSDictionary)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var controller = UIViewController()
        sideMenuController?.toggle()
        if indexPath.section == 2
        {
            if indexPath.row == 0 //Click on My Profile Screen
            {
                if (Application_Delegate.navigationController.topViewController is MyAccountVC) == true
                {
                    return
                }
                controller = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountVC") as! MyAccountVC
            }
            if indexPath.row == 1 //Click on My Addresses Screen
            {
                if (Application_Delegate.navigationController.topViewController is MyAddressListVC) == true
                {
                    return
                }
                controller = self.storyboard?.instantiateViewController(withIdentifier: "MyAddressListVC") as! MyAddressListVC
            }
            else if indexPath.row == 2 //Click on Order History Screen
            {
                if (Application_Delegate.navigationController.topViewController is OrderHistoryVC) == true
                {
                    return
                }
                controller = self.storyboard?.instantiateViewController(withIdentifier: "OrderHistoryVC") as! OrderHistoryVC
            }
            else if indexPath.row == 3 //Click on My Packages Screen
            {
                if (Application_Delegate.navigationController.topViewController is MyPackagesVC) == true
                {
                    return
                }
                controller = self.storyboard?.instantiateViewController(withIdentifier: "MyPackagesVC") as! MyPackagesVC
            }
            else if indexPath.row == 4 //Click on My Credits Screen
            {
                if (Application_Delegate.navigationController.topViewController is MyCreditVC) == true
                {
                    return
                }
                controller = self.storyboard?.instantiateViewController(withIdentifier: "MyCreditVC") as! MyCreditVC
            }
            else if indexPath.row == 5 //Click on My Credit card
            {
                if (Application_Delegate.navigationController.topViewController is MyCreditCardVC) == true
                {
                    return
                }
                controller = self.storyboard?.instantiateViewController(withIdentifier: "MyCreditCardVC") as! MyCreditCardVC
            }
            else if indexPath.row == 6 //Click on My Preferences screen
            {
                if (Application_Delegate.navigationController.topViewController is MyPreferencesVC) == true
                {
                    return
                }
                controller = self.storyboard?.instantiateViewController(withIdentifier: "MyPreferencesVC") as! MyPreferencesVC
            }
            Application_Delegate.navigationController.pushViewController(controller, animated: true)
        }
        else if indexPath.section == 4
        {
            if indexPath.row == 0 //Click on My Profile Screen
            {
                if (Application_Delegate.navigationController.topViewController is MyAccountVC) == true
                {
                    return
                }
                controller = self.storyboard?.instantiateViewController(withIdentifier: "GiftCardVC") as! GiftCardVC
            }
            if indexPath.row == 1 //Click on My Addresses Screen
            {
                if (Application_Delegate.navigationController.topViewController is MyAddressListVC) == true
                {
                    return
                }
                controller = self.storyboard?.instantiateViewController(withIdentifier: "MyGiftCardsVC") as! MyGiftCardsVC
            }
            Application_Delegate.navigationController.pushViewController(controller, animated: true)
        }
        
        let dic : NSMutableDictionary = NSMutableDictionary(dictionary: arrMenuList[2] as! NSDictionary)
        dic.setValue("down_arrow", forKey: "img_right")
        dic.setValue(false, forKey: "isOpen")
        arrMenuList.replaceObject(at: 2, with: dic)
        let dic1 : NSMutableDictionary = NSMutableDictionary(dictionary: arrMenuList[4] as! NSDictionary)
        dic1.setValue("down_arrow", forKey: "img_right")
        dic1.setValue(false, forKey: "isOpen")
        arrMenuList.replaceObject(at: 4, with: dic1)
        tableViewObj.reloadData()
        
    }
}
extension SideManuVC: webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqLogout
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    removeKeyFromUserDefaults(keyName: User_Info)
                    ResponceKey_ReferrDetails.dicFereDetails = NSDictionary()
                    let controller = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    Application_Delegate.navigationController.pushViewController(controller, animated: false)
                }
                else{
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in }
                    }
                }
            }
        }
    }
}
