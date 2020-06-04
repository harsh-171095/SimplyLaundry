//
//  AddAddressCell.swift
//  SimplyLaundry
//
//  Created by webclues on 07/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class AddAddressCell: UITableViewCell {

    @IBOutlet weak var btnAddAddress:UIButton!
    @IBOutlet weak var lblCircle:UILabel!
    @IBOutlet weak var consButtonWidth: NSLayoutConstraint!
    
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

        btnAddAddress.backgroundColor = COLOR.Blue
        btnAddAddress.setTitle("", for: .normal)
        btnAddAddress.setTitleColor(COLOR.White, for: .normal)
        btnAddAddress.titleLabel?.font = UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_FOURTEEN)
        btnAddAddress.setCornerRadius(corner:5)
        
        lblCircle.text = ""
        lblCircle.backgroundColor = COLOR.White
        lblCircle.setCornerRadius()
    }
    
    func reloadPreferenceData()
    {
        consButtonWidth.constant = self.frame.width - 30
    }

}
