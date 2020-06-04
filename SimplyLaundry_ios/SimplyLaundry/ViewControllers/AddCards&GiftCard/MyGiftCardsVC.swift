//
//  MyGiftCardsVC.swift
//  SimplyLaundry
//
//  Created by webclues on 28/02/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class MyGiftCardsVC: UIViewController {
    
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
    @IBOutlet weak var collectionSelectLaundry:UICollectionView!
    @IBOutlet weak var consCollectionSelectLaundryHeight: NSLayoutConstraint!
    @IBOutlet weak var lblSepratior:UILabel!
    
    @IBOutlet weak var tableViewObj:UITableView!
    @IBOutlet weak var consTableViewObjHeight: NSLayoutConstraint!
    
    
    // Variable Declarations and Initlizations
    var dicGiftCards = NSMutableDictionary()
    
    var arrServices : NSMutableArray = [[ResponceKey_get_all_price_details.service_product.service_categry_name:"Sent", get_all_servicesResponce.wash_service_value.active_service_img:"", get_all_servicesResponce.wash_service_value.service_img:"",isSelected_Key:true],
                       [ResponceKey_get_all_price_details.service_product.service_categry_name:"Received", get_all_servicesResponce.wash_service_value.active_service_img:"", get_all_servicesResponce.wash_service_value.service_img:"",isSelected_Key:false]]
    var arrListing = NSMutableArray()
    
    var isServicesSelected :Int = 0
    var intRedeemButtonIndex : Int = -1
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        processGetGiftCardList()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        lblNotData.text = "No Data Avalibale"
        lblNotData.textColor = COLOR.Green
        lblNotData.textAlignment = .center
        lblNotData.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_SIXTEEN)
        lblNotData.isHidden = true
        
        //header theme
        viewHeader.backgroundColor = COLOR.Green
        
        imgBackground.image = UIImage.init(named: "header_bg")
        
        lblVCTitle.setVCTitle("Gift Cards")

        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        scrollContent.setThemeForScrollView()
        scrollContent.isScrollEnabled = false
        viewContent.backgroundColor = COLOR.White
        viewContent.isHidden = true
        
        viewSelectLaundry.backgroundColor = COLOR.White
        collectionSelectLaundry.backgroundColor = COLOR.White
        collectionSelectLaundry.register(UINib(nibName: "PriceListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PriceListCollectionCell")
        collectionSelectLaundry.delegate = self
        collectionSelectLaundry.dataSource = self
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionSelectLaundry.collectionViewLayout = collectionViewFlowLayout
        collectionSelectLaundry.isPagingEnabled = false
        collectionSelectLaundry.isHidden = false
        
        lblSepratior.setThemeForTitle( isTitle: false, numberOfLines: 0)
        
        tableViewObj.register(UINib(nibName: "PackagesCell", bundle: nil), forCellReuseIdentifier: "PackagesCell")
        tableViewObj.separatorStyle = .none
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.backgroundColor = COLOR.White
        tableViewObj.maskToBounds = false
        tableViewObj.isScrollEnabled = true
        tableViewObj.isHidden = false
    }
    
    /*
     Function Name :- realoadData
     Function Parameters :- (nil)
     Function Description :- This function used to set the data for Controller initial screen values
     */
    func realoadData()
    {
        collectionSelectLaundry.reloadData()
        if isServicesSelected == 0
        {
            arrListing = NSMutableArray(array: dicGiftCards.value(forKey: ResponceKey_get_gift_card.sent) as! NSArray)
        }
        else{
            arrListing = NSMutableArray(array: dicGiftCards.value(forKey: ResponceKey_get_gift_card.received) as! NSArray)
        }
        tableViewObj.reloadData()
        
        if arrListing.count > 0
        {
            lblNotData.isHidden = true
            tableViewObj.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        else{
            lblNotData.isHidden = false
        }
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }
    
    //MARK:- API Call Funtions
    func processGetGiftCardList()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetGiftCard, dictParameter: parameters as NSDictionary)
    }
    
    func processCheckGiftCode(GiftCode: String)
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID(),
                                         "email":"\(getUserInfo().value(forKey: ResponceKey_Login_User.email)!)",
            "gift_code":GiftCode]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqCheckGiftcode, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    func processCancelGiftCard(GiftID: String)
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["gift_card_id":GiftID]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqCancelGiftCard, dictParameter: parameters as NSDictionary,isHeader: false)
    }
}
/*
 Extension Description :- Delegate method for collection view methods.
 */
