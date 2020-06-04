//
//  SuccessOrderVC.swift
//  SimplyLaundry
//
//  Created by webclues on 07/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class SuccessOrderVC: UIViewController {
    
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
    
    @IBOutlet weak var viewSuccessParent:UIView!
    @IBOutlet weak var imgSuccess:UIImageView!
    @IBOutlet weak var lblSuccessTitle:UILabel!
    @IBOutlet weak var lblSuccessMessage:UILabel!
    @IBOutlet weak var txtSuccessMessage:UITextView!
    
    @IBOutlet weak var viewOrderIdAndDate:UIView!
    @IBOutlet weak var lblOrderID:UILabel!
    @IBOutlet weak var lblOrderDate:UILabel!
    
    @IBOutlet weak var viewOrderDetails:UIView!
    @IBOutlet weak var lblPaymentMethodTitle:UILabel!
    @IBOutlet weak var lblPaymentMethod:UILabel!
    
    @IBOutlet weak var lblDriverTipTitle:UILabel!
    @IBOutlet weak var lblDriverTip:UILabel!
    
    @IBOutlet weak var lblPickupDateTitle:UILabel!
    @IBOutlet weak var lblPickupDate:UILabel!
    @IBOutlet weak var lblPickupTimeTitle:UILabel!
    @IBOutlet weak var lblPickupTime:UILabel!
    
    @IBOutlet weak var lblDropoffDateTitle:UILabel!
    @IBOutlet weak var lblDropoffDate:UILabel!
    @IBOutlet weak var lblDropoffTimeTitle:UILabel!
    @IBOutlet weak var lblDropoffTime:UILabel!
    
    @IBOutlet weak var viewPickupAddressParent:UIView!
    @IBOutlet weak var lblPickupAddressTitle:UILabel!
    @IBOutlet weak var lblPickupAddress:UILabel!
    @IBOutlet weak var consViewPickupAddressParentTop: NSLayoutConstraint!
    
    @IBOutlet weak var viewDeliveryAddressParent:UIView!
    @IBOutlet weak var lblDeliveryAddressTitle:UILabel!
    @IBOutlet weak var lblDeliveryAddressTwo:UILabel!

    @IBOutlet weak var viewServiceParent:UIView!
    @IBOutlet weak var lblServiceTitle:UILabel!
    @IBOutlet weak var tableViewObjService:UITableView!
    @IBOutlet weak var consTableViewObjServiceHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewSpecialInstructionsParent:UIView!
    @IBOutlet weak var lblSpecialInstructionsTitle:UILabel!
    @IBOutlet weak var lblSpecialInstructions:UILabel!
    @IBOutlet weak var consViewSpecialInstructionsTop: NSLayoutConstraint!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewButtonCircle: UIView!
    
    // Variable Declarations and Initlizations
    var dicOrderDetails :NSDictionary = NSDictionary()
    var arrServiceListing = NSArray()
    
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
        //Set Theme For Safeview And Parent View And It's Outlet's
        self.view.addGradientsWithTwoColor()
        viewParent.backgroundColor = COLOR.White
        
        //Set Theme For Header View And It's Outlet's
        viewHeader.backgroundColor = COLOR.Green
        
        imgBackground.image = UIImage.init(named: "header_bg")
        
        lblVCTitle.setVCTitle("Clean My Clothes")
        
        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        btnManu.isHidden = true

        //Set Theme For Content View And It's Outlet's
        scrollContent.setThemeForScrollView()
        viewContent.backgroundColor = COLOR.White
        
        //Set Theme For Success Order View And It's Outlet's
        viewSuccessParent.backgroundColor = COLOR.White
        
        imgSuccess.image = nil
        
        lblSuccessTitle.text = ""
        lblSuccessTitle.textColor = COLOR.Gray
        lblSuccessTitle.font = UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_EIGHTEEN)
        lblSuccessTitle.textAlignment = .center
        lblSuccessTitle.numberOfLines = 0
        lblSuccessTitle.lineBreakMode = .byWordWrapping
        
        txtSuccessMessage.text = ""
        txtSuccessMessage.contentInsetAdjustmentBehavior = .always
        txtSuccessMessage.dataDetectorTypes = .link
        txtSuccessMessage.delegate = self
        txtSuccessMessage.isScrollEnabled = false
        txtSuccessMessage.isEditable = false
        txtSuccessMessage.isSelectable = true
        txtSuccessMessage.textAlignment = .center

        // Set Theme For Order ID And Order Date View And It's Outlet's
        viewOrderIdAndDate.backgroundColor = COLOR.background_Gray
        lblOrderID.text = " "
        lblOrderID.font = UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_FOURTEEN)
        lblOrderDate.text = " "
        lblOrderDate.font = UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_FOURTEEN)

        //Set Theme Order Details View And It's Outlet's
        viewOrderDetails.backgroundColor = COLOR.White
        
        lblPaymentMethodTitle.setThemeForTitle("Payment Method:")
        lblPaymentMethod.setThemeForTitle(isTitle : false)

        lblDriverTipTitle.setThemeForTitle("Driver's Tip:")
        lblDriverTip.setThemeForTitle(isTitle : false)

        lblPickupDateTitle.setThemeForTitle("Pickup Date:")
        lblPickupDate.setThemeForTitle(isTitle : false)
        
        lblPickupTimeTitle.setThemeForTitle("Pickup Time:")
        lblPickupTime.setThemeForTitle(isTitle : false)
        
        lblDropoffDateTitle.setThemeForTitle("Drop-Off Date:")
        lblDropoffDate.setThemeForTitle(isTitle : false)
        
        lblDropoffTimeTitle.setThemeForTitle("Drop-Off Time:")
        lblDropoffTime.setThemeForTitle(isTitle : false)
        
        //Set Theme Paymen And Delivery Address View And It's Outlet's
        viewPickupAddressParent.backgroundColor = COLOR.White
        lblPickupAddressTitle.setThemeForUnderlineTitle("Pickup Address")
        lblPickupAddress.setThemeForTitle(numberOfLines : 0)

        viewDeliveryAddressParent.backgroundColor = COLOR.White
        lblDeliveryAddressTitle.setThemeForUnderlineTitle("Delivery Address")
        lblDeliveryAddressTwo.setThemeForTitle(numberOfLines : 0)
        
        //Set Theme For Service View And It's Outlet's
        lblServiceTitle.setThemeForUnderlineTitle("Services")
        tableViewObjService.register(UINib(nibName: "ServicesCell", bundle: nil), forCellReuseIdentifier: "ServicesCell")
        tableViewObjService.separatorStyle = .none
        tableViewObjService.delegate = self
        tableViewObjService.dataSource = self
        tableViewObjService.backgroundColor = COLOR.White
        tableViewObjService.isScrollEnabled = false
        
        //Set Theme Special Instructions View And It's Outlet's
        lblSpecialInstructionsTitle.setThemeForUnderlineTitle("Special Instructions")
        lblSpecialInstructions.setThemeForTitle(numberOfLines : 0)
        
        btnNext.setThemeForAppButton("CONTINUE")
        btnNext.addTarget(self, action: #selector(btnNextClick(_:)), for: .touchUpInside)
        viewButtonCircle.backgroundColor = COLOR.White
        viewButtonCircle.setCornerRadius(corner: viewButtonCircle.frame.height / 2)

        reloadData(dictionary:dicOrderDetails)
        
        RateForApplication.instance.openAlertForRate()
    }
    
    /*
     Function Name :- setDataAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set the data for Controller initial screen values
     */
    func setDataOfViewController()
    {
        arrServiceListing = { () -> NSArray in
            let service : String = "\(dicOrderDetails.value(forKey: ResponceKey_success_order.service)!)"
            let split = service.split(separator: ",")
            let array : NSMutableArray = NSMutableArray()
            for i in 0..<split.count
            {
                let dic : [String:Any] = ["title":split[i]]
                array.add(dic)
            }
            return array
        }()
        
        Application_Delegate.showSpinnerView(isShow: false)
        tableViewObjService.isHidden = false
        tableViewObjService.reloadData()
        
        callMethodAfterDelay(funcName: #selector(setTableViewHeight))
    }
    
    /*
     Function Name :- reloadData
     Function Parameters :- (dictionary:NSDictionary)
     Function Description :- Set a success values in outlet's
     */
    func reloadData(dictionary:NSDictionary)
    {
        //Set Data For Success View
        setDataOfViewController()
        imgSuccess.image = UIImage.init(named: "success")
        lblSuccessTitle.text = "Your Order Has been Placed!"
        
        // Set Hiperlink on TextView
        
        let attributedSuccessMessage = NSMutableAttributedString(string: "Your order has beed successfully processed! \n You can view your order history by going to the " , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
        let attributedSuccessMessage1 = NSMutableAttributedString(string: "@My Account@" , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FIFTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Blue_light])
        let attributedSuccessMessage2 = NSMutableAttributedString(string: " page and by clicking " , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
        let attributedSuccessMessage3 = NSMutableAttributedString(string: "@My Order@" , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FIFTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Blue_light])
        let attributedSuccessMessage4 = NSMutableAttributedString(string: "\n Set " , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
        let attributedSuccessMessage5 = NSMutableAttributedString(string: "@repeat order@" , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FIFTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Blue_light])
        let attributedSuccessMessage6 = NSMutableAttributedString(string: " and forget about it!" , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
        attributedSuccessMessage.append(attributedSuccessMessage1)
        attributedSuccessMessage.append(attributedSuccessMessage2)
        attributedSuccessMessage.append(attributedSuccessMessage3)
        attributedSuccessMessage.append(attributedSuccessMessage4)
        attributedSuccessMessage.append(attributedSuccessMessage5)
        attributedSuccessMessage.append(attributedSuccessMessage6)
        
        txtSuccessMessage.attributedText = attributedSuccessMessage
            .replace(placeholder: "@My Account@", with: "My Account", url: "http://myAccount.com")
            .replace(placeholder: "@My Order@", with: "My Order", url: "http://myOrder.com")
            .replace(placeholder: "@repeat order@", with: "repeat order", url: "http://RepeatOrder.com")
        txtSuccessMessage.linkTextAttributes = [NSAttributedString.Key.foregroundColor : COLOR.Blue_light]
        txtSuccessMessage.textAlignment = .center
        //Set Attributed Order ID
        let attributedStrOrderID = NSMutableAttributedString(string: "Order ID : " ,
                                                             attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Balck])
        let attributedStrOrderID1 = NSMutableAttributedString(string: "\(dicOrderDetails.value(forKey: ResponceKey_success_order.display_order_id)!)" ,
                                                              attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
        attributedStrOrderID.append(attributedStrOrderID1)
        lblOrderID.attributedText = attributedStrOrderID
    
        //Set Attributed Order Date
        let attributedStr = NSMutableAttributedString(string: "Date Added : " ,
                                                      attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Balck])
        let order_date : String = getDateFrom(string: "\(dicOrderDetails.value(forKey: ResponceKey_success_order.created_on)!)",
                                                getDateFormate: "dd/MM/yyyy")
        let attributedStr1 = NSMutableAttributedString(string: order_date ,
                                                       attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
        attributedStr.append(attributedStr1)
        lblOrderDate.attributedText = attributedStr
        
        lblPaymentMethod.text = "\(dicOrderDetails.value(forKey: ResponceKey_success_order.payment_method)!)"
        lblDriverTip.text = "\(dicOrderDetails.value(forKey: ResponceKey_success_order.tip_percentage)!)%"
        
        let strPickupDate : String = getDateFrom(string: "\(dicOrderDetails.value(forKey: ResponceKey_success_order.pickup_date)!)",
                                                    fromDateFormate: "yyyy-MM-dd",
                                                    getDateFormate: "dd/MM/yyyy")
        lblPickupDate.text = strPickupDate
        lblPickupTime.text = "\(dicOrderDetails.value(forKey: ResponceKey_success_order.pickup_time)!)"
        
        let strDropoffDate : String = getDateFrom(string: "\(dicOrderDetails.value(forKey: ResponceKey_success_order.delivery_date)!)",
            fromDateFormate: "yyyy-MM-dd",
            getDateFormate: "dd/MM/yyyy")
        lblDropoffDate.text = strDropoffDate
        lblDropoffTime.text = "\(dicOrderDetails.value(forKey: ResponceKey_success_order.delivery_time)!)"

        lblPickupAddress.text = { () -> String in
            let string = "\(dictionary.value(forKey: ResponceKey_success_order.pickup_address)!)".split(separator: ",")
            
            var myAddress = "\(dictionary.value(forKey: ResponceKey_success_order.display_name)!)\n"
            for address in string
            {
                if address == string[string.count - 3]
                {
                    myAddress.append("\n\(address)")
                }
                else if address == string[string.count - 2]
                {
                    myAddress.append(",\(address)")
                }
                else if address == string[string.count - 1]
                {
                    myAddress.append(",\(address)")
                }
                else{
                    if address == string.first
                    {
                        myAddress.append("\(address)")
                    }
                    else{
                        myAddress.append(", \(address)")
                    }
                    
                }
            }
            
            return myAddress
        }()
        
        lblDeliveryAddressTwo.text = { () -> String in
            let string = "\(dictionary.value(forKey: ResponceKey_success_order.delivery_address)!)".split(separator: ",")
            
            var myAddress = "\(dictionary.value(forKey: ResponceKey_success_order.display_name)!)\n"
            for address in string
            {
                if address == string[string.count - 3]
                {
                    myAddress.append("\n\(address)")
                }
                else if address == string[string.count - 2]
                {
                    myAddress.append(",\(address)")
                }
                else if address == string[string.count - 1]
                {
                    myAddress.append(",\(address)")
                }
                else{
                    if address == string.first
                    {
                        myAddress.append("\(address)")
                    }
                    else{
                        myAddress.append(", \(address)")
                    }
                    
                }
            }
            
            return myAddress
        }()
        
        if "\(dictionary.value(forKey: ResponceKey_success_order.delivery_address_id)!)" == "\(dictionary.value(forKey: ResponceKey_success_order.pickup_address_id)!)"
        {
            consViewPickupAddressParentTop.constant = -(viewPickupAddressParent.bounds.height + 20)
            viewPickupAddressParent.isHidden = true
            lblDeliveryAddressTitle.attributedText = NSAttributedString(string: "Pickup/Delivery Address", attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor : COLOR.Blue])
        }
        else{
            consViewPickupAddressParentTop.constant = 5
            viewPickupAddressParent.isHidden = false
        }
        
        if "\(dictionary.value(forKey: ResponceKey_order_data.special_instructions)!)" == ""
        {
            consViewSpecialInstructionsTop.constant = -(viewSpecialInstructionsParent.frame.height)
            viewSpecialInstructionsParent.isHidden = true
        }
        else{
            consViewSpecialInstructionsTop.constant = 10
            viewSpecialInstructionsParent.isHidden = false
        }
        
        lblSpecialInstructions.text = "\(dicOrderDetails.value(forKey: ResponceKey_success_order.special_instructions)!)"

        Application_Delegate.showSpinnerView(isShow: false)
    }
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }
    
    @IBAction func btnNextClick(_ sender: Any)
    {
//        self.goBackToViewController(ViewController: CleanMyClothesFirstVC.self)
        let controller = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "OrderHistoryVC") as! OrderHistoryVC
        Application_Delegate.navigationController.pushViewController(controller, animated: false)
    }

    @objc func setTableViewHeight()
    {
        consTableViewObjServiceHeight.constant = tableViewObjService.contentSize.height
        Application_Delegate.showSpinnerView(isShow: false)
    }
    
}
/*
 Extension Description :- Delegate method for table view.
 */
extension SuccessOrderVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrServiceListing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewObjService.dequeueReusableCell(withIdentifier: "ServicesCell") as! ServicesCell
        cell.selectionStyle = .none
        cell.reloadData(dictionary: arrServiceListing[indexPath.row] as! NSDictionary)
        return cell
    }
}
/*
 Extension Description :- Delegate methods for the UITextView
 */
extension SuccessOrderVC : UITextViewDelegate
{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        print("URL:- \(URL) \n Absolute String:- \(URL.absoluteString)")
        if (URL.absoluteString == "http://myAccount.com") {
            sideMenuController?.toggle()
        }
        else if (URL.absoluteString == "http://myOrder.com") {
            let controller = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "OrderHistoryVC") as! OrderHistoryVC
            Application_Delegate.navigationController.pushViewController(controller, animated: false)
        }
        else if (URL.absoluteString == "http://RepeatOrder.com") {
            let controller = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "OrderHistoryVC") as! OrderHistoryVC
            Application_Delegate.navigationController.pushViewController(controller, animated: false)
        }
        return false
    }
}
