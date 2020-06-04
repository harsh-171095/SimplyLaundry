//
//  DeliveryOptionCell.swift
//  SimplyLaundry
//
//  Created by webclues on 02/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class DeliveryOptionCell: UICollectionViewCell {
    
    @IBOutlet weak var viewParent:UIView!
    @IBOutlet weak var lblTitle:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTheme()
    }
    
    /*
     Function Name :- setTheme
     Function Parameters :- (nil)
     Function Description :- This function used for set a Cotroller outlet's theme.
     */
    func setTheme()
    {
        self.backgroundColor = COLOR.White
        self.viewParent.backgroundColor = COLOR.White
        
        lblTitle.textColor = COLOR.Gray
        lblTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_THIRTEEN)
        lblTitle.numberOfLines = 0
        lblTitle.lineBreakMode = .byWordWrapping
        lblTitle.textAlignment = .center
        
        self.setCornerRadius(border: 1, Color: COLOR.background_Gray, corner: 5)
    }
    
    func reloadData(dictionary:NSDictionary)
    {
        let doller = Double("\(dictionary.value(forKey: get_delivery_optionResponce.dataValues.delivery_value)!)")!
        if dictionary.value(forKey: get_delivery_optionResponce.isSelected) as! Bool == true{
            if doller > 1
            {
                lblTitle.text = "\(dictionary.value(forKey: get_delivery_optionResponce.dataValues.delivery_name)!) (\(dictionary.value(forKey: get_delivery_optionResponce.dataValues.delivery_hour)!) hours) + $\(dictionary.value(forKey: get_delivery_optionResponce.dataValues.delivery_value)!)"
            }
            else{
                lblTitle.text = "\(dictionary.value(forKey: get_delivery_optionResponce.dataValues.delivery_name)!) (\(dictionary.value(forKey: get_delivery_optionResponce.dataValues.delivery_hour)!) hours)"
            }
            lblTitle.textColor = COLOR.Green
            viewParent.backgroundColor = COLOR.background_Gray
            self.setCornerRadius(border: 1, Color: COLOR.Blue, corner: 5)
        }
        else{
            if doller > 1
            {
                lblTitle.text = "\(dictionary.value(forKey: get_delivery_optionResponce.dataValues.delivery_name)!) (\(dictionary.value(forKey: get_delivery_optionResponce.dataValues.delivery_hour)!) hours) + $\(dictionary.value(forKey: get_delivery_optionResponce.dataValues.delivery_value)!)"
            }
            else{
                lblTitle.text = "\(dictionary.value(forKey: get_delivery_optionResponce.dataValues.delivery_name)!) (\(dictionary.value(forKey: get_delivery_optionResponce.dataValues.delivery_hour)!) hours)"
            }
            lblTitle.textColor = COLOR.Gray
            viewParent.backgroundColor = COLOR.White
            self.setCornerRadius(border: 1, Color: COLOR.background_Gray, corner: 5)
        }
    }
    
}
