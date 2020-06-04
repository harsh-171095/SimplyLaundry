//
//  CleanMyClothesSecondVC.swift
//  SimplyLaundry
//
//  Created by webclues on 01/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit
import DropDown

class CleanMyClothesSecondVC: UIViewController {
    
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
    
    @IBOutlet weak var viewSelectServices:UIView!
    @IBOutlet weak var lblSelectServicesTitle:UILabel!
    @IBOutlet weak var viewPromoCode:UIView!
    @IBOutlet weak var lblPromoCode:UILabel!
    @IBOutlet weak var collectionSelectServices:UICollectionView!
    @IBOutlet weak var consCollectionSelectServicesHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewSpecialInstructions:UIView!
    @IBOutlet weak var txtSpecialInstructions:UITextView!
    
    @IBOutlet weak var viewSelectDeliveryOption:UIView!
    @IBOutlet weak var lblSelectDeliveryOptionTitle:UILabel!
    @IBOutlet weak var collectionSelectDeliveryOption:UICollectionView!
    @IBOutlet weak var consCollectionSelectDeliveryOptionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewSelectDetergentParent:UIView!
    @IBOutlet weak var lblSelectDetergentTitle:UILabel!
    @IBOutlet weak var viewSelectDetergent:UIView!
    @IBOutlet weak var txtSelectDetergent:UITextField!
    @IBOutlet weak var imgSelectDetergent:UIImageView!
    @IBOutlet weak var btnSelectDetergent:UIButton!
    
    @IBOutlet weak var viewSelectBleachParent:UIView!
    @IBOutlet weak var lblSelectBleachTitle:UILabel!
    @IBOutlet weak var viewSelectBleach:UIView!
    @IBOutlet weak var txtSelectBleach:UITextField!
    @IBOutlet weak var imgSelectBleach:UIImageView!
    @IBOutlet weak var btnSelectBleach:UIButton!
    
    @IBOutlet weak var viewSelectFabricParent:UIView!
    @IBOutlet weak var lblSelectFabricTitle:UILabel!
    @IBOutlet weak var viewSelectFabric:UIView!
    @IBOutlet weak var txtSelectFabric:UITextField!
    @IBOutlet weak var imgSelectFabric:UIImageView!
    @IBOutlet weak var btnSelectFabric:UIButton!
    
    @IBOutlet weak var viewExtraServiceParent:UIView!
    @IBOutlet weak var lblExtraServiceTitle:UILabel!
    @IBOutlet weak var tableViewObj:UITableView!
    @IBOutlet weak var consTableViewObjHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewMinOrderParent:UIView!
    @IBOutlet weak var lblMinOrderTitle:UILabel!
    @IBOutlet weak var tableViewObjMinOrder:UITableView!
    @IBOutlet weak var consTableViewObjMinHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewButtonCircle: UIView!
    
