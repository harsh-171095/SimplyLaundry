//
//  ServicesCell.swift
//  SimplyLaundry
//
//  Created by webclues on 04/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class ServicesCell: UITableViewCell {

    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    @IBOutlet weak var lblTitle:UILabel!
    
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
        lblTitle.textColor = COLOR.Gray
        lblTitle.font = UIFont(name: SourceSansPro_Regular, size: FONT_SIZE_FIFTEEN)
    }
    
    func reloadData(dictionary : NSDictionary)
    {
        lblTitle.text = "\(dictionary.value(forKey: "title")!)"
    }
    
    func reloadMyPackagesHeaderData(dictionary : NSDictionary)
    {
        lblTitle.text = "\(dictionary.value(forKey: "title")!)"
        lblTitle.textColor = COLOR.Gray.withAlphaComponent(0.6)
        lblTitle.font = UIFont(name: SourceSansPro_Semibold, size: FONT_SIZE_FIFTEEN)
    }
}
