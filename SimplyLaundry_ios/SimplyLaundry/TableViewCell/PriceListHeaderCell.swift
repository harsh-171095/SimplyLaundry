//
//  PriceListHeaderCell.swift
//  SimplyLaundry
//
//  Created by webclues on 24/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class PriceListHeaderCell: UITableViewCell {
    
    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblSepratior:UILabel!

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
        
        lblTitle.text = ""
        lblTitle.textColor = COLOR.Balck
        lblTitle.font = UIFont(name: SourceSansPro_Semibold, size: FONT_SIZE_SIXTEEN)
        
        lblSepratior.setThemeForSeprator()
    }
    
    func reloadData(dictionary : NSDictionary)
    {
        lblTitle.text = "\(dictionary.value(forKey: ResponceKey_get_all_price_details.service_product.product_category_name)!)"
    }
}