    // Variable Declarations and Initlizations
    var dicAllSerivces : NSMutableDictionary = NSMutableDictionary()
    var dicCleanClothInfo = NSMutableDictionary()
    var arrServices = NSMutableArray()
    var arrDeliveryOption = NSMutableArray()
    var arrExtraServiceListing = NSMutableArray()
    var arrMinOrder = NSArray()
    var isServicesSelected :Int = 0
    var isDeliveryOptionSelected :Int = 0
    var strTextViewPlaceholder = "Special Instructions"
    var deliveryOptionHours : Int = Int()
    var screenName = OrderScreenType.placeNewOrder
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        processGetGlobal()
        if screenName == .placeNewOrder {
            processGetAllServices()
        }
        else {
            setDataOfViewController()
        }
    }
    
    //MARK:- set Outlet's Theme
    /*
     Function Name :- setTheme()
     Function Parameters :- nil
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
        
        lblVCTitle.setVCTitle( "Clean My Clothes")
        
        btnBack.setTitle("", for: .normal)
        btnBack.setImage(UIImage.init(named: "back"), for: .normal)
        btnBack.addTarget(self, action: #selector(btnBackClick(_:)), for: .touchUpInside)
        
        //Content theme
        scrollContent.setThemeForScrollView()
        viewContent.backgroundColor = COLOR.White
        viewContent.isHidden = true
        
        viewSelectServices.backgroundColor = COLOR.clear
        lblSelectServicesTitle.setThemeForTextFiledTitle("Select Services")
        lblPromoCode.setThemeForTitle("", textColor: COLOR.White, numberOfLines : 2, size : FONT_SIZE_ELEVEN)
        lblPromoCode.backgroundColor = COLOR.Blue
        viewPromoCode.backgroundColor = COLOR.Blue
        viewPromoCode.isHidden = true
        collectionSelectServices.backgroundColor = COLOR.clear
        collectionSelectServices.register(UINib(nibName: "ServicesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ServicesCollectionCell")
        collectionSelectServices.delegate = self
        collectionSelectServices.dataSource = self
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionSelectServices.collectionViewLayout = collectionViewFlowLayout
        collectionSelectServices.isPagingEnabled = false
        
        viewSpecialInstructions.backgroundColor = COLOR.background_Gray
        viewSpecialInstructions.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtSpecialInstructions.setThemeFor(strTextViewPlaceholder)
        txtSpecialInstructions.delegate = self
        
        viewSelectDeliveryOption.backgroundColor = COLOR.clear
        lblSelectDeliveryOptionTitle.setThemeForTextFiledTitle("Select Delivery Option")
        collectionSelectDeliveryOption.backgroundColor = COLOR.clear
        collectionSelectDeliveryOption.register(UINib(nibName: "DeliveryOptionCell", bundle: nil), forCellWithReuseIdentifier: "DeliveryOptionCell")
        collectionSelectDeliveryOption.delegate = self
        collectionSelectDeliveryOption.dataSource = self
        let collectionViewFlowLayoutOne = UICollectionViewFlowLayout()
        collectionViewFlowLayoutOne.scrollDirection = .vertical
        collectionSelectDeliveryOption.collectionViewLayout = collectionViewFlowLayoutOne
        collectionSelectDeliveryOption.isPagingEnabled = false
        
        viewSelectDetergentParent.backgroundColor = COLOR.clear
        lblSelectDetergentTitle.setThemeForTextFiledTitle("Detergent")
        viewSelectDetergent.backgroundColor = COLOR.background_Gray
        viewSelectDetergent.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtSelectDetergent.setThemeFor("Basic - Scented $0")
        imgSelectDetergent.image = UIImage.init(named: "down_arrow")
        btnSelectDetergent.setTitle("", for: .normal)
        btnSelectDetergent.addTarget(self, action: #selector(btnSelectDetergentClick(_:)), for: .touchUpInside)
        
        viewSelectBleachParent.backgroundColor = COLOR.clear
        lblSelectBleachTitle.setThemeForTextFiledTitle("Bleach (Whitener)")
        viewSelectBleach.backgroundColor = COLOR.background_Gray
        viewSelectBleach.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtSelectBleach.setThemeFor("None $0")
        imgSelectBleach.image = UIImage.init(named: "down_arrow")
        btnSelectBleach.setTitle("", for: .normal)
        btnSelectBleach.addTarget(self, action: #selector(btnSelectBleachClick(_:)), for: .touchUpInside)

        viewSelectFabricParent.backgroundColor = COLOR.clear
        lblSelectFabricTitle.setThemeForTextFiledTitle("Fabric Softener")
        viewSelectFabric.backgroundColor = COLOR.background_Gray
        viewSelectFabric.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtSelectFabric.setThemeFor("None $0")
        imgSelectFabric.image = UIImage.init(named: "down_arrow")
        btnSelectFabric.setTitle("", for: .normal)
        btnSelectFabric.addTarget(self, action: #selector(btnSelectFabricClick(_:)), for: .touchUpInside)
        
        viewExtraServiceParent.backgroundColor = COLOR.clear
        lblExtraServiceTitle.setThemeForTextFiledTitle("Extra Services")
        tableViewObj.register(UINib(nibName: "ExtraServiceCell", bundle: nil), forCellReuseIdentifier: "ExtraServiceCell")
        tableViewObj.separatorStyle = .none
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.backgroundColor = COLOR.White
        tableViewObj.maskToBounds = false
        tableViewObj.isScrollEnabled = false
        
        viewMinOrderParent.backgroundColor = COLOR.clear
        lblMinOrderTitle.setThemeForTextFiledTitle("Minimum Order")
        tableViewObjMinOrder.register(UINib(nibName: "MiniOrderCell", bundle: nil), forCellReuseIdentifier: "MiniOrderCell")
        tableViewObjMinOrder.separatorStyle = .none
        tableViewObjMinOrder.delegate = self
        tableViewObjMinOrder.dataSource = self
        tableViewObjMinOrder.backgroundColor = COLOR.White
        tableViewObjMinOrder.maskToBounds = false
        tableViewObjMinOrder.isScrollEnabled = false
        
        btnNext.setThemeForAppButton("NEXT")
        btnNext.addTarget(self, action: #selector(btnNextClick(_:)), for: .touchUpInside)
        viewButtonCircle.backgroundColor = COLOR.White
        viewButtonCircle.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: viewButtonCircle.frame.height / 2)
    }
    
    /*
     Function Name :- setDataAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set the data for Controller initial screen values
     */
    func setDataOfViewController()
    {
        arrServices = { () -> NSMutableArray in
            
            let array = NSMutableArray(array: self.dicAllSerivces[get_all_servicesResponce.wash_service] as! NSArray)
            for i in 0..<array.count
            {
                let dic = NSMutableDictionary(dictionary: array[i] as! NSDictionary)
                if i == 0{
                    dic.setValue(true, forKey: get_all_servicesResponce.isSelected)
                }
                else{
                   dic.setValue(false, forKey: get_all_servicesResponce.isSelected)
                }
                array.replaceObject(at: i, with: dic)
            }
            return array
        }()
        collectionSelectServices.reloadData()
        setKeyfromDeleveryOption()
        
        arrExtraServiceListing = { () -> NSMutableArray in
            let array = NSMutableArray(array: self.dicAllSerivces[get_all_servicesResponce.bed_bugs_treatment] as! NSArray)
                for i in 0..<array.count
                {
                    let dic = NSMutableDictionary(dictionary: array[i] as! NSDictionary)
                    dic.setValue(false, forKey: get_all_servicesResponce.isSelected)
                    array.replaceObject(at: i, with: dic)
                }
            array.add(["additional_service_id":"-1",get_all_servicesResponce.values.name:"Donation",get_all_servicesResponce.values.is_selected:false])
            return array
        }()
        tableViewObj.reloadData()
        
        var predicateSearch = NSPredicate(format: "\(get_all_servicesResponce.values.is_selected) == %i ",1)
        // Set Detergent prefernace value or defult value
        txtSelectDetergent.text = { () -> String in
            let arrayMain = NSArray(array: dicAllSerivces.value(forKey: get_all_servicesResponce.detergent) as! NSArray)
            let array = NSMutableArray(array: arrayMain.filtered(using: predicateSearch) as NSArray)
            if array.count > 0
            {
                return "\((array[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.name)!)"
            }
            else{
                return "\((arrayMain[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.name)!)"
            }
        }()
        
        // Set Bleach prefernace value or defult value
        txtSelectBleach.text = { () -> String in
            let arrayMain = NSArray(array: dicAllSerivces.value(forKey: get_all_servicesResponce.bleach) as! NSArray)
            let array = NSMutableArray(array: arrayMain.filtered(using: predicateSearch) as NSArray)
            if array.count > 0
            {
                return "\((array[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.name)!)"
            }
            else{
                return "\((arrayMain[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.name)!)"
            }
        }()
        
        // Set fabric Softner prefernace value or defult value
        txtSelectFabric.text = { () -> String in
            let arrayMain = NSArray(array: dicAllSerivces.value(forKey: get_all_servicesResponce.fabric_softner) as! NSArray)
            let array = NSMutableArray(array: arrayMain.filtered(using: predicateSearch) as NSArray)
            if array.count > 0
            {
                return "\((array[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.name)!)"
            }
            else{
                return "\((arrayMain[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.name)!)"
            }
        }()
        if let SpecialInstructions : String = dicAllSerivces.value(forKey: get_all_servicesResponce.special_instructions) as? String
        {
            txtSpecialInstructions.text = SpecialInstructions
            txtSpecialInstructions.textColor = COLOR.textFiled
        }

        callMethodAfterDelay(funcName: #selector(setCollectionViewHeight))
        callMethodAfterDelay(funcName: #selector(setTableViewHeight))
        realoadMinOrderList()
        viewContent.isHidden = false
        
        if (dicAllSerivces[get_all_servicesResponce.promocode] as? String ?? "").isEmpty {
            viewPromoCode.isHidden = true
        } else {
            let strattributtedString = NSMutableAttributedString(string: dicAllSerivces[get_all_servicesResponce.promocode_str] as? String ?? "", attributes: [.font : UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_TWELVE)!,.foregroundColor : COLOR.White])
            let rangePromocode = strattributtedString.mutableString.range(of: dicAllSerivces[get_all_servicesResponce.promocode] as? String ?? "")
            strattributtedString.addAttributes([.font : UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_THIRTEEN)!,.foregroundColor : COLOR.Green], range: rangePromocode)
            lblPromoCode.attributedText = strattributtedString
            viewPromoCode.isHidden = false
        }
        
        
        if screenName == .dublicateOrder {
//            let strattributtedString = NSMutableAttributedString(string: "Used HANG50 promocode for Wash & Hang service to 50% off on you this order.", attributes: [.font : UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_TWELVE)!,.foregroundColor : COLOR.White])
//            let rangePromocode = strattributtedString.mutableString.range(of: "HANG50")
//            strattributtedString.addAttributes([.font : UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_THIRTEEN)!,.foregroundColor : COLOR.Green], range: rangePromocode)
//            lblPromoCode.attributedText = strattributtedString
//            viewPromoCode.isHidden = false
            if let dictOrderDetails : NSDictionary = dicAllSerivces[get_all_servicesResponce.orderDetails] as? NSDictionary, let dictMainOrderDetails : NSDictionary = dictOrderDetails["main_order_details"] as? NSDictionary {
                
                var arrTempList = NSMutableArray()
                let arrOrderService = dictOrderDetails["order_service"] as! NSArray
                arrServices.forEach { (data) in
                    let dictData = (data as! NSDictionary).mutableCopy() as! NSDictionary
                    dictData.setValue(false, forKey: get_all_servicesResponce.isSelected)
                    arrOrderService.forEach({ (data1) in
                        if "\(dictData["service_id"]!)" == "\((data1 as! NSDictionary)["service_id"]!)" {
                            dictData.setValue(true, forKey: get_all_servicesResponce.isSelected)
                        }
                    })
                    arrTempList.add(dictData)
                }
                arrServices = arrTempList
                
                arrTempList = NSMutableArray()
                arrDeliveryOption.forEach { (data) in
                    let dataObjc = (data as! NSDictionary).mutableCopy() as! NSDictionary
                    if "\(dataObjc["delivery_option_id"]!)" == "\(dictMainOrderDetails["delivery_option_id"]!)" {
                        dataObjc.setValue(true, forKey: get_all_servicesResponce.isSelected)
                    }else {
                        dataObjc.setValue(false, forKey: get_all_servicesResponce.isSelected)
                    }
                    arrTempList.add(dataObjc)
                }
                arrDeliveryOption = arrTempList
                txtSpecialInstructions.text = dictMainOrderDetails["special_instructions"] as? String ?? ""
                
                
                // Set fabric Softner prefernace value or defult value
                if let arrOfAddService : NSArray = dictOrderDetails["order_add_service"] as? NSArray, arrOfAddService.count == 4 {
                    predicateSearch = NSPredicate(format: "\(get_all_servicesResponce.values.additional_service_id) == \(arrOfAddService[0]) ")
                    var arrayMain = NSArray(array: dicAllSerivces.value(forKey: get_all_servicesResponce.detergent) as! NSArray)
                    var array = NSMutableArray(array: arrayMain.filter({ (tempData) -> Bool in
                        var isAvalabel = false
                        arrOfAddService.forEach({ (tempData1) in
                            if "\((tempData as! NSDictionary)[get_all_servicesResponce.values.additional_service_id]!)" == "\(tempData1)" {
                                isAvalabel = true
                            }
                        })
                        return isAvalabel
                    }))
                    if array.count > 0
                    {
                        txtSelectDetergent.text = "\((array[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.name)!)"
                    }
                    
                    predicateSearch = NSPredicate(format: "\(get_all_servicesResponce.values.additional_service_id) == \(arrOfAddService[1]) ")
                    arrayMain = NSArray(array: dicAllSerivces.value(forKey: get_all_servicesResponce.bleach) as! NSArray)
                    array = NSMutableArray()
                    array = NSMutableArray(array: arrayMain.filter({ (tempData) -> Bool in
                        var isAvalabel = false
                        arrOfAddService.forEach({ (tempData1) in
                            if "\((tempData as! NSDictionary)[get_all_servicesResponce.values.additional_service_id]!)" == "\(tempData1)" {
                                isAvalabel = true
                            }
                        })
                        return isAvalabel
                    }))
                    if array.count > 0
                    {
                        txtSelectBleach.text = "\((array[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.name)!)"
                    }
                    
                    predicateSearch = NSPredicate(format: "\(get_all_servicesResponce.values.additional_service_id) == \(arrOfAddService[2]) ")
                    arrayMain = NSArray(array: dicAllSerivces.value(forKey: get_all_servicesResponce.fabric_softner) as! NSArray)
                    array = NSMutableArray()
                    array = NSMutableArray(array: arrayMain.filter({ (tempData) -> Bool in
                        var isAvalabel = false
                        arrOfAddService.forEach({ (tempData1) in
                            if "\((tempData as! NSDictionary)[get_all_servicesResponce.values.additional_service_id]!)" == "\(tempData1)" {
                                isAvalabel = true
                            }
                        })
                        return isAvalabel
                    }))
                    if array.count > 0
                    {
                        txtSelectFabric.text = "\((array[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.name)!)"
                    }
                    
                    array = NSMutableArray()
                    arrExtraServiceListing.forEach { (data) in
                        let dataObjc = (data as! NSDictionary).mutableCopy() as! NSDictionary
                        if "\(dataObjc["additional_service_id"]!)" == "\(arrOfAddService[3])" {
                            dataObjc.setValue(true, forKey: get_all_servicesResponce.values.is_selected)
                        }
                        else if "\(dataObjc[get_all_servicesResponce.values.name]!)" == "Donation" {
                            if "\(dictMainOrderDetails["is_donation"]!)" == "1" {
                                dataObjc.setValue(true, forKey: get_all_servicesResponce.values.is_selected)
                            }
                            else {
                               dataObjc.setValue(false, forKey: get_all_servicesResponce.values.is_selected)
                            }
                        }
                        array.add(dataObjc)
                    }
                    arrExtraServiceListing = array
                }
            }
        }
        
    }
    
    /*
     Function Name :- setKeyfromDeleveryOption
     Function Parameters :- (nil)
     Function Description :- set a delivery option of selected service.
     */
    func setKeyfromDeleveryOption()
    {
        arrDeliveryOption = { () -> NSMutableArray in
            
            let arrayMain = NSArray(array: dicAllSerivces.value(forKey: get_all_servicesResponce.delivery_option) as! NSArray)
            let array = NSMutableArray()
            let predicateSearch = NSPredicate(format: "\(get_all_servicesResponce.isSelected) == %@", NSNumber(value: true))
            let array1 = NSMutableArray(array: arrServices.filtered(using: predicateSearch) as NSArray)
           
            for i in 0..<arrayMain.count
            {
                let dic : NSMutableDictionary = NSMutableDictionary(dictionary: arrayMain[i] as! NSDictionary)
                if array1.count == 1
                {
                    if (array1[0] as! NSDictionary).value(forKey: get_all_servicesResponce.wash_service_value.service_slug) as! String == "washandfold"
                    {
                        if i == 0{
                            dic.setValue(true, forKey: get_delivery_optionResponce.isSelected)
                            self.isDeliveryOptionSelected = 0
                        }
                        else{
                            dic.setValue(false, forKey: get_delivery_optionResponce.isSelected)
                        }
                        array.add(dic)

                    }
                    else{
                        if "\(dic.value(forKey: get_all_servicesResponce.delivery_option_values.delivery_hour)!)" == "48"
                        {
                            dic.setValue(true, forKey: get_delivery_optionResponce.isSelected)
                            self.isDeliveryOptionSelected = 0
                            array.add(dic)
                        }
                    }
                }
                else{
                    if "\(dic.value(forKey: get_all_servicesResponce.delivery_option_values.delivery_hour)!)" == "48"
                    {
                        dic.setValue(true, forKey: get_delivery_optionResponce.isSelected)
                        self.isDeliveryOptionSelected = 0
                        array.add(dic)
                    }
                }
            }
            return array
        }()
        collectionSelectDeliveryOption.reloadData()
        callMethodAfterDelay(funcName: #selector(setDilivertyCollectionheight))
    }
    
    
    //MARK:- Button Actions
    @IBAction func btnBackClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddNewAddressClick(_ sender: Any)
    {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RagistrationsSecondVC") as! RagistrationsSecondVC
        controller.screenNo = 2
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnSelectDetergentClick(_ sender: Any)
    {
        initDropDown( dataSource: getNSArrayToStringArray(array: dicAllSerivces.value(forKey: get_all_servicesResponce.detergent) as! NSArray, forKey: get_all_servicesResponce.values.name), textFiled: txtSelectDetergent, nil)
    }
    
    @IBAction func btnSelectBleachClick(_ sender: Any)
    {
        initDropDown( dataSource: getNSArrayToStringArray(array: dicAllSerivces.value(forKey: get_all_servicesResponce.bleach) as! NSArray, forKey: get_all_servicesResponce.values.name), textFiled: txtSelectBleach, nil)
    }
    
    @IBAction func btnSelectFabricClick(_ sender: Any)
    {
        initDropDown( dataSource: getNSArrayToStringArray(array: dicAllSerivces.value(forKey: get_all_servicesResponce.fabric_softner) as! NSArray, forKey: get_all_servicesResponce.values.name), textFiled: txtSelectFabric, nil)
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
    
    @IBAction func btnNextClick(_ sender: Any)
    {
        let searchKey = "isSelected"
        let predicateSearch = NSPredicate(format: "\(searchKey) == %@", NSNumber(value: true))
        let arraySelectedService = NSMutableArray(array: arrServices.filtered(using: predicateSearch) as NSArray)
        
        if arraySelectedService.count == 0
        {
            showMyAlertView(message: "Please select a services.") { (action) in }
            return
        }
        
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.wash_service),
                                   forKey: RequestParameters_place_order.wash_service)
        dicCleanClothInfo.setValue(txtSpecialInstructions.text! == strTextViewPlaceholder ? "" : txtSpecialInstructions.text!,
                                   forKey: RequestParameters_place_order.comment1)
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.delivery_option),
                                   forKey: RequestParameters_place_order.delivery_option)
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.detergent),
                                   forKey: RequestParameters_place_order.detergent)
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.bleach),
                                   forKey: RequestParameters_place_order.bleach)
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.fabric),
                                   forKey: RequestParameters_place_order.fabric)
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.bed_bugs),
                                   forKey: RequestParameters_place_order.bed_bugs)
        dicCleanClothInfo.setValue(getIDFrom(key: RequestParameters_place_order.donation),
                                   forKey: RequestParameters_place_order.donation)
        
        print("Clean My Cloths 2:- \(dicCleanClothInfo)")
        processGetChecqeOptionAvalabel()
        processAddIncompleteOrder()
        
    }
