//
//  ExtraServiceCell.swift
//  SimplyLaundry
//
//  Created by webclues on 21/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class ExtraServiceCell: UITableViewCell {
    
    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    
    @IBOutlet weak var btnCheckUnCkeck:UIButton!
    @IBOutlet weak var btnInfo:UIButton!
    
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
        viewParent.backgroundColor = COLOR.clear
        
        btnCheckUnCkeck.setTitle("", for: .normal)
        btnCheckUnCkeck.setImage(UIImage.init(named: "checkbox"), for: .normal)
        btnCheckUnCkeck.setTitleColor(COLOR.Gray, for: .normal)
        btnCheckUnCkeck.titleLabel!.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)

        btnInfo.setTitle("", for: .normal)
        btnInfo.setImage(UIImage.init(named: "info"), for: .normal)
        
        
    }
    
    func reloadData(dictionary : NSDictionary)
    {
        btnInfo.isHidden = true
        btnCheckUnCkeck.setTitle("   \(dictionary.value(forKey: get_all_servicesResponce.values.name)!)", for: .normal)
        if dictionary.value(forKey: get_all_servicesResponce.values.is_selected) as! Bool == true
        {
            btnCheckUnCkeck.setImage(UIImage.init(named: "checkbox_done"), for: .normal)
        }
        else{
            btnCheckUnCkeck.setImage(UIImage.init(named: "checkbox"), for: .normal)
        }
        if "\(dictionary.value(forKey: get_all_servicesResponce.values.name)!)" == "Donation"
        {
            btnInfo.isHidden = false
        }
    }
    
    func reloadGiftCardAmountData(dictionary : NSDictionary, isDefault : Bool = false)
    {
        btnInfo.isHidden = true
        btnCheckUnCkeck.setImage(UIImage.init(named: "radio_button"), for: .normal)
        btnCheckUnCkeck.setTitle("   $\(dictionary.value(forKey: "title")!)", for: .normal)
        if isDefault == true
        {
            btnCheckUnCkeck.setImage(UIImage.init(named: "radio_button_selected"), for: .normal)
        }
    }
    
    func reloadPaymentData(dictionary : NSDictionary)
    {
        btnInfo.isHidden = true
        btnCheckUnCkeck.setImage(UIImage.init(named: "radio_button"), for: .normal)
         btnCheckUnCkeck.setTitle("   \(dictionary.value(forKey: "title")!)", for: .normal)
        if dictionary.value(forKey: isSelected_Key) as! Bool == true
        {
            btnCheckUnCkeck.setImage(UIImage.init(named: "radio_button_selected"), for: .normal)
        }
    }
}
