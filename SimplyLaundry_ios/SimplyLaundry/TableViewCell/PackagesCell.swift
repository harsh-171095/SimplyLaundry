//
//  PackagesCell.swift
//  SimplyLaundry
//
//  Created by webclues on 29/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class PackagesCell: UITableViewCell {

    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //Content View Outlet's
    @IBOutlet weak var viewContent:UIView!
    
    //Title View Outlet's
    @IBOutlet weak var viewTitle:UIView!
    @IBOutlet weak var lblServices:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var conslblPriceTraling: NSLayoutConstraint!
    @IBOutlet weak var lblDescription:UILabel!
    
    //Submit button
    @IBOutlet weak var btnSubmit:UIButton!
    @IBOutlet weak var lblButtonCircle:UILabel!
    @IBOutlet weak var consBtnSubmitTop: NSLayoutConstraint! // Constraint: set 20 for Show and When hide set -45

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
        viewParent.backgroundColor = COLOR.clear
        viewContent.backgroundColor = COLOR.background_Gray
        viewContent.setCornerRadius(corner:5)
        viewTitle.backgroundColor = COLOR.Green
        
        lblTitle.setThemeForTitle()

        lblServices.setThemeForTitle(isTitle : false, numberOfLines : 0)
        lblServices.textAlignment = .left

        lblPrice.setThemeForTitle(isTitle : false, numberOfLines : 0)
        lblPrice.textAlignment = .right
        
        lblDescription.setThemeForTitle(isTitle : false, numberOfLines : 0)
 
        btnSubmit.setThemeForAppButton("BUY")

        lblButtonCircle.text = ""
        lblButtonCircle.backgroundColor = COLOR.White
        lblButtonCircle.setCornerRadius()
    }

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
                    price.append("-")
                }
                else{
                    price.append("$\((array[i] as! NSDictionary).value(forKey: ResponceKey_get_packages.package_price_value.price)!)/lb")
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
        lblTitle.textColor = COLOR.White
        lblDescription.text = "\(dictionary.value(forKey: ResponceKey_get_packages.package_description)!)"
        
        btnSubmit.setTitle("BUY @ $\(dictionary.value(forKey: ResponceKey_get_packages.package_amount)!)/MONTH RECURRING    ", for: .normal)
        if "\(dictionary.value(forKey: ResponceKey_get_packages.is_active_package)!)" == "1"
        {
            consBtnSubmitTop.constant = -45
            btnSubmit.isHidden = true
            lblButtonCircle.isHidden = true
        }
        else{
            consBtnSubmitTop.constant = 20
            btnSubmit.isHidden = false
            lblButtonCircle.isHidden = false
        }
    }
    
    func reloadGiftCard(dictionary: NSDictionary,isSend:Int)
    {
        lblPrice.textAlignment = .left
        let strDate = getDateFrom(string: "\(dictionary.value(forKey: ResponceKey_get_gift_card.values.created_on)!)", getDateFormate: "dd/MM/YYYY")
        conslblPriceTraling.priority = UILayoutPriority(rawValue: 250)
        if isSend == 0
        {
            lblDescription.text = "\(dictionary.value(forKey: ResponceKey_get_gift_card.values.add_note)!)"
            lblTitle.text = "\(dictionary.value(forKey: ResponceKey_get_gift_card.values.referee_name)!) (\(dictionary.value(forKey: ResponceKey_get_gift_card.values.referee_email)!))"
            lblServices.text = "Date \nReferral \nAmount "
            lblPrice.text = ": \(strDate)\n: \(dictionary.value(forKey: ResponceKey_get_gift_card.values.referral_name)!)\n: $\(dictionary.value(forKey: ResponceKey_get_gift_card.values.amount)!) "
            btnSubmit.setTitle("CANCEL", for: .normal)
            if "\(dictionary.value(forKey: ResponceKey_get_gift_card.values.is_registered)!)" == ResponceKey_get_gift_card.giftCardStatus.notRedeem
            {
                consBtnSubmitTop.constant = 20
                btnSubmit.isHidden = false
                lblButtonCircle.isHidden = false
            }
            else{
                consBtnSubmitTop.constant = -55
                btnSubmit.isHidden = true
                lblButtonCircle.isHidden = true
            }
            btnSubmit.backgroundColor = COLOR.Blue
        }
        else{
            lblTitle.text = "\(dictionary.value(forKey: ResponceKey_get_gift_card.values.referral_name)!)"
            lblServices.text = "Date \nAmount "
            lblPrice.text = ": \(strDate)\n: $\(dictionary.value(forKey: ResponceKey_get_gift_card.values.amount)!) "
            lblDescription.text = "\(dictionary.value(forKey: ResponceKey_get_gift_card.values.add_note)!)"
            if "\(dictionary.value(forKey: ResponceKey_get_gift_card.values.is_registered)!)" == ResponceKey_get_gift_card.giftCardStatus.notRedeem
            {
                consBtnSubmitTop.constant = 20
                btnSubmit.isHidden = false
                lblButtonCircle.isHidden = false
                btnSubmit.setTitle("REDEEM", for: .normal)
                btnSubmit.isUserInteractionEnabled = true
                btnSubmit.backgroundColor = COLOR.Blue
            }
            else if "\(dictionary.value(forKey: ResponceKey_get_gift_card.values.is_registered)!)" == ResponceKey_get_gift_card.giftCardStatus.cancelByAdmin || "\(dictionary.value(forKey: ResponceKey_get_gift_card.values.is_registered)!)" == ResponceKey_get_gift_card.giftCardStatus.cancelByUser
            {
                consBtnSubmitTop.constant = -55
                btnSubmit.isHidden = true
                lblButtonCircle.isHidden = true
                
                let attributedStr = NSMutableAttributedString(string: "\(dictionary.value(forKey: ResponceKey_get_gift_card.values.add_note)!)" , attributes:[NSAttributedString.Key.font : UIFont(name: SourceSansPro_Semibold , size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
                let attributedStr1 = NSMutableAttributedString(string: "\n\nThis gift card is cancel" , attributes:[NSAttributedString.Key.font : UIFont(name: SourceSansPro_Semibold , size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Orange])
                attributedStr.append(attributedStr1)
                
                lblDescription.attributedText = attributedStr
            }
            else{
                consBtnSubmitTop.constant = -55
                btnSubmit.isHidden = true
                lblButtonCircle.isHidden = true
            }
        }
        
        
    }
}
