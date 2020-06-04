//
//  AddOrderHistoryXSLCell.swift
//  SimplyLaundry
//
//  Created by webclues on 04/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class AddOrderHistoryXSLCell: UITableViewCell {


    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!

    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblSepratorVericalOne:UILabel!
    
    @IBOutlet weak var lblStatus:UILabel!
    
    @IBOutlet weak var lblSepratorThree:UILabel!
    
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
        
        //set Parent View Theme
        self.viewParent.backgroundColor = COLOR.clear
        
        lblDate.text = ""
        lblDate.textColor = COLOR.Gray
        lblDate.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        lblDate.numberOfLines = 0
        lblDate.lineBreakMode = .byWordWrapping
        
        lblSepratorVericalOne.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.5))
        
        lblStatus.text = ""
        lblStatus.textColor = COLOR.Gray
        lblStatus.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        lblStatus.numberOfLines = 0
        lblStatus.lineBreakMode = .byWordWrapping
        
        lblSepratorThree.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.5))
    }
    
    func reloadData(dictionary:NSDictionary)
    {
        lblDate.text = getDateFrom(string: "\(dictionary.value(forKey: ResponceKey_order_data.order_status_values.created_on)!)", getDateFormate: "dd/MM/yyyy")
        lblStatus.text = "\(dictionary.value(forKey: ResponceKey_order_data.order_status_values.order_status)!)"
    }
    
    func reloadHeader()
    {
        lblDate.text = "Date Added"
        lblDate.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        lblStatus.text = "Order Status"
        lblStatus.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
    }
}
