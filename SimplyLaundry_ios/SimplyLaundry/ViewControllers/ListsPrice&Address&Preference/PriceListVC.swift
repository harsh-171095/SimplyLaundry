//
//  PriceListVC.swift
//  SimplyLaundry
//
//  Created by webclues on 03/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

var arrDryClean = NSArray()
var arrLaundry = NSArray()
var arrGlobalServices = NSArray()

class PriceListVC: UIViewController {

    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    @IBOutlet weak var lblNotData:UILabel!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnManu:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var viewContent:UIView!
    
    @IBOutlet weak var viewSelectLaundry:UIView!
    @IBOutlet weak var collectionSelectLaundry:UICollectionView!
    @IBOutlet weak var consCollectionSelectLaundryHeight: NSLayoutConstraint!
  
    @IBOutlet weak var viewSearch:UIView!
    @IBOutlet weak var btnSearchHere:UIButton!
    @IBOutlet weak var txtSearch:UITextField!
    @IBOutlet weak var btnCancelSearch:UIButton!
    @IBOutlet weak var lblSepratior:UILabel!
    @IBOutlet weak var consViewScearchTop: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewObj:UITableView!
    @IBOutlet weak var consTableViewObjHeight: NSLayoutConstraint!
    
    
    // Variable Declarations and Initlizations    
    var dicPriceList = NSMutableDictionary()
    
    var arrServices = NSMutableArray()
    var arrListing = NSArray()
    var arraySearch = NSArray()
    
    var isServicesSelected :Int = 0
    var isSearch : Bool = false
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        if arrGlobalServices.count > 0
        {
            arrServices = NSMutableArray(array: arrGlobalServices)
            collectionSelectLaundry.reloadData()
            setGlobaldata(cat_id: "\((arrServices[0] as! NSDictionary).value(forKey: ResponceKey_get_all_price_details.service_product.service_category_id)!)",indexRow:0)
        }
        else{
            processGetServicesList()
        }
        
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
        
        lblVCTitle.setVCTitle("Price List")
        
        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
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
        
        viewSearch.backgroundColor = COLOR.Gray.withAlphaComponent(0.2)
        viewSearch.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        btnSearchHere.setTitle("SEARCH", for: .normal)
        btnSearchHere.setTitleColor(COLOR.Blue, for: .normal)
        btnSearchHere.titleLabel?.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        btnSearchHere.addTarget(self, action: #selector(btnSearchHereClick(_:)), for: .touchUpInside)
        txtSearch.setThemeFor("Search here...", returnKeyType : .default)
        txtSearch.delegate = self
        btnCancelSearch.tintColor = COLOR.Gray
        btnCancelSearch.setTitle("", for: .normal)
        btnCancelSearch.setImage(UIImage.init(named: "cancel_popup"), for: .normal)
        btnCancelSearch.addTarget(self, action: #selector(btnCancelSearchClick(_:)), for: .touchUpInside)
        
        lblSepratior.setThemeForSeprator()
        
        tableViewObj.register(UINib(nibName: "PriceListCell", bundle: nil), forCellReuseIdentifier: "PriceListCell")
        tableViewObj.register(UINib(nibName: "PriceListHeaderCell", bundle: nil), forCellReuseIdentifier: "PriceListHeaderCell")
        tableViewObj.separatorStyle = .none
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.backgroundColor = COLOR.White
        tableViewObj.maskToBounds = false
        tableViewObj.isScrollEnabled = true
        tableViewObj.isHidden = true
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }
    
    @IBAction func btnCancelSearchClick(_ sender: Any)
    {
        view.endEditing(true)
        isSearch = false
        txtSearch.text = ""
        if arrListing.count > 0
        {
            lblNotData.isHidden = true
        }
        else{
            lblNotData.isHidden = false
        }
        tableViewObj.reloadData()
        consViewScearchTop.constant = -(viewSearch.bounds.height)
        btnSearchHere.isHidden = false
        viewSearch.isHidden = true
    }
    
    @IBAction func btnSearchHereClick(_ sender: Any)
    {
        consViewScearchTop.constant = 10
        btnSearchHere.isHidden = true
        viewSearch.isHidden = false
    }
    
    @objc func setCollectionViewHeight()
    {
        consCollectionSelectLaundryHeight.constant = 60
    }
    
    @objc func setTableViewHeight()
    {
        let headerTotalHeight = arrListing.count * 44
        let cellTotalHeight :Int = { () -> Int in
            var totaleCount = Int()
            for i in 0..<self.arrListing.count
            {
                totaleCount += ((self.arrListing[i] as! NSDictionary).value(forKey: ResponceKey_get_all_price_details.products) as! NSArray).count
            }
            return totaleCount * 38
        }()
        
        consTableViewObjHeight.constant = CGFloat(headerTotalHeight + cellTotalHeight)
        Application_Delegate.showSpinnerView(isShow: false)
        tableViewObj.isHidden = false
    }
    
    //MARK:- API Call Funtions
    func processGetServicesList()
    {
        if Application_Delegate.navigationController.topViewController is PriceListVC
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_GET(reqTask: reqGetAllCategory, dictParameter: NSDictionary())
        
    }
    
    
    func processGetPriceList(fromID id:String)
    {
        if Application_Delegate.navigationController.topViewController is PriceListVC
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["category_id":id]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: ReqGetAllPriceDetails, dictParameter: parameters as NSDictionary)
        
    }
    
