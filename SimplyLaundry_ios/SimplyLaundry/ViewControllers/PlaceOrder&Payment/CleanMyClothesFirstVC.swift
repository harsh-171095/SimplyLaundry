//
//  HomeVC.swift
//  SimplyLaundry
//
//  Created by webclues on 31/12/18.
//  Copyright © 2018 webclues. All rights reserved.
//

import UIKit
import DropDown
var arrAddressMain = NSArray()

enum addnewAddressType{
    case normal
    case PickupAddress
    case dropoffAddress
}
enum OrderScreenType {
    case placeNewOrder, dublicateOrder
}
class CleanMyClothesFirstVC: UIViewController {
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
    
    @IBOutlet weak var btnAddNewAddress: UIButton!
    
    
    @IBOutlet weak var viewSelectAddressParent:UIView!
    @IBOutlet weak var lblSelectAddressTitle:UILabel!
    @IBOutlet weak var viewSelectAddress:UIView!
    @IBOutlet weak var txtSelectAddress:UITextField!
    @IBOutlet weak var imgSelectAddress:UIImageView!
    @IBOutlet weak var btnSelectAddress:UIButton!
    
    @IBOutlet weak var btnAddDifferentDeliveryAddress:UIButton!
    
    @IBOutlet weak var viewSelectDeliveryAddressParent:UIView!
    @IBOutlet weak var lblSelectDeliveryAddressTitle:UILabel!
    @IBOutlet weak var viewSelectDeliveryAddress:UIView!
    @IBOutlet weak var txtSelectDeliveryAddress:UITextField!
    @IBOutlet weak var imgSelectDeliveryAddress:UIImageView!
    @IBOutlet weak var btnSelectDeliveryAddress:UIButton!
    @IBOutlet weak var consSelectDeliveryAddressHeight: NSLayoutConstraint! // Constraint: set 85 to Diplay and When Hidd set -15

    @IBOutlet weak var viewPickupDelivery:UIView!
    @IBOutlet weak var lblPickupDeliveryTitle:UILabel!
    @IBOutlet weak var collectionPickup:UICollectionView!
    @IBOutlet weak var collectionDelivery:UICollectionView!
    @IBOutlet weak var consCollectionPickupHeight: NSLayoutConstraint!
    @IBOutlet weak var consCollectionDeliveryHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewButtonCircle: UIView!
    
    // Variable Declarations and Initlizations
    var arrAddressList = NSMutableArray()
    var arrServiceAddress1 = NSMutableArray()
    var arrServiceAddress2Main = NSMutableArray()
    var arrServiceAddress2 = NSMutableArray()
    var intDeliverySelectedIndex :Int = 0
    var intPickupSelectedIndex :Int = 0
    var intPickupAddressID : Int = 0
    var intDropoffAddressID : Int = 0
    var isAddNewAddress : Bool  = false
    var isPickupZipCodeValid : String = String()
    var isDeliveryZipCodeValid : String = String()
    lazy var strOrderId : String = ""
    lazy var dicAllSerivces = NSDictionary()
    var strServiceAddress1 = String()
    var strServiceAddress2 = String()
    var varAddNewAddressType : addnewAddressType = .normal
    var screenName = OrderScreenType.placeNewOrder
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        
        if arrAddressMain.count > 0
        {
            if screenName == .dublicateOrder {
                self.processGetAllServices()
                viewContent.isHidden = true
            }
            self.arrAddressList = NSMutableArray(array: arrAddressMain)
            self.setAddress()
            
        }
        else{
           processGetAddressList()
        }
        
