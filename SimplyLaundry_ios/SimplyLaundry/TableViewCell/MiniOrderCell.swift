//
//  MiniOrderCell.swift
//  SimplyLaundry
//
//  Created by webclues on 30/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class MiniOrderCell: UITableViewCell {
    
    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    @IBOutlet weak var lblCircle:UILabel!
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
        lblTitle.font = UIFont(name: SourceSansPro_Regular, size: FONT_SIZE_TWELVE)
        
        lblCircle.text = ""
        lblCircle.backgroundColor = COLOR.Gray
        lblCircle.setCornerRadius()
    }
    
    func reloadData(dictionary : NSDictionary)
    {
        lblTitle.text = "\(dictionary.value(forKey: "title")!)"
    }
    
}
