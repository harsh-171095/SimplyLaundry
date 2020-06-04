//
//  SideManuCell.swift
//  SimplyLaundry
//
//  Created by webclues on 29/12/18.
//  Copyright © 2018 webclues. All rights reserved.
//

import UIKit

class SideManuCell: UITableViewCell {

    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    
    @IBOutlet weak var imgLeft:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var imgRight:UIImageView!
    
    @IBOutlet weak var lblSepratior:UILabel!
    @IBOutlet weak var btnDidSelect:UIButton!
    
    //Variables Declarations and initialization
    
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
        lblTitle.text = ""
        lblTitle.textColor = COLOR.Gray
        lblTitle.font = UIFont(name: SourceSansPro_Regular, size: FONT_SIZE_SEVENTEEN)
        
        lblSepratior.setThemeForSeprator(COLOR.clear)
        
        imgLeft.image = nil
        imgRight.image = nil
        
        btnDidSelect.setTitle("", for: .normal)
    }

    func reloadData(dictionary : NSDictionary)
    {
        imgLeft.image = UIImage.init(named: "\(dictionary.value(forKey: "img_left")!)")
        lblTitle.text = "\(dictionary.value(forKey: "title")!)"
        imgRight.image = UIImage.init(named: "\(dictionary.value(forKey: "img_right")!)")
    }
}