        callMethodAfterDelay(funcName: #selector(setCollectionViewHeight))
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
        
        //header theme
        viewHeader.backgroundColor = COLOR.Green
        
        imgBackground.image = UIImage.init(named: "header_bg")
        
        lblVCTitle.setVCTitle("Clean My Clothes")
        
        btnManu.setTitle("", for: .normal)
        btnManu.setImage(screenName == .placeNewOrder ? UIImage.init(named: "side_menu") : UIImage.init(named: "back"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        scrollContent.setThemeForScrollView()
        viewContent.backgroundColor = COLOR.White
        viewContent.isHidden = true
        
        btnAddNewAddress.setTitle("ADD NEW ADDRESS", for: .normal)
        btnAddNewAddress.setTitleColor(COLOR.Blue, for: .normal)
        btnAddNewAddress.titleLabel?.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        btnAddNewAddress.addTarget(self, action: #selector(btnAddNewAddressClick(_:)), for: .touchUpInside)
        
        viewSelectAddressParent.backgroundColor = COLOR.clear
        lblSelectAddressTitle.setThemeForTextFiledTitle("Pickup/Delivery Address")
        viewSelectAddress.backgroundColor = COLOR.background_Gray
        viewSelectAddress.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtSelectAddress.setThemeFor("Select Address")
        imgSelectAddress.image = UIImage.init(named: "down_arrow")
        btnSelectAddress.setTitle("", for: .normal)
        btnSelectAddress.addTarget(self, action: #selector(btnSelectAddressClick(_:)), for: .touchUpInside)
        
        btnAddDifferentDeliveryAddress.setTitle("  Add Different Delivery Address", for: .normal)
        btnAddDifferentDeliveryAddress.setImage(UIImage.init(named: "checkbox"), for: .normal)
        btnAddDifferentDeliveryAddress.setTitleColor(COLOR.Gray, for: .normal)
        btnAddDifferentDeliveryAddress.titleLabel?.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        btnAddDifferentDeliveryAddress.addTarget(self, action: #selector(btnAddDifferentDeliveryAddressClick(_:)), for: .touchUpInside)
        
        viewSelectDeliveryAddressParent.backgroundColor = COLOR.clear
        lblSelectDeliveryAddressTitle.setThemeForTextFiledTitle("Delivery Address")
        viewSelectDeliveryAddress.backgroundColor = COLOR.background_Gray
        viewSelectDeliveryAddress.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtSelectDeliveryAddress.setThemeFor("Select Address")
        imgSelectDeliveryAddress.image = UIImage.init(named: "down_arrow")
        btnSelectDeliveryAddress.setTitle("", for: .normal)
        btnSelectDeliveryAddress.addTarget(self, action: #selector(btnSelectDeliveryAddressClick(_:)), for: .touchUpInside)
        
        viewPickupDelivery.backgroundColor = COLOR.clear
        lblPickupDeliveryTitle.text = "Handoff for Pickup and Delivery?"
        lblPickupDeliveryTitle.textColor = COLOR.Gray
        lblPickupDeliveryTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        collectionDelivery.backgroundColor = COLOR.clear
        collectionDelivery.register(UINib(nibName: "HomeCollectionFirstCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionFirstCell")
        collectionDelivery.delegate = self
        collectionDelivery.dataSource = self
        
        collectionPickup.backgroundColor = COLOR.clear
        collectionPickup.register(UINib(nibName: "HomeCollectionSceondCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionSceondCell")
        collectionPickup.delegate = self
        collectionPickup.dataSource = self
        
        btnNext.setThemeForAppButton("NEXT")
        btnNext.addTarget(self, action: #selector(btnNextClick(_:)), for: .touchUpInside)
        viewButtonCircle.backgroundColor = COLOR.White
        viewButtonCircle.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: viewButtonCircle.frame.height / 2)
     
        setDataOfViewController()
    }
    
    /*
     Function Name :- setDataOfViewController
     Function Parameters :- (nil)
     Function Description :- This function used to set a data for Controller initial screen values
     */
    func setDataOfViewController()
    {
        consSelectDeliveryAddressHeight.constant = 0
        viewSelectDeliveryAddress.isHidden = true
        btnAddDifferentDeliveryAddress.setImage(UIImage.init(named: "checkbox"), for: .normal)
        
        arrServiceAddress1 = [["img":"apartment","img_selected":"apatment_green","title":"Apartment/Condominium", "slug":RequestParameters_place_order.service_address1_values.Apartment, "isSelected":true],
                              ["img":"house","img_selected":"house_green","title":"House", "slug":RequestParameters_place_order.service_address1_values.House, "isSelected":false],
                              ["img":"business","img_selected":"business_green","title":"Hotel/Business", "slug":RequestParameters_place_order.service_address1_values.Business, "isSelected":false]]
        collectionDelivery.reloadData()
        arrServiceAddress2Main = [["img":"leave_with_concierge", "img_selected":"leave_with_concierge_green", "title":"Leave with concierge", "slug":RequestParameters_place_order.service_address2_values.Concierge, "isSelected":true],
                                  ["img":"leave_at_door", "img_selected":"leave_at_door_green", "title":"Leave at Door", "slug":RequestParameters_place_order.service_address2_values.Doorstep, "isSelected":false],
                                  ["img":"i_will_be_present", "img_selected":"i_will_be_present_green", "title":"I will be Present", "slug":RequestParameters_place_order.service_address2_values.Present, "isSelected":false]]
        arrServiceAddress2 = NSMutableArray(array: arrServiceAddress2Main)
        collectionPickup.reloadData()
        
        strServiceAddress1 = RequestParameters_place_order.service_address1_values.Apartment
        strServiceAddress2 = RequestParameters_place_order.service_address2_values.Concierge
        
        if screenName == .dublicateOrder {
            if let dictOrderDetails : NSDictionary = dicAllSerivces[get_all_servicesResponce.orderDetails] as? NSDictionary, let dictMainOrderDetails : NSDictionary = dictOrderDetails["main_order_details"] as? NSDictionary {
                //set picker and delivery services
                var arrServiceAddressTemp = NSMutableArray()
                self.strServiceAddress1 = dictMainOrderDetails["address_type"] as! String
                arrServiceAddress1.forEach { (data) in
                    let dictObjc = (data as! NSDictionary).mutableCopy() as! NSDictionary
                    if (dictObjc["slug"] as! String) == (dictMainOrderDetails["address_type"] as! String) {
                        dictObjc.setValue(true, forKey: "isSelected")
                    }
                    else {
                        dictObjc.setValue(false, forKey: "isSelected")
                        
                    }
                    arrServiceAddressTemp.add(dictObjc)
                }
                arrServiceAddress1 = arrServiceAddressTemp
                arrServiceAddressTemp = NSMutableArray()
                
                self.strServiceAddress2 = dictMainOrderDetails["service_type"] as! String
                arrServiceAddress2.forEach { (data) in
                    let dictObjc = (data as! NSDictionary).mutableCopy() as! NSDictionary
                    if (dictObjc["slug"] as! String) == (dictMainOrderDetails["service_type"] as! String) {
                        dictObjc.setValue(true, forKey: "isSelected")
                    }
                    else {
                        dictObjc.setValue(false, forKey: "isSelected")
                    }
                    arrServiceAddressTemp.add(dictObjc)
                }
                arrServiceAddress2 = arrServiceAddressTemp
                setAddress()
            }
            
        }
    }
    
    /*
     Function Name :- setDefaultAddress
     Function Parameters :- (nil)
     Function Description :- set a default address of login user
     */
    func setAddress()
    {
        if screenName == .placeNewOrder {
            if isAddNewAddress == true
            {
                isAddNewAddress = false
                switch varAddNewAddressType
                {
                case .dropoffAddress :
                    setDeliveryAddressData(arrAddressList.lastObject as! NSDictionary)
                case .PickupAddress :
                    setPickupAddressData(arrAddressList.lastObject as! NSDictionary)
                    
                default :
                    if self.btnAddDifferentDeliveryAddress.imageView!.image == UIImage.init(named: "checkbox_done")
                    {
                        setDeliveryAddressData(arrAddressList.lastObject as! NSDictionary)
                    }
                    else{
                        setPickupAddressData(arrAddressList.lastObject as! NSDictionary)
                    }
                }
                
            }
            else{
                setDefaultAddress()
            }
            
        }
        else {
            if let dictDetails : NSDictionary = dicAllSerivces[get_all_servicesResponce.orderDetails] as? NSDictionary, let dictOrderDetails : NSDictionary = dictDetails["main_order_details"] as? NSDictionary {
                let arrPickupAddress = filterArrayOfAddress(forKey: "address_id", value: dictOrderDetails["pickup_address_id"] as? String ?? "")
                let arrDeliveryAddress = filterArrayOfAddress(forKey: "address_id", value: dictOrderDetails["delivery_address_id"] as? String ?? "")
                
                if arrPickupAddress.count > 0,arrDeliveryAddress.count > 0 {
                    setPickupAddressData(arrPickupAddress[0] as! NSDictionary)
                    setDeliveryAddressData(arrDeliveryAddress[0] as! NSDictionary)
                    if dictOrderDetails["pickup_address_id"] as? String ?? "" == dictOrderDetails["delivery_address_id"] as? String ?? "" {
                        txtSelectDeliveryAddress.text = ""
                    } else {
                        btnAddDifferentDeliveryAddressClick(0)
                    }
                }
                else {
                    if arrPickupAddress.count > 0 {
                        setPickupAddressData(arrPickupAddress[0] as! NSDictionary)
                    } else {
                        setDefaultAddress(forPickup: true, delivery: false)
                    }
                    
                    if arrDeliveryAddress.count > 0 {
                        setDeliveryAddressData(arrDeliveryAddress[0] as! NSDictionary)
                    } else {
                        setDefaultAddress(forPickup: false, delivery: true)
                    }
                }
                
            }
        }
        viewContent.isHidden = false
    }
    
    private func setPickupAddressData(_ details : NSDictionary) {
        intPickupAddressID = Int("\(details.value(forKey: "address_id")!)")!
        txtSelectAddress.text = "\(details.value(forKey: "address_line1")!)"
        isPickupZipCodeValid = "\(details.value(forKey: "postal_code_status")!)"
    }
    
    private func setDeliveryAddressData(_ details : NSDictionary) {
        txtSelectDeliveryAddress.text = "\(details.value(forKey: "address_line1")!)"
        intDropoffAddressID = Int("\(details.value(forKey: "address_id")!)")!
        isDeliveryZipCodeValid = "\(details.value(forKey: "postal_code_status")!)"
    }
    
    private func setDefaultAddress(forPickup : Bool = true, delivery : Bool = true ) {
        if forPickup {
            let arraySearch = filterArrayOfAddress(forKey: "is_default", value: "1")
            if arraySearch.count > 0
            {
                setPickupAddressData(arraySearch[0] as! NSDictionary)
            }
        }
        
        if delivery {
            let myAddress = getNSArrayToStringArray(array: arrAddressList, forKey: "address_line1")
            let array = myAddress.filter({ (string) -> Bool in
                return string != txtSelectAddress.text
            })
            if array.count > 0
            {
                let arraytemp = filterArrayOfAddress(forKey: "address_line1", value: array[0])
                setDeliveryAddressData(arraytemp[0] as! NSDictionary)
            }
        }
    }
    
    private func filterArrayOfAddress(forKey : String, value : String)-> NSArray {
        let predicateSearch = NSPredicate(format: "\(forKey) CONTAINS[C] '\(value)'")
        return NSArray(array: self.arrAddressList.filtered(using: predicateSearch) as NSArray)
    }
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        if screenName == .placeNewOrder {
            sideMenuController?.toggle()
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnAddNewAddressClick(_ sender: Any)
    {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RagistrationsSecondVC") as! RagistrationsSecondVC
        controller.delegate = self
        controller.screenNo = 2
        self.navigationController?.pushViewController(controller, animated: true)
        self.varAddNewAddressType = .normal
    }
    
    @IBAction func btnSelectAddressClick(_ sender: Any)
    {
        var array = getNSArrayToStringArray(array: arrAddressList, forKey: "address_line1")
        array.append("Add New Address")
        if array.count > 0
        {
            initDropDown(dataSource: array, textFiled: txtSelectAddress,isTextAutoFill : false) { (index, value) in
                print(index)
                if value == "Add New Address"
                {
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "RagistrationsSecondVC") as! RagistrationsSecondVC
                    controller.delegate = self
                    controller.screenNo = 2
                    self.navigationController?.pushViewController(controller, animated: true)
                    self.varAddNewAddressType = .normal
                }
                else
                {
                    self.txtSelectAddress.text = value
                    self.intPickupAddressID = Int("\((self.arrAddressList[index] as! NSDictionary).value(forKey: "address_id")!)")!
                    self.isPickupZipCodeValid = "\((self.arrAddressList[index] as! NSDictionary).value(forKey: "postal_code_status")!)"
                }
            }
        }
        txtSelectDeliveryAddress.text = ""
    }

    @IBAction func btnAddDifferentDeliveryAddressClick(_ sender: Any)
    {
        if btnAddDifferentDeliveryAddress.imageView!.image == UIImage.init(named: "checkbox")
        {
            btnAddDifferentDeliveryAddress.setImage(UIImage.init(named: "checkbox_done"), for: .normal)
            consSelectDeliveryAddressHeight.constant = 95
            viewSelectDeliveryAddress.isHidden = false
        }
        else{
            btnAddDifferentDeliveryAddress.setImage(UIImage.init(named: "checkbox"), for: .normal)
            consSelectDeliveryAddressHeight.constant = 0
            viewSelectDeliveryAddress.isHidden = true
        }
    }
    
    @IBAction func btnSelectDeliveryAddressClick(_ sender: Any)
    {
//        let myAddress = getNSArrayToStringArray(array: arrAddressList, forKey: "address_line1")
        let myAddress : NSArray = arrAddressList.filter { (details) -> Bool in
            return "\((details as! NSDictionary).value(forKey: "address_line1")!)" != txtSelectAddress.text
            } as NSArray
        var array = getNSArrayToStringArray(array: myAddress as NSArray, forKey: "address_line1")
        
        array.append("Add New Address")
        if array.count > 0
        {
            initDropDown(dataSource: array, textFiled: txtSelectDeliveryAddress,isTextAutoFill : false) { (index, value) in
                print(index)
                if value == "Add New Address"
                {
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "RagistrationsSecondVC") as! RagistrationsSecondVC
                    controller.delegate = self
                    controller.screenNo = 2
                    self.navigationController?.pushViewController(controller, animated: true)
                    self.varAddNewAddressType = .normal
                }
                else
                {
                    self.txtSelectDeliveryAddress.text = value
                    
                    let arraySearch = myAddress[index] as! NSDictionary
                    self.intDropoffAddressID = Int("\(arraySearch.value(forKey: "address_id")!)")!
                    self.isDeliveryZipCodeValid = "\(arraySearch.value(forKey: "postal_code_status")!)"
                }
            }
        }
        else{
//            showMyAlertView(message: "Add new address") { (action) in }
        }
    }
    
    @IBAction func btnNextClick(_ sender: Any)
    {
        let dicCleanClothInfo : NSMutableDictionary = NSMutableDictionary()
        dicCleanClothInfo.setValue(intPickupAddressID, forKey: RequestParameters_place_order.pick_up_address)
        dicCleanClothInfo.setValue(intPickupAddressID, forKey: RequestParameters_place_order.delivery_address)
        if isPickupZipCodeValid == "0"
        {
            showMyAlertView(message: "Delivery Not Available At Selected Pickup Address.") { (action) in }
            return
        }
        
        if txtSelectAddress.text?.count == 0
        {
            showMyAlertView(message: "Pickup/Delivery address required.") { (action) in }
            return
        }
        else if self.btnAddDifferentDeliveryAddress.imageView!.image == UIImage.init(named: "checkbox_done")
        {
            if txtSelectDeliveryAddress.text?.count == 0
            {
                showMyAlertView(message: "Delivery address required.") { (action) in }
                return
            }
            if isDeliveryZipCodeValid == "0"
            {
                showMyAlertView(message: "Delivery Not Available At Selected Dropoff Address.") { (action) in }
                return
            }
            dicCleanClothInfo.setValue(intDropoffAddressID, forKey: RequestParameters_place_order.delivery_address)
        }
        dicCleanClothInfo.setValue(strServiceAddress1,
                                   forKey: RequestParameters_place_order.service_address_1)
        dicCleanClothInfo.setValue(strServiceAddress2,
                                   forKey: RequestParameters_place_order.service_address_2)
        print("Clean My Cloths 1:- \(dicCleanClothInfo)")
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CleanMyClothesSecondVC") as! CleanMyClothesSecondVC
        controller.dicCleanClothInfo = NSMutableDictionary(dictionary: dicCleanClothInfo)
        controller.dicAllSerivces = NSMutableDictionary(dictionary: self.dicAllSerivces)
        controller.screenName = self.screenName
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    /*
     Objective Function Name :- setCollectionViewHeight
     Objective Function Parameters :- (nil)
     Objective Function Description :- set a Height of a collection view
     */
    @objc func setCollectionViewHeight()
    {
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE
        {
            consCollectionPickupHeight.constant = self.view.frame.width / 3 + 40
            consCollectionDeliveryHeight.constant = self.view.frame.width / 4
        }
        else if (UIDevice.current.screenType == .iPhones_X_XS) || UIDevice.current.screenType == .iPhone_XR ||  UIDevice.current.screenType == .iPhone_XSMax
        {
            consCollectionPickupHeight.constant = self.view.frame.width / 3 + 10
            consCollectionDeliveryHeight.constant = self.view.frame.width / 5 + 10
        }
        else{
            consCollectionPickupHeight.constant = self.view.frame.width / 3
            consCollectionDeliveryHeight.constant = self.view.frame.width / 6
        }

    }
    
    //MARK:- API Call Funtions
    /*
     Function Name :- processGetAddressList
     Function Parameters :- (nil)
     Function Description :- Call API for get login user address list.
     */
    func processGetAddressList()
    {
        if Application_Delegate.navigationController.topViewController is CleanMyClothesFirstVC
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetAllMyAddress, dictParameter: parameters as NSDictionary,isHeader: false)
        
    }
    
    /*
     API Function Name :- processGetAllServices
     API Function Parameterts :- (nil)
     API Function Description :- get login user preference, service and delivery option.
     */
    func processGetAllServices()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID(),"order_id":strOrderId]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetAllServices, dictParameter: parameters as NSDictionary)
    }
}
/*
Extension Description :- Delegate method for collection view methods.
 */
extension CleanMyClothesFirstVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionDelivery
        {
            return arrServiceAddress1.count
        }
        else{
            return arrServiceAddress2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionDelivery
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionFirstCell", for: indexPath) as! HomeCollectionFirstCell
            cell.reloadData(dictionary: arrServiceAddress1[indexPath.row] as! NSDictionary)
            return cell
        }
        else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionSceondCell", for: indexPath) as! HomeCollectionSceondCell
            cell.reloadData(dictionary: arrServiceAddress2[indexPath.row] as! NSDictionary)
            if intDeliverySelectedIndex == 1
            {
                if indexPath.row == 0{
                    cell.alpha = 0.5
                }
                else{
                    cell.alpha = 1
                }
            }
            else{
                cell.alpha = 1
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionDelivery
        {
            let dic :NSMutableDictionary = NSMutableDictionary(dictionary: arrServiceAddress1[indexPath.row] as! NSDictionary)
            if intDeliverySelectedIndex == -1
            {
                intDeliverySelectedIndex = indexPath.row
                dic.setValue(true, forKey: "isSelected")
                arrServiceAddress1.replaceObject(at: indexPath.row, with: dic)
                collectionDelivery.reloadData()
            }
            else{
                
                let dicSecond = NSMutableDictionary(dictionary: arrServiceAddress1[intDeliverySelectedIndex] as! NSDictionary)
                dicSecond.setValue(false, forKey: "isSelected")
                arrServiceAddress1.replaceObject(at: intDeliverySelectedIndex, with: dicSecond)
                dic.setValue(true, forKey: "isSelected")
                arrServiceAddress1.replaceObject(at: indexPath.row, with: dic)
                intDeliverySelectedIndex = indexPath.row
                collectionDelivery.reloadData()
                strServiceAddress1 = dic.value(forKey: "slug") as! String
            }
            if indexPath.row == 1
            {
                let array = NSMutableArray()
                for i in 0..<arrServiceAddress2Main.count{
                    let dicSecond = NSMutableDictionary(dictionary: arrServiceAddress2Main[i] as! NSDictionary)
                    if i == 1
                    {
                        dicSecond.setValue(true, forKey: "isSelected")
                    }
                    else{
                        dicSecond.setValue(false, forKey: "isSelected")
                    }
                    array.add(dicSecond)
                }
                arrServiceAddress2.removeAllObjects()
                arrServiceAddress2 = NSMutableArray(array: array)
                intPickupSelectedIndex = 1
                collectionPickup.reloadData()
                strServiceAddress2 = (array[1] as! NSDictionary).value(forKey: "slug") as! String
            }
            else{
                arrServiceAddress2.removeAllObjects()
                arrServiceAddress2 = NSMutableArray(array: arrServiceAddress2Main)
                strServiceAddress2 = (arrServiceAddress2[0] as! NSDictionary).value(forKey: "slug") as! String
            }
            collectionPickup.reloadData()
        }
        else{
            let dic :NSMutableDictionary = NSMutableDictionary(dictionary: arrServiceAddress2[indexPath.row] as! NSDictionary)
            if intDeliverySelectedIndex != 1
            {
                let array = NSMutableArray()
                for i in 0..<arrServiceAddress2.count{
                    let dicSecond = NSMutableDictionary(dictionary: arrServiceAddress2[i] as! NSDictionary)
                    dicSecond.setValue(false, forKey: "isSelected")
                    array.add(dicSecond)
                }
                dic.setValue(true, forKey: "isSelected")
                array.replaceObject(at: indexPath.row, with: dic)
                arrServiceAddress2.removeAllObjects()
                arrServiceAddress2 = NSMutableArray(array: array)
                intPickupSelectedIndex = indexPath.row
                collectionPickup.reloadData()
                strServiceAddress2 = dic.value(forKey: "slug") as! String
            }
            else{
                if indexPath.row != 0
                {
                    let array = NSMutableArray()
                    for i in 0..<arrServiceAddress2.count{
                        let dicSecond = NSMutableDictionary(dictionary: arrServiceAddress2[i] as! NSDictionary)
                        dicSecond.setValue(false, forKey: "isSelected")
                        array.add(dicSecond)
                    }
                    dic.setValue(true, forKey: "isSelected")
                    array.replaceObject(at: indexPath.row, with: dic)
                    arrServiceAddress2.removeAllObjects()
                    arrServiceAddress2 = NSMutableArray(array: array)
                    intPickupSelectedIndex = indexPath.row
                    collectionPickup.reloadData()
                    strServiceAddress2 = dic.value(forKey: "slug") as! String
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //top, left, bottom, right
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE
        {
            if collectionView == collectionDelivery
            {
                return CGSize(width: self.view.frame.width/3 - 20 , height:  self.view.frame.width/3 + 30)
            }
            else{
                return CGSize(width: self.view.frame.width/3 - 20 , height:  self.view.frame.width/4)
            }
        }
        else if (UIDevice.current.screenType == .iPhones_X_XS) || UIDevice.current.screenType == .iPhone_XR ||  UIDevice.current.screenType == .iPhone_XSMax
        {
            if collectionView == collectionDelivery
            {
                return CGSize(width: self.view.frame.width/3 - 20 , height:  self.view.frame.width/3 - 10)
            }
            else{
                return CGSize(width: self.view.frame.width/3 - 20 , height:  self.view.frame.width/6)
            }
        }
        else{
            if collectionView == collectionDelivery
            {
                return CGSize(width: self.view.frame.width/3 - 20 , height:  self.view.frame.width/3 - 10)
            }
            else{
                return CGSize(width: self.view.frame.width/3 - 20 , height:  self.view.frame.width/6 - 5)
            }
        }
    }
}

/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension CleanMyClothesFirstVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        
        if reqTask == reqGetAllMyAddress
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let responseKeyData : NSArray = responseData.value(forKey: ResKeyData) as? NSArray
                    {
                        self.arrAddressList = NSMutableArray(array: responseKeyData)
//                        self.setDataOfViewController()
                        arrAddressMain = NSArray(array: self.arrAddressList)
                        
                        if screenName == .dublicateOrder {
                            self.processGetAllServices()
                            viewContent.isHidden = true
                        } else {
                            self.setAddress()
                        }
                    }
                }
                else if statusCode == 5
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message, completion: { (action) in })
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
        else if reqTask == reqGetAllServices {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        dicAllSerivces = NSMutableDictionary(dictionary: resKeyData)
                        setDataOfViewController()
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
    }
}

/*
 Extension Description :- Delegate methods for the add new address response
 */
extension CleanMyClothesFirstVC : RagistrationsSecondVCDelegate
{
    @objc func updateAddress() {
        isAddNewAddress = true
        processGetAddressList()
    }
}
