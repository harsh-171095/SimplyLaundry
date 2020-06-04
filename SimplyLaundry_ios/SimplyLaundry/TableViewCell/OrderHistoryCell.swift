//
//  OrderHistory.swift
//  SimplyLaundry
//
//  Created by webclues on 03/01/19.
//  Copyright © 2019 webclues. All rights reserved.

import UIKit

class OrderHistoryCell: UITableViewCell {

    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    
    @IBOutlet weak var lblCircle:UILabel!
    @IBOutlet weak var lblAddedDate:UILabel!
    @IBOutlet weak var btnCancelOrder:UIButton!
    @IBOutlet weak var btnDuplicateOrder:UIButton!
    
    //Order Details View Outlet's
    @IBOutlet weak var viewOrderDetails:UIView!
    
    @IBOutlet weak var lblStatusTitle:UILabel!
    @IBOutlet weak var lblStatus:UILabel!
    @IBOutlet weak var lblSepratorOne:UILabel!
    
    @IBOutlet weak var lblOrderIDTitle:UILabel!
    @IBOutlet weak var lblOrderID:UILabel!
    @IBOutlet weak var lblSepratorTwo:UILabel!

    @IBOutlet weak var lblPickupDateTitle:UILabel!
    @IBOutlet weak var lblPickupDate:UILabel!
    @IBOutlet weak var lblPickupTimeTitle:UILabel!
    @IBOutlet weak var lblPickupTime:UILabel!
    @IBOutlet weak var lblSepratorThree:UILabel!

    @IBOutlet weak var lblDropoffDateTitle:UILabel!
    @IBOutlet weak var lblDropoffDate:UILabel!
    @IBOutlet weak var lblDropoffTimeTitle:UILabel!
    @IBOutlet weak var lblDropoffTime:UILabel!
    @IBOutlet weak var lblSepratorFour:UILabel!

    @IBOutlet weak var lblTotalOrderPriceTitle:UILabel!
    @IBOutlet weak var lblTotalOrderPrice:UILabel!
    @IBOutlet weak var lblSepratorFive:UILabel!
    
    @IBOutlet weak var viewOrderRepeat:UIView!
    @IBOutlet weak var lblSepratorRepeatOrder:UILabel!
    @IBOutlet weak var lblRepeatOrderTitle:UILabel!
    @IBOutlet weak var lblRepeatOrder:UILabel!
    @IBOutlet weak var consHeightRepeatOrder: NSLayoutConstraint!
    
    @IBOutlet weak var viewButton:UIView!
    @IBOutlet weak var consHeightViewButtons: NSLayoutConstraint!
    @IBOutlet weak var consBottomViewButtons: NSLayoutConstraint!
    @IBOutlet weak var btnOne:UIButton!
    @IBOutlet weak var btnTwo:UIButton!
    
    // Table View Cell Initialization Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
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
        self.backgroundColor = COLOR.clear
        
        //set Parent View Theme
        self.viewParent.backgroundColor = COLOR.clear

        lblCircle.text = ""
        lblCircle.backgroundColor = COLOR.Blue
        lblCircle.setCornerRadius()
        
        lblAddedDate.text = ""
        
        viewOrderDetails.backgroundColor = COLOR.background_Gray
        viewOrderDetails.setCornerRadius(corner:5)
        
        btnCancelOrder.setThemeForOrderHistory("CANCEL ORDER", backgroundColor : COLOR.Orange)
        btnCancelOrder.isHidden = true
        
        btnDuplicateOrder.setThemeForOrderHistory("", backgroundColor : COLOR.Green)
        
        lblStatusTitle.setThemeForTitle("Status:", titleFontName : SourceSansPro_Semibold)
        lblStatus.setThemeForTitle(isTitle : false)
        
