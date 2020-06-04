//
//  FAQ'sCell.swift
//  SimplyLaundry
//
//  Created by webclues on 16/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class FAQsCell: UITableViewCell {

    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    
    @IBOutlet weak var viewContent:UIView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDescription:UILabel!
    @IBOutlet weak var consLblDescriptionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnHideShow:UIButton!
    
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
        viewParent.backgroundColor = COLOR.clear
        
        viewContent.backgroundColor = COLOR.background_Gray
        viewContent.setCornerRadius(corner:10)
        
        lblTitle.text = ""
        lblTitle.textColor = COLOR.Gray
        lblTitle.font = UIFont(name: SourceSansPro_Bold, size: FONT_SIZE_FOURTEEN)
        lblTitle.numberOfLines = 0
        lblTitle.lineBreakMode = .byWordWrapping
        
        lblDescription.text = ""
        lblDescription.textColor = COLOR.Gray
        lblDescription.font = UIFont(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        lblDescription.numberOfLines = 0
        lblDescription.lineBreakMode = .byWordWrapping
        
        btnHideShow.setTitle("", for: .normal)
        btnHideShow.setImage(UIImage.init(named: "down_arrow"), for: .normal)
        btnHideShow.backgroundColor = COLOR.background_Gray
        btnHideShow.setCornerRadius()

        consLblDescriptionHeight.priority = UILayoutPriority(rawValue: 999)
    }
    
    func reloadData(dictionary : NSDictionary)
    {
        lblTitle.text = "\(dictionary.value(forKey: "title")!)"
        lblDescription.text = "\(dictionary.value(forKey: "description")!)"
        if dictionary.value(forKey: "isExpande") as! Bool == true
        {
            lblDescription.isHidden = false
            btnHideShow.setImage(UIImage.init(named: "up_arrow"), for: .normal)
            consLblDescriptionHeight.priority = UILayoutPriority(rawValue: 250)
        }
        else{
            lblDescription.isHidden = true
            btnHideShow.setImage(UIImage.init(named: "down_arrow"), for: .normal)
            consLblDescriptionHeight.priority = UILayoutPriority(rawValue: 999)
        }
    }
    
}