    /*
     Function Name :- setGlobaldata
     Function Parameters :- (dataSource: String Array, textFiled : UITextField)
     Function Description :- set a Price list global data in local Array
     */
    func setGlobaldata(cat_id:String,indexRow:Int)
    {
        if indexRow == 0
        {
            if arrDryClean.count > 0
            {
                arrListing = NSMutableArray(array: arrDryClean)
            }
            else{
                processGetPriceList(fromID: cat_id)
            }
        }
        else if indexRow == 1
        {
            if arrLaundry.count > 0
            {
                arrListing = NSMutableArray(array: arrLaundry)
            }
            else{
                processGetPriceList(fromID: cat_id)
            }
        }
        btnCancelSearchClick(btnCancelSearch)
        viewContent.isHidden = false
        if arrListing.count > 0
        {
            lblNotData.isHidden = true
            tableViewObj.reloadData()
            tableViewObj.isHidden = false
        }
        else{
            tableViewObj.isHidden = true
            lblNotData.isHidden = false
        }
    }
}
/*
 Extension Description :- Delegate method for collection view.
 */
extension PriceListVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
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
        if isServicesSelected != indexPath.row
        {
            btnCancelSearchClick(btnCancelSearch)
            tableViewObj.isHidden = true
            setGlobaldata(cat_id: "\(dic.value(forKey: ResponceKey_get_all_price_details.service_product.service_category_id)!)",indexRow:indexPath.row)
        }
        if isServicesSelected == -1
        {
            isServicesSelected = indexPath.row
            dic.setValue(true, forKey: isSelected_Key)
            arrServices.replaceObject(at: indexPath.row, with: dic)
            collectionSelectLaundry.reloadData()
        }
        else{
            
            let dicSecond = NSMutableDictionary(dictionary: arrServices[isServicesSelected] as! NSDictionary)
            dicSecond.setValue(false, forKey: isSelected_Key)
            arrServices.replaceObject(at: isServicesSelected, with: dicSecond)
            dic.setValue(true, forKey: isSelected_Key)
            arrServices.replaceObject(at: indexPath.row, with: dic)
            isServicesSelected = indexPath.row
            collectionSelectLaundry.reloadData()
        }
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
 Extension Description :- Delegate method for table view.
 */
extension PriceListVC : UITableViewDelegate, UITableViewDataSource
{
    //Diplay Header sections
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if isSearch == true
        {
            return arraySearch.count
        }
        else{
            return arrListing.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "PriceListHeaderCell") as! PriceListHeaderCell
        cell.selectionStyle = .none
        var dic = NSDictionary()
        if isSearch == true
        {
            dic = arraySearch[section] as! NSDictionary
        }
        else{
            dic = arrListing[section] as! NSDictionary
        }
        
        cell.reloadData(dictionary: dic)
        cell.viewParent.backgroundColor = COLOR.White
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 44
    }

    //Diplay sections cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var array = NSArray()
        if isSearch == true
        {
            array = NSArray(array: (arraySearch[section] as! NSDictionary).value(forKey: ResponceKey_get_all_price_details.products) as! NSArray)
        }
        else{
            array = NSArray(array: (arrListing[section] as! NSDictionary).value(forKey: ResponceKey_get_all_price_details.products) as! NSArray)
        }
        
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "PriceListCell") as! PriceListCell
        cell.selectionStyle = .none
        var dic = NSDictionary()
        if isSearch == true
        {
            dic = ((arraySearch[indexPath.section] as! NSDictionary).value(forKey: ResponceKey_get_all_price_details.products) as! NSArray)[indexPath.row] as! NSDictionary
        }
        else{
            dic = ((arrListing[indexPath.section] as! NSDictionary).value(forKey: ResponceKey_get_all_price_details.products) as! NSArray)[indexPath.row] as! NSDictionary
        }

        cell.reloadData(dictionary: dic)
        return cell
    }
}
/*
 Extension Description :- Delegate methods for the Response of API Calling.
 */
