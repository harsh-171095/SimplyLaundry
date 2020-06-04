//
//  PreferencesSelectionCell.swift
//  SimplyLaundry
//
//  Created by webclues on 11/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class PreferencesSelectionCell: UITableViewCell {
    
    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var btnChechUncheck:UIButton!
    
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
        
        lblTitle.setThemeForTitle(isTitle: false, numberOfLines: 0)
        
        btnChechUncheck.setTitle("", for: .normal)
        btnChechUncheck.setImage(UIImage.init(named: "radio_button"), for: .normal)
    }
    
    func reloadData(dictionary : NSDictionary)
    {
        lblTitle.text = "\(dictionary.value(forKey: get_all_servicesResponce.values.name)!)"
        if "\(dictionary.value(forKey: get_all_servicesResponce.values.is_selected)!)" == "1"
        {
            btnChechUncheck.setImage(UIImage.init(named: "radio_button_selected"), for: .normal)
        }
        else{
            btnChechUncheck.setImage(UIImage.init(named: "radio_button"), for: .normal)
        }
    }
}