//    detergent, bleach, fabric, bed_bugs
    /*
     Function Name :- getIDFrom
     Function Parameters :- (key : String)
     Function Description :- get a ID from given key value.
     */
    func getIDFrom(key string: String)-> String
    {
        if string == RequestParameters_place_order.wash_service// For get Service id's
        {
            let predicateSearch = NSPredicate(format: "\(get_all_servicesResponce.isSelected) == %@", NSNumber(value: true))
            let array = NSMutableArray(array: arrServices.filtered(using: predicateSearch) as NSArray)
            if let responce : NSArray = array.value(forKey: get_all_servicesResponce.wash_service_value.service_id) as? NSArray
            {
                return responce.componentsJoined(by:",") 
            }
        }
        else if string == RequestParameters_place_order.delivery_option// For get Service id's
        {
            let predicateSearch = NSPredicate(format: "\(get_all_servicesResponce.isSelected) == %@", NSNumber(value: true))
            let array = NSMutableArray(array: arrDeliveryOption.filtered(using: predicateSearch) as NSArray)
            deliveryOptionHours = Int("\((array[0] as! NSDictionary).value(forKey: get_delivery_optionResponce.dataValues.delivery_hour)!)")!
            return "\((array[0] as! NSDictionary).value(forKey: get_delivery_optionResponce.dataValues.delivery_option_id)!)"
        }
        else if string == RequestParameters_place_order.detergent // For get detergent id
        {
            let arrayMain = NSArray(array: dicAllSerivces.value(forKey: get_all_servicesResponce.detergent) as! NSArray)
            let predicateSearch = NSPredicate(format: "\(get_all_servicesResponce.values.name) CONTAINS[C] '\(txtSelectDetergent.text!)'")
            let array = NSMutableArray(array: arrayMain.filtered(using: predicateSearch) as NSArray)
            
            return "\((array[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.additional_service_id)!)"
        }
        else if string == RequestParameters_place_order.bleach // For get bleach id
        {
            let arrayMain = NSArray(array: dicAllSerivces.value(forKey: get_all_servicesResponce.bleach) as! NSArray)
            let predicateSearch = NSPredicate(format: "\(get_all_servicesResponce.values.name) CONTAINS[C] '\(txtSelectBleach.text!)'")
            let array = NSMutableArray(array: arrayMain.filtered(using: predicateSearch) as NSArray)
            return "\((array[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.additional_service_id)!)"
        }
        else if string == RequestParameters_place_order.fabric // For get fabric Softner id
        {
            let arrayMain = NSArray(array: dicAllSerivces.value(forKey: get_all_servicesResponce.fabric_softner) as! NSArray)
            let predicateSearch = NSPredicate(format: "\(get_all_servicesResponce.values.name) CONTAINS[C] '\(txtSelectFabric.text!)'")
            let array = NSMutableArray(array: arrayMain.filtered(using: predicateSearch) as NSArray)
            return "\((array[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.additional_service_id)!)"
        }
        else if string == RequestParameters_place_order.donation // For get extra services
        {
            let predicateSearch = NSPredicate(format: "\(get_all_servicesResponce.values.name) CONTAINS[C] 'Donation'")
            let array = NSMutableArray(array: arrExtraServiceListing.filtered(using: predicateSearch) as NSArray)
            if (array[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.is_selected) as! Bool == true
            {
                return RequestParameters_place_order.donation_values.yes
            }
            else{
                return RequestParameters_place_order.donation_values.no
            }
        }
        else if string == RequestParameters_place_order.bed_bugs // For get bed_bugs
        {
            let tempArray = NSMutableArray(array: arrExtraServiceListing)
            tempArray.removeLastObject()
            let predicateSearch = NSPredicate(format: "\(get_all_servicesResponce.values.is_selected) == %@", NSNumber(value: true))
            let array = NSMutableArray(array: tempArray.filtered(using: predicateSearch) as NSArray)
            if array.count == 1
            {
                return "\((array[0] as! NSDictionary).value(forKey: get_all_servicesResponce.values.additional_service_id)!)"
            }
            else if array.count > 1
            {
                if let responce : NSArray = array.value(forKey: get_all_servicesResponce.values.additional_service_id) as? NSArray
                {
                    return responce.componentsJoined(by:",")
                }
            }
            else{
               return String()
            }
            
        }
        return String()
    }
    
    @objc func setDilivertyCollectionheight()
    {
        consCollectionSelectDeliveryOptionHeight.constant = collectionSelectDeliveryOption.contentSize.height
    }
    
    @objc func setCollectionViewHeight()
    {
        consCollectionSelectServicesHeight.constant = collectionSelectServices.contentSize.height
    }
    
    @objc func setTableViewHeight()
    {
        consTableViewObjHeight.constant = CGFloat(arrExtraServiceListing.count * 25)
        Application_Delegate.showSpinnerView(isShow: false)
    }
    
    /*
     Function Name :- realoadMinOrderList
     Function Parameters :- (nil)
     Function Description :- get a minimum order list from list of service.
     */
    func realoadMinOrderList()
    {
        arrMinOrder = { () -> NSArray in
            let array = NSMutableArray()
            for i in 0..<arrServices.count
            {
                let dic : NSDictionary = arrServices[i] as! NSDictionary
                array.add(["title":"\(dic.value(forKey: get_all_servicesResponce.wash_service_value.service_name)!) Minimum Order: \(dic.value(forKey: get_all_servicesResponce.wash_service_value.min_order)!)"])
            }
            return array
        }()
        tableViewObjMinOrder.reloadData()
        consTableViewObjMinHeight.constant = CGFloat(20 * arrServices.count)
    }
    
    //MARK:- API Call Funtions
    /*
     API Function Name :- processGetAllServices
     API Function Parameterts :- (nil)
     API Function Description :- get login user preference, service and delivery option.
     */
    func processGetAllServices()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetAllServices, dictParameter: parameters as NSDictionary)
    }
    
    /*
     API Function Name :- processGetChecqeOptionAvalabel
     API Function Parameterts :- (nil)
     API Function Description :- Check login user check option is available or not.
     */
    func processGetChecqeOptionAvalabel()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetCheckPermission, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    /*
     API Function Name :- processGetChecqeOptionAvalabel
     API Function Parameterts :- (nil)
     API Function Description :- Check login user check option is available or not.
     */
    func processAddIncompleteOrder()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqAddIncompleteOrder, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    /*
     API Function Name :- processGetGlobal
     API Function Parameterts :- (nil)
     API Function Description :- Get a All Holiday list and global data.
     */
    func processGetGlobal()
    {
        let parameters : [String:Any] = [:]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_GET(reqTask: reqGetGlobal, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
}
/*
 Extension Description :- Delegate method for collection view.
 */
extension CleanMyClothesSecondVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionSelectServices
        {
            return arrServices.count
        }
        else{
            return arrDeliveryOption.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionSelectServices
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServicesCollectionCell", for: indexPath) as! ServicesCollectionCell
            cell.reloadServiceData(dictionary: arrServices[indexPath.row] as! NSDictionary)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeliveryOptionCell", for: indexPath) as! DeliveryOptionCell
            cell.reloadData(dictionary: arrDeliveryOption[indexPath.row] as! NSDictionary)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionSelectServices
        {
            let dic : NSMutableDictionary = NSMutableDictionary(dictionary: arrServices[indexPath.row] as! NSDictionary)
            if isServicesSelected == -1
            {
                isServicesSelected = indexPath.row
                dic.setValue(true, forKey: get_all_servicesResponce.isSelected)
                arrServices.replaceObject(at: indexPath.row, with: dic)
                collectionSelectServices.reloadData()
            }
            else{
                if dic.value(forKey: get_all_servicesResponce.isSelected) as! Bool == true
                {
                    dic.setValue(false, forKey: get_all_servicesResponce.isSelected)
                }
                else{
                    dic.setValue(true, forKey: get_all_servicesResponce.isSelected)
                }
                
                arrServices.replaceObject(at: indexPath.row, with: dic)
                isServicesSelected = indexPath.row
                collectionSelectServices.reloadData()
            }
            
            setKeyfromDeleveryOption()
        }
        else{
            let dic :NSMutableDictionary = NSMutableDictionary(dictionary: arrDeliveryOption[indexPath.row] as! NSDictionary)
            if isDeliveryOptionSelected == -1
            {
                isDeliveryOptionSelected = indexPath.row
                dic.setValue(true, forKey: get_delivery_optionResponce.isSelected)
                arrDeliveryOption.replaceObject(at: indexPath.row, with: dic)
                collectionSelectDeliveryOption.reloadData()
            }
            else{
                let dicSecond = NSMutableDictionary(dictionary: arrDeliveryOption[isDeliveryOptionSelected] as! NSDictionary)
                dicSecond.setValue(false, forKey: get_delivery_optionResponce.isSelected)
                arrDeliveryOption.replaceObject(at: isDeliveryOptionSelected, with: dicSecond)
                dic.setValue(true, forKey: get_delivery_optionResponce.isSelected)
                arrDeliveryOption.replaceObject(at: indexPath.row, with: dic)
                isDeliveryOptionSelected = indexPath.row
                collectionSelectDeliveryOption.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //top, left, bottom, right
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE
        {
            if collectionView == collectionSelectServices
            {
                return CGSize(width: self.view.frame.width/3 - 18 , height:  self.view.frame.width/3 - 10)
            }
            else {
                return CGSize(width: self.view.frame.width/2 - 20 , height:  self.view.frame.width/7 + 15)
            }
        }
        else if (UIDevice.current.screenType == .iPhones_X_XS) || UIDevice.current.screenType == .iPhone_XR ||  UIDevice.current.screenType == .iPhone_XSMax
        {
            if collectionView == collectionSelectServices
            {
                return CGSize(width: self.view.frame.width/3 - 18 , height:  self.view.frame.width/3 - 10)
            }
            else {
                return CGSize(width: self.view.frame.width/2 - 20 , height:  self.view.frame.width/7)
            }
        }
        else{
            if collectionView == collectionSelectServices
            {
                return CGSize(width: self.view.frame.width/3 - 18 , height:  self.view.frame.width/3 - 10)
            }
            else {
                return CGSize(width: self.view.frame.width/2 - 20 , height:  self.view.frame.width/7)
            }
        }
    }
    
}
/*
 Extension Description :- Delegate methods for the UITextFiled and UITextView
 */
extension CleanMyClothesSecondVC : UITextFieldDelegate, UITextViewDelegate
{
    //MARK:- TextView Delegate methods
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        if textView == txtSpecialInstructions
        {
            self.txtSpecialInstructions.textColor = COLOR.textFiled
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtSpecialInstructions.text.count > 0 {
        } else {
            txtSpecialInstructions.text = strTextViewPlaceholder
            txtSpecialInstructions.textColor = COLOR.placeholder
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if txtSpecialInstructions.text == strTextViewPlaceholder {
            txtSpecialInstructions.textColor = COLOR.textFiled
            txtSpecialInstructions.text = ""
        }
        return true
    }
    
}
/*
 Extension Description :- Delegate method for table view.
 */
extension CleanMyClothesSecondVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewObj
        {
            return arrExtraServiceListing.count
        }
        else{
            return arrMinOrder.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewObj
        {
            let cell = tableViewObj.dequeueReusableCell(withIdentifier: "ExtraServiceCell") as! ExtraServiceCell
            cell.selectionStyle = .none
            
            cell.reloadData(dictionary: arrExtraServiceListing[indexPath.row] as! NSDictionary)
            cell.btnCheckUnCkeck.tag = indexPath.row
            cell.btnCheckUnCkeck.addTarget(self, action: #selector(btnCheckUncheckClick(ExtraServiceCell:)), for: .touchUpInside)
            cell.btnInfo.addTarget(self, action: #selector(btnInfoClick(ExtraServiceCell:)), for: .touchUpInside)
            return cell
        }
        else{
            let cell = tableViewObjMinOrder.dequeueReusableCell(withIdentifier: "MiniOrderCell") as! MiniOrderCell
            cell.selectionStyle = .none
            cell.reloadData(dictionary: arrMinOrder[indexPath.row] as! NSDictionary)
            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewObj
        {
        }
    }
    
    @IBAction func btnCheckUncheckClick(ExtraServiceCell sender:UIButton)
    {
        let dic : NSMutableDictionary = NSMutableDictionary(dictionary: arrExtraServiceListing[sender.tag] as! NSDictionary)
        if dic.value(forKey: get_all_servicesResponce.values.is_selected) as! Bool == true
        {
            dic.setValue(false, forKey: get_all_servicesResponce.values.is_selected)
        }
        else{
            dic.setValue(true, forKey: get_all_servicesResponce.values.is_selected)
        }
        arrExtraServiceListing.replaceObject(at: sender.tag, with: dic)
        tableViewObj.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    @IBAction func btnInfoClick(ExtraServiceCell sender:UIButton)
    {
        showMyAlertView(message: "Place your donation items in a separate bag, and we will pick it up with your order. We have partnered with the Canadian Diabetes Association to receive all donations.") { (action) in }
    }
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension CleanMyClothesSecondVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        
        if reqTask == reqGetAllServices
        {
            Application_Delegate.showSpinnerView(isShow: false)
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
        else if reqTask == reqGetCheckPermission
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CleanMyClothesThreedVC") as! CleanMyClothesThreedVC
                        controller.dicCleanClothInfo = dicCleanClothInfo
                        controller.deliveryOptionDay = self.isDeliveryOptionSelected == 0 ? 2 : 1
                        controller.deliveryOptionHours = self.deliveryOptionHours
                        controller.isCheque = "\(resKeyData.value(forKey: "is_allow_check")!)"
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                }
                else
                {
                     Application_Delegate.showSpinnerView(isShow: false)
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message, completion: { (action) in
                            if statusCode == aouthStatus
                            {
                                Application_Delegate.processLogout()
                            }
                        })
                    }
                }
            }
        }
        else if reqTask == reqGetGlobal
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let responseKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        _ = ResponceKey_get_global.init(dic: responseKeyData)
                    }
                }
                else
                {
                    Application_Delegate.showSpinnerView(isShow: false)
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message, completion: { (action) in
                            if statusCode == aouthStatus
                            {
                                Application_Delegate.processLogout()
                            }
                        })
                    }
                }
            }
        }
    }
}