extension MyGiftCardsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PriceListCollectionCell", for: indexPath) as! PriceListCollectionCell
        cell.reloadData(dictionary: arrServices[indexPath.row] as! NSDictionary)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dic : NSMutableDictionary = NSMutableDictionary(dictionary: arrServices[indexPath.row] as! NSDictionary)
     
        let dicSecond = NSMutableDictionary(dictionary: arrServices[isServicesSelected] as! NSDictionary)
        dicSecond.setValue(false, forKey: isSelected_Key)
        arrServices.replaceObject(at: isServicesSelected, with: dicSecond)
        dic.setValue(true, forKey: isSelected_Key)
        arrServices.replaceObject(at: indexPath.row, with: dic)
        isServicesSelected = indexPath.row
        collectionSelectLaundry.reloadData()
        realoadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //top, left, bottom, right
        return UIEdgeInsets(top: 20, left: 15, bottom: 15, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: self.view.frame.width/2 - 18 , height:  self.view.frame.width/7 - 5)
    }
}
/*
 Extension Description :- Delegate method for table view methods.
 */
extension MyGiftCardsVC : UITableViewDelegate, UITableViewDataSource
{
    
    //Diplay sections cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrListing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "PackagesCell") as! PackagesCell
        cell.selectionStyle = .none
        
        cell.reloadGiftCard(dictionary: arrListing[indexPath.row] as! NSDictionary, isSend: isServicesSelected)
        
        cell.btnSubmit.tag = indexPath.row
        cell.btnSubmit.addTarget(self, action: #selector(btnSubmitCalick(PackagesCell:)), for: .touchUpInside)
        
        return cell
    }
    
    @IBAction func btnSubmitCalick(PackagesCell sender:UIButton)
    {
        let dic = arrListing[sender.tag] as! NSDictionary
        if isServicesSelected == 0
        {
            intRedeemButtonIndex = sender.tag
            processCancelGiftCard(GiftID: "\(dic.value(forKey: ResponceKey_get_gift_card.values.id)!)")
        }
        else if isServicesSelected == 1
        {
            intRedeemButtonIndex = sender.tag
            processCheckGiftCode(GiftCode: "\(dic.value(forKey: ResponceKey_get_gift_card.values.gift_code)!)")
        }
        
    }
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension MyGiftCardsVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqGetGiftCard
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        dicGiftCards = NSMutableDictionary(dictionary: resKeyData)
                        viewContent.isHidden = false
                        realoadData()
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
        else if reqTask == reqCheckGiftcode
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        let dic = NSMutableDictionary(dictionary: arrListing[intRedeemButtonIndex] as! NSDictionary)
                        dic.setValue(1, forKey: ResponceKey_get_gift_card.values.is_registered)
                        arrListing.replaceObject(at: intRedeemButtonIndex, with: dic)
                        
                        tableViewObj.reloadRows(at: [IndexPath(row: intRedeemButtonIndex, section: 0)], with: .fade)
                        showMyAlertView(message: message) { (action) in
                            self.dicGiftCards.setValue(self.arrListing, forKey: ResponceKey_get_gift_card.received)
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
        else if reqTask == reqCancelGiftCard
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        let dic = NSMutableDictionary(dictionary: arrListing[intRedeemButtonIndex] as! NSDictionary)
                        dic.setValue(2, forKey: ResponceKey_get_gift_card.values.is_registered)
                        arrListing.replaceObject(at: intRedeemButtonIndex, with: dic)
                        
                        tableViewObj.reloadRows(at: [IndexPath(row: intRedeemButtonIndex, section: 0)], with: .fade)
                        showMyAlertView(message: message) { (action) in
                            self.dicGiftCards.setValue(self.arrListing, forKey: ResponceKey_get_gift_card.sent)
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