        lblSepratorOne.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.5))
        
        lblOrderIDTitle.setThemeForTitle("Order ID:", titleFontName : SourceSansPro_Semibold)
        lblOrderID.setThemeForTitle(isTitle : false)
        
        lblSepratorTwo.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.5))
        
        lblPickupDateTitle.setThemeForTitle("Pickup Date:", titleFontName : SourceSansPro_Semibold)
        lblPickupDate.setThemeForTitle(isTitle : false)
        
        lblPickupTimeTitle.setThemeForTitle("Pickup Time:", titleFontName : SourceSansPro_Semibold)
        lblPickupTime.setThemeForTitle(isTitle : false)
        
        lblSepratorThree.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.5))
        
        lblDropoffDateTitle.setThemeForTitle("Drop-Off Date:", titleFontName : SourceSansPro_Semibold)
        lblDropoffDate.setThemeForTitle(isTitle : false)
        
        lblDropoffTimeTitle.setThemeForTitle("Drop-Off Time:", titleFontName : SourceSansPro_Semibold)
        lblDropoffTime.setThemeForTitle(isTitle : false)
        
        lblSepratorFour.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.5))
        
        lblTotalOrderPriceTitle.setThemeForTitle("Total Order:", titleFontName : SourceSansPro_Semibold)
        lblTotalOrderPrice.setThemeForTitle(isTitle : false)
        
        lblSepratorFour.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.5))
        
        self.viewOrderRepeat.backgroundColor = COLOR.clear
        
        lblRepeatOrderTitle.setThemeForTitle("Order Repeat", titleFontName : SourceSansPro_Semibold)
        lblRepeatOrder.setThemeForTitle(isTitle : false)
        
        lblSepratorRepeatOrder.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.5))
        
        self.viewButton.backgroundColor = COLOR.clear
        
        btnOne.setThemeForOrderHistory("CANCEL ORDER", backgroundColor : COLOR.reOrderBlue)
        btnOne.isHidden = true
        
        btnTwo.setThemeForOrderHistory("", backgroundColor : COLOR.SkyBlue)
        btnTwo.isHidden = true
    }
    
    func reloadData(dictionary:NSDictionary)
    {
        // Cancel Order Status
        checkCancelOrder(status: "\(dictionary.value(forKey: ResponceKey_order_data.cancel_order_status)!)")

        let strAddedDate : String = getDateFrom(string: "\(dictionary.value(forKey: ResponceKey_order_data.created_on)!)"
                ,fromDateFormate: "dd-MM-yyyy" , getDateFormate: "dd/MM/yyyy")
       
        if  "\(dictionary.value(forKey: ResponceKey_order_data.pickup_date)!)" != "0000-00-00"
        {
            let strPickupDate : String = getDateFrom(string: "\(dictionary.value(forKey: ResponceKey_order_data.pickup_date)!)",
                fromDateFormate: "yyyy-MM-dd",
                getDateFormate: "dd/MM/yyyy")
            lblPickupDate.text = "\(strPickupDate)"
        }
        if  "\(dictionary.value(forKey: ResponceKey_order_data.delivery_date)!)" != "0000-00-00"
        {
            let strDropoffDate : String = getDateFrom(string: "\(dictionary.value(forKey: ResponceKey_order_data.delivery_date)!)",
                fromDateFormate: "yyyy-MM-dd",
                getDateFormate: "dd/MM/yyyy")
            lblDropoffDate.text = "\(strDropoffDate)"
        }
        
        let attributedStr = NSMutableAttributedString(string: "Date Added: " , attributes:[NSAttributedString.Key.font : UIFont(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Balck])
        let attributedStr1 = NSMutableAttributedString(string: "\(strAddedDate)" , attributes:[NSAttributedString.Key.font : UIFont(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
        attributedStr.append(attributedStr1)
        lblAddedDate.attributedText = attributedStr
        if dictionary.value(forKey: ResponceKey_order_data.display_order_id) != nil{
            lblOrderID.text = "\(dictionary.value(forKey: ResponceKey_order_data.display_order_id)!)"
        }
        else{
            lblOrderID.text = "#\(dictionary.value(forKey: ResponceKey_order_data.order_id)!)"
        }
        
        lblPickupTime.text = "\(dictionary.value(forKey: ResponceKey_order_data.pickup_time)!)"
        
        lblDropoffTime.text = "\(dictionary.value(forKey: ResponceKey_order_data.delivery_time)!)"
        lblTotalOrderPrice.text = "\(dictionary.value(forKey: ResponceKey_order_data.order_total)!)"
        lblStatus.text = "\(dictionary.value(forKey: ResponceKey_order_data.order_status)!)"

        if "\(dictionary.value(forKey: ResponceKey_order_data.is_repeat)!)" == "0" // No-Repeat Order
        {
            viewButton.isHidden = false
            btnOne.isHidden = false
            btnOne.setTitle("REPEAT ORDER", for: .normal)
            btnOne.backgroundColor = COLOR.reOrderBlue
            btnTwo.isHidden = true
            btnTwo.setTitle("", for: .normal)
        }
        else if "\(dictionary.value(forKey: ResponceKey_order_data.is_repeat)!)" == "1" // Repeat Order
        {
            viewButton.isHidden = false
            btnOne.isHidden = false
            btnOne.setTitle("PAUSE REPEAT ORDER", for: .normal)
            btnOne.backgroundColor = COLOR.yellow
            btnTwo.isHidden = false
            btnTwo.setTitle("CANCEL REPEAT ORDER", for: .normal)
        }
        else if "\(dictionary.value(forKey: ResponceKey_order_data.is_repeat)!)" == "2" // Pause Repeat Order
        {
            viewButton.isHidden = false
            btnOne.isHidden = false
            btnOne.setTitle("START REPEAT ORDER", for: .normal)
            btnOne.backgroundColor = COLOR.KellyGreen
            btnTwo.isHidden = false
            btnTwo.setTitle("CANCEL REPEAT ORDER", for: .normal)
        }
        setStatusColor(status: "\(dictionary.value(forKey: ResponceKey_order_data.slug)!)")

        if "\(dictionary.value(forKey: ResponceKey_order_data.is_repeat_order_type)!)" == "0" || "\(dictionary.value(forKey: ResponceKey_order_data.is_repeat_order_type)!)" == ""
        {
            viewOrderRepeat.isHidden = true
            consHeightRepeatOrder.constant = 0
        }
        else
        {
            viewOrderRepeat.isHidden = false
            consHeightRepeatOrder.constant = 45
            
            if "\(dictionary.value(forKey: ResponceKey_order_data.is_repeat_order_type)!)" == "1"
            {
                lblRepeatOrder.text = "Every Week"
            }
            else if "\(dictionary.value(forKey: ResponceKey_order_data.is_repeat_order_type)!)" == "2"
            {
                lblRepeatOrder.text = "Every 2 Week"
            }
            else if "\(dictionary.value(forKey: ResponceKey_order_data.is_repeat_order_type)!)" == "3"
            {
                lblRepeatOrder.text = "Every Month"
            }
        }
    }
    //MARK:- Set Status Color
    func setStatusColor(status : String)
    {
        if status == ResponceKey_order_data.slug_values.order_received || status == ResponceKey_order_data.slug_values.picked_up || status == ResponceKey_order_data.slug_values.pickedup_successful
        {
            lblStatus.textColor = COLOR.statusBlue
        }
        else if status == ResponceKey_order_data.slug_values.processing || status == ResponceKey_order_data.slug_values.being_cleaned || status == ResponceKey_order_data.slug_values.processed
        {
            lblStatus.textColor = COLOR.yellow
        }
        else if status == ResponceKey_order_data.slug_values.delivered || status == ResponceKey_order_data.slug_values.delivered_successful
        {
            lblStatus.textColor = COLOR.KellyGreen
            btnCancelOrder.isHidden = true
        }
        else if status == ResponceKey_order_data.slug_values.cancelled
        {
            lblStatus.textColor = COLOR.Orange
            btnCancelOrder.isHidden = true
        }
        else if status == ResponceKey_order_data.slug_values.refunded
        {
            lblStatus.textColor = COLOR.statusYellow
            btnCancelOrder.isHidden = true
        }
        else if status == ResponceKey_order_data.slug_values.complete
        {
            lblStatus.textColor = COLOR.Green
            btnCancelOrder.isHidden = true
        }
        
        
        if status != ResponceKey_order_data.slug_values.order_received
        {
            btnCancelOrder.isHidden = true
        }
    }
    // Set Cancel Order Status 
    func checkCancelOrder(status:String)
    {
        if status == "0" // Cancel Order
        {
            btnCancelOrder.isHidden = true
            viewButton.isHidden = true
            consBottomViewButtons.constant = 0
            consHeightViewButtons.constant = 0
        }
        else
        {
            btnCancelOrder.isHidden = false
            consHeightViewButtons.constant = 40
            consBottomViewButtons.constant = 10
        }
    }
}
