//
//  PriceListCell.swift
//  SimplyLaundry
//
//  Created by webclues on 03/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class PriceListCell: UITableViewCell {

    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
   
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var lblSepratior:UILabel!
    
    //Variables Declarations and initialization
    
    // Table View Cell Initialization Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setTheme()
        // Initialization code
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
        
        lblTitle.text = ""
        lblTitle.textColor = COLOR.Gray
        lblTitle.font = UIFont(name: SourceSansPro_Regular, size: FONT_SIZE_THIRTEEN)
        lblTitle.numberOfLines = 0
        lblTitle.lineBreakMode = .byWordWrapping
        
        lblPrice.text = ""
        lblPrice.textColor = COLOR.Gray
        lblPrice.font = UIFont(name: SourceSansPro_Regular, size: FONT_SIZE_THIRTEEN)
        lblPrice.textAlignment = .center

        lblSepratior.setThemeForSeprator()
    }
    
    func reloadData(dictionary : NSDictionary)
    {
        lblTitle.text = "\(dictionary.value(forKey: ResponceKey_get_all_price_details.service_product.product_name)!)"
        lblPrice.text = "$\(dictionary.value(forKey: ResponceKey_get_all_price_details.service_product.product_price)!)"
        if dictionary.value(forKey: "is_weight") != nil
        {
            if "\(dictionary.value(forKey: "is_weight")!)" == "1"
            {
                lblPrice.text = "$\(dictionary.value(forKey: ResponceKey_get_all_price_details.service_product.product_price)!)/lb"
            }
            else{
                lblPrice.text = "$\(dictionary.value(forKey: ResponceKey_get_all_price_details.service_product.product_price)!)"
            }
        }
    }
    
    func reloadGiftCardData(dictionary : NSDictionary,sendCode:Int)
    {
        if sendCode == 0
        {
            
        }
        else{
            
        }
        lblTitle.text = "\(dictionary.value(forKey: ResponceKey_get_all_price_details.service_product.product_name)!)"
        lblPrice.isHidden = true
    }

}
