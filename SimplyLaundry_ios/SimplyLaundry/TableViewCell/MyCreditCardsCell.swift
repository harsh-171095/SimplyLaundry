//
//  MyCreditCardsCell.swift
//  SimplyLaundry
//
//  Created by webclues on 12/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class MyCreditCardsCell: UITableViewCell {
    
    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    
    @IBOutlet weak var btnCheckUncheck:UIButton!
    
    //Card View Outlet's
    @IBOutlet weak var viewCardParent:UIView!
    @IBOutlet weak var imgCard:UIImageView!
    @IBOutlet weak var lblCardNumberTitle:UILabel!
    @IBOutlet weak var lblCardNumber:UILabel!
    @IBOutlet weak var lblValiDateTitle:UILabel!
    @IBOutlet weak var lblValiDate:UILabel!
    @IBOutlet weak var lblCardHolderName:UILabel!
    @IBOutlet weak var btnEdit:UIButton!
    @IBOutlet weak var lblSepratorVerical:UILabel!
    @IBOutlet weak var btnDelete:UIButton!
    @IBOutlet weak var consBtnEditTop: NSLayoutConstraint!
    
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
        self.viewParent.backgroundColor = COLOR.clear
        
        btnCheckUncheck.setTitle("", for: .normal)
        btnCheckUncheck.setImage(UIImage.init(named: ""), for: .normal)
        
        viewCardParent.backgroundColor = COLOR.clear
        viewCardParent.setCornerRadius(corner:5)
        
        lblCardNumberTitle.text = "Card Number"
        lblCardNumberTitle.textColor = COLOR.White
        lblCardNumberTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        
        lblCardNumber.text = ""
        lblCardNumber.textColor = COLOR.White
        lblCardNumber.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_EIGHTEEN)
        lblCardNumber.numberOfLines = 0
        lblCardNumber.lineBreakMode = .byWordWrapping
        
        lblValiDateTitle.text = "VALID\nTHRU"
        lblValiDateTitle.textColor = COLOR.White
        lblValiDateTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_TEN)
        lblValiDateTitle.numberOfLines = 0
        lblValiDateTitle.lineBreakMode = .byWordWrapping
        
        lblValiDate.text = ""
        lblValiDate.textColor = COLOR.White
        lblValiDate.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_EIGHTEEN)
        lblValiDate.numberOfLines = 1
        lblValiDate.lineBreakMode = .byWordWrapping

        lblCardHolderName.text = ""
        lblCardHolderName.textColor = COLOR.White
        lblCardHolderName.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_EIGHTEEN)
        lblCardHolderName.numberOfLines = 0
        lblCardHolderName.lineBreakMode = .byWordWrapping

        btnEdit.setTitle("REMOVE", for: .normal)
        btnEdit.setTitleColor(COLOR.Orange, for: .normal)
        btnEdit.titleLabel!.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        
        lblSepratorVerical.text = ""
        lblSepratorVerical.backgroundColor = COLOR.Gray.withAlphaComponent(0.5)
        lblSepratorVerical.isHidden = true
        
        btnDelete.setTitle("REMOVE", for: .normal)
        btnDelete.setTitleColor(COLOR.Orange, for: .normal)
        btnDelete.titleLabel!.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        btnDelete.isHidden = true
    }
    
    func reloadData(dictionary : NSDictionary)
    {
        btnCheckUncheck.setImage(UIImage.init(named: "radio_button"), for: .normal)
        lblCardNumber.text = setCardNumberSecure(cardNumber: "\(dictionary.value(forKey: ResponceKey_get_all_credit_card.dataValues.payment_card_no)!)")
        lblValiDate.text = "XX / XX"
        lblCardHolderName.text = "\(dictionary.value(forKey: ResponceKey_get_all_credit_card.dataValues.payment_cart_type)!)"
        
        if "\(dictionary.value(forKey: ResponceKey_get_all_credit_card.dataValues.is_default)!)" == "1"
        {
            btnCheckUncheck.setImage(UIImage.init(named: "radio_button_selected"), for: .normal)
            consBtnEditTop.constant = -25
            btnEdit.isHidden = true
        }
        else{
            consBtnEditTop.constant = 10
            btnEdit.isHidden = false
        }
    }
    
    func setCardNumberSecure(cardNumber number: String)-> String
    {
        let secureNumber : NSMutableString = "XXXX - XXXX - XXXX - "
        let startIndex = number.index(number.endIndex, offsetBy: -4)
        let endIndex = number.index(number.endIndex, offsetBy: 0)
        let stringIndex = startIndex..<endIndex
        print(number[stringIndex])
        secureNumber.append(String(number[stringIndex]))
        
        return secureNumber as String
    }
}
