//
//  PriceListCollectionCell.swift
//  SimplyLaundry
//
//  Created by webclues on 24/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class PriceListCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var viewParent:UIView!
    @IBOutlet weak var imgIcon:UIImageView!
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
        lblTitle.textAlignment = .left
        
        self.setCornerRadius(border: 1, Color: COLOR.background_Gray, corner: 5)
    }
    
    func reloadData(dictionary:NSDictionary)
    {
        if dictionary.value(forKey: isSelected_Key) as! Bool == true{
            imgIcon.image = UIImage.init(named: "\(dictionary.value(forKey: get_all_servicesResponce.wash_service_value.active_service_img)!)")
            lblTitle.text = "\(dictionary.value(forKey: ResponceKey_get_all_price_details.service_product.service_categry_name)!)"
            lblTitle.textColor = COLOR.Green
            viewParent.backgroundColor = COLOR.background_Gray
            self.setCornerRadius(border: 1, Color: COLOR.Blue, corner: 5)
        }
        else{
            imgIcon.image = UIImage.init(named: "\(dictionary.value(forKey: get_all_servicesResponce.wash_service_value.service_img)!)")
            lblTitle.text = "\(dictionary.value(forKey: ResponceKey_get_all_price_details.service_product.service_categry_name)!)"
            lblTitle.textColor = COLOR.Gray
            viewParent.backgroundColor = COLOR.White
            self.setCornerRadius(border: 1, Color: COLOR.background_Gray, corner: 5)
        }
    }
}
