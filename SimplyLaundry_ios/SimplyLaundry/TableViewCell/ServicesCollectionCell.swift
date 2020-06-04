//
//  ServicesCollectionCell.swift
//  SimplyLaundry
//
//  Created by webclues on 20/02/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class ServicesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var viewParent:UIView!
    @IBOutlet weak var imgIcon:UIImageView!
    
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
        
        self.setCornerRadius(border: 1, Color: COLOR.background_Gray, corner: 5)
    }
    
    func reloadServiceData(dictionary:NSDictionary)
    {
        if dictionary.value(forKey: get_all_servicesResponce.isSelected) as! Bool == true{
            imgIcon.contentMode = .scaleAspectFit
            imgIcon.sd_showActivityIndicatorView()
            imgIcon.sd_setImage(with: URL(string: "\(dictionary.value(forKey: get_all_servicesResponce.wash_service_value.active_service_img)!)"), completed: nil)
            imgIcon.sd_removeActivityIndicator()
            viewParent.backgroundColor = COLOR.background_Gray
            self.setCornerRadius(border: 1, Color: COLOR.Blue, corner: 5)
        }
        else{
            imgIcon.sd_setImage(with: URL(string: "\(dictionary.value(forKey: get_all_servicesResponce.wash_service_value.service_img)!)"), completed: nil)
            imgIcon.contentMode = .scaleAspectFit
            viewParent.backgroundColor = COLOR.White
            self.setCornerRadius(border: 1, Color: COLOR.background_Gray, corner: 5)
        }
    }
}
