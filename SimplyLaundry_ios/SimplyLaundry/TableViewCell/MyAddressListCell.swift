//
//  MyAddressListCell.swift
//  SimplyLaundry
//
//  Created by webclues on 07/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class MyAddressListCell: UITableViewCell {

    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    @IBOutlet weak var btnCheckUncheck:UIButton!
    @IBOutlet weak var viewAddressDetails:UIView!
    @IBOutlet weak var lblAddressType:UILabel!
    @IBOutlet weak var lblAddressOne:UILabel!
    @IBOutlet weak var lblAddressTwo:UILabel!
    @IBOutlet weak var btnEdit:UIButton!
    @IBOutlet weak var lblSepratorVerical:UILabel!
    @IBOutlet weak var btnDelete:UIButton!
    
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
        btnCheckUncheck.setImage(UIImage.init(named: "radio_button"), for: .normal)
        
        viewAddressDetails.backgroundColor = COLOR.background_Gray
        viewAddressDetails.setCornerRadius(corner:5)
        
        lblAddressType.text = ""
        lblAddressType.textColor = COLOR.Gray.withAlphaComponent(0.5)
        lblAddressType.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_TEN)
        
        lblAddressOne.setThemeForTitle( isTitle : false, numberOfLines: 0)
        lblAddressTwo.setThemeForTitle( isTitle : false, numberOfLines: 0)

        btnEdit.setTitle("Edit", for: .normal)
        btnEdit.setTitleColor(COLOR.Blue_light, for: .normal)
        btnEdit.titleLabel!.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)

        lblSepratorVerical.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.5))

        btnDelete.setTitle("Delete", for: .normal)
        btnDelete.setTitleColor(COLOR.Red, for: .normal)
        btnDelete.titleLabel!.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
    }
    
    func reloadData(dictionary : NSDictionary)
    {
        btnCheckUncheck.setImage(UIImage.init(named: "radio_button"), for: .normal)
        lblAddressOne.text = "\(dictionary.value(forKey: "address_line1")!)"
        lblAddressTwo.text = "\(dictionary.value(forKey: "address_line2")!)"
        lblAddressType.text = ""
        if "\(dictionary.value(forKey: "is_default")!)" == "1"
        {
            btnCheckUncheck.setImage(UIImage.init(named: "radio_button_selected"), for: .normal)
            lblAddressType.text = "Default Address"
            btnDelete.isHidden = true
            lblSepratorVerical.isHidden = true
        }
        else{
            btnDelete.isHidden = false
            lblSepratorVerical.isHidden = false
        }
    }
}