extension PriceListVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqGetAllCategory
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSArray = responseData.value(forKey: ResKeyData) as? NSArray
                    {
                        arrServices = { () -> NSMutableArray in
                            let array = NSMutableArray(array: resKeyData)
                            for i in 0..<array.count
                            {
                                let dic : NSMutableDictionary = NSMutableDictionary(dictionary: array[i] as! NSDictionary)
                                if i == 0{
                                    dic.setValue(true, forKey: get_all_servicesResponce.isSelected)
                                }
                                else{
                                    dic.setValue(false, forKey: get_all_servicesResponce.isSelected)
                                }
                                if "\(dic.value(forKey: ResponceKey_get_all_price_details.service_product.service_category_id)!)" == "1"
                                {
                                    dic.setValue("dry_clean_1", forKey: get_all_servicesResponce.wash_service_value.service_img)
                                    dic.setValue("dry_clean_green_1", forKey: get_all_servicesResponce.wash_service_value.active_service_img)
                                }
                                else if "\(dic.value(forKey: ResponceKey_get_all_price_details.service_product.service_category_id)!)" == "2"
                                {
                                    dic.setValue("laundry", forKey: get_all_servicesResponce.wash_service_value.service_img)
                                    dic.setValue("laundry_green", forKey: get_all_servicesResponce.wash_service_value.active_service_img)
                                }
                                array.replaceObject(at: i, with: dic)
                            }
                            return array
                        }()
                        collectionSelectLaundry.reloadData()
                        isServicesSelected = 0
                        arrGlobalServices = NSArray(array: arrServices)
                        if arrDryClean.count > 0
                        {
                            setGlobaldata(cat_id: "\((arrServices[0] as! NSDictionary).value(forKey: ResponceKey_get_all_price_details.service_product.service_category_id)!)",indexRow:0)
                        }
                        else{
                            processGetPriceList(fromID: "\((arrServices[0] as! NSDictionary).value(forKey: ResponceKey_get_all_price_details.service_product.service_category_id)!)")
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
        else if reqTask == ReqGetAllPriceDetails
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus ||  statusCode == 2
                {
                    if let resKeyData : NSArray = responseData.value(forKey: ResKeyData) as? NSArray
                    {
                        arrListing = NSMutableArray(array: resKeyData)
                        btnCancelSearchClick(btnCancelSearch)
                        viewContent.isHidden = false
                        
                        if isServicesSelected == 0
                        {
                            arrDryClean = arrListing
                        }
                        else if isServicesSelected == 1
                        {
                            arrLaundry = arrListing
                        }
                        
                        if arrListing.count > 0
                        {
                            lblNotData.isHidden = true
                            tableViewObj.reloadData()
                            tableViewObj.isHidden = false
                        }
                        else{
                            tableViewObj.isHidden = true
                            lblNotData.isHidden = false
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
 Extension Description :- Delegate methods for the UITextFiled.
 */
extension PriceListVC : UITextFieldDelegate
{    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var newString = ""
        newString = String(format: "%@%@", textField.text! , string)
        
        if string == "" || string == "\n"{
            newString = (newString as NSString).substring(to: (newString.count) - 1)
        }
        
        
        if newString.count > 1
        {
            let predicateSearch = NSPredicate(format: "\(ResponceKey_get_all_price_details.service_product.product_name) CONTAINS[C] %@",newString)
            let arrSearchResult = NSMutableArray()
            
            arrListing.forEach { (data) in
                let array = NSArray(array: (data as! NSDictionary).value(forKey: ResponceKey_get_all_price_details.products) as! NSArray)
                let arrfilter = NSArray(array: (array).filtered(using: predicateSearch) as NSArray)
                
                if arrfilter.count > 0
                {
                    let dic = NSMutableDictionary(dictionary: data as! NSDictionary)
                    dic.setValue(arrfilter, forKey: ResponceKey_get_all_price_details.products)
                    arrSearchResult.add(dic)
                }
            }
            
            arraySearch = NSArray(array: arrSearchResult)
            isSearch = true
            if arraySearch.count > 0
            {
               lblNotData.isHidden = true
            }
            else{
               lblNotData.isHidden = false
            }
            tableViewObj.reloadData()
        }
        else{
            isSearch = false
            if arrListing.count > 0
            {
                lblNotData.isHidden = true
            }
            else{
                lblNotData.isHidden = false
            }
            tableViewObj.reloadData()
        }
        
        return true
    }
}
