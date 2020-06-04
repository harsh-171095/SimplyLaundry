//
//  MyCreditsCell.swift
//  SimplyLaundry
//
//  Created by webclues on 28/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class MyCreditsCell: UITableViewCell {
    
    
    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblSepratorVericalOne:UILabel!

    @IBOutlet weak var lblCreditTypeOne:UILabel!
    @IBOutlet weak var lblCreditTypeTwo:UILabel!
    @IBOutlet weak var lblSepratorVericalTwo:UILabel!
    
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var lblSepratorThree:UILabel!

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
        
        lblDate.setThemeForTitle( isTitle : false, numberOfLines: 0)
        lblDate.contentMode = .top
        
        lblSepratorVericalOne.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.2))
        
        lblCreditTypeOne.setThemeForTitle(numberOfLines: 0)
        lblCreditTypeTwo.setThemeForTitle( isTitle : false, numberOfLines: 0)
        
        lblSepratorVericalTwo.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.2))
        
        lblPrice.setThemeForTitle( isTitle : false, numberOfLines: 0)
        lblPrice.contentMode = .center
        lblPrice.textAlignment = .center
        
        lblSepratorThree.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.2))
        
    }
    
    
    //My Creadits Cell
    func reloadMyCardHeader()
    {
        viewParent.backgroundColor = COLOR.background_Gray
        lblDate.text = "Date"
        lblDate.textColor = COLOR.Balck
        lblDate.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        lblCreditTypeOne.text = "Credit Type"
        lblCreditTypeOne.textColor = COLOR.Balck
        lblCreditTypeOne.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        lblCreditTypeTwo.isHidden = true
        lblCreditTypeTwo.text = ""
        lblPrice.text = "Amount"
        lblPrice.textColor = COLOR.Balck
        lblPrice.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        lblSepratorThree.isHidden = true
    }
    
    func reloadMyCardData(dictionary:NSDictionary)
    {
        viewParent.backgroundColor = COLOR.White
//        if  date != "0000-00-00 00:00:00"
//        {
            lblDate.text = getDateFrom(string: "\(dictionary.value(forKey: ResponceKey_user_credit.credit_detail_values.date)!)", getDateFormate: "dd/MM/yyyy")
//        }
//        else{
//           lblDate.text = "12/01/2019"
//        }
        lblDate.textColor = COLOR.Gray
        lblCreditTypeOne.text = "\(dictionary.value(forKey: ResponceKey_user_credit.credit_detail_values.detail)!)"
        lblCreditTypeOne.textColor = COLOR.Gray
        lblCreditTypeTwo.text = "\(dictionary.value(forKey: ResponceKey_user_credit.credit_detail_values.type)!)"
        lblCreditTypeTwo.isHidden = false
        
        //Order Status = 1:Credit, 2:Dabit
        if "\(dictionary.value(forKey: ResponceKey_user_credit.credit_detail_values.transaction_type)!)" == ResponceKey_user_credit.values.credited
        {
            lblPrice.text = "+$\(dictionary.value(forKey: ResponceKey_user_credit.credit_detail_values.credits)!)"
            lblPrice.textColor = COLOR.KellyGreen
        }
        else
        {
            lblPrice.text = "-$\(dictionary.value(forKey: ResponceKey_user_credit.credit_detail_values.credits)!)"
            lblPrice.textColor = COLOR.Orange
        }
        
        // ResponceKey_get_gift_card.giftCardStatus.cancelByAdmin
        if "\(dictionary.value(forKey: ResponceKey_user_credit.credit_detail_values.gift_card_cancel_admin)!)" == "1"
        {
            let attributedStr = NSMutableAttributedString(string: "\(dictionary.value(forKey: ResponceKey_user_credit.credit_detail_values.type)!)" , attributes:[NSAttributedString.Key.font : UIFont(name: SourceSansPro_Semibold , size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
            let attributedStr1 = NSMutableAttributedString(string: "\nCancel" , attributes:[NSAttributedString.Key.font : UIFont(name: SourceSansPro_Semibold , size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Orange])
            attributedStr.append(attributedStr1)
            
           lblCreditTypeTwo.attributedText = attributedStr
        }
        else if "\(dictionary.value(forKey: ResponceKey_user_credit.credit_detail_values.gift_card_cancel_admin)!)" == ResponceKey_get_gift_card.giftCardStatus.cancelByUser
        {
            let attributedStr = NSMutableAttributedString(string: "\(dictionary.value(forKey: ResponceKey_user_credit.credit_detail_values.type)!)" , attributes:[NSAttributedString.Key.font : UIFont(name: SourceSansPro_Semibold , size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
            let attributedStr1 = NSMutableAttributedString(string: "\nCancel" , attributes:[NSAttributedString.Key.font : UIFont(name: SourceSansPro_Semibold , size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Orange])
            attributedStr.append(attributedStr1)

            lblCreditTypeTwo.attributedText = attributedStr
        }
        lblSepratorThree.backgroundColor = COLOR.Gray.withAlphaComponent(0.2)
        lblSepratorThree.isHidden = false
    }
    
}
