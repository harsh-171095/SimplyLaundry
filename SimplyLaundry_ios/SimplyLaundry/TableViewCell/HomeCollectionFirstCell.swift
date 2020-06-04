//
//  HomeCollectionFirstCell.swift
//  SimplyLaundry
//
//  Created by webclues on 31/12/18.
//  Copyright © 2018 webclues. All rights reserved.
//

import UIKit
import SDWebImage
class HomeCollectionFirstCell: UICollectionViewCell {

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
        
        lblTitle.text = ""
        lblTitle.textColor = COLOR.Gray
        lblTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_THIRTEEN)
        lblTitle.numberOfLines = 0
        lblTitle.lineBreakMode = .byWordWrapping
        lblTitle.textAlignment = .center
        self.setCornerRadius(border: 1, Color: COLOR.background_Gray, corner: 5)
    }
    
    func reloadData(dictionary:NSDictionary)
    {
        if dictionary.value(forKey: "isSelected") as! Bool == true{
            imgIcon.image = UIImage.init(named: "\(dictionary.value(forKey: "img_selected")!)")
            lblTitle.text = "\(dictionary.value(forKey: "title")!)"
            lblTitle.textColor = COLOR.Green
            viewParent.backgroundColor = COLOR.background_Gray
            self.setCornerRadius(border: 1, Color: COLOR.Blue, corner: 5)
        }
        else{
            imgIcon.image = UIImage.init(named: "\(dictionary.value(forKey: "img")!)")
            lblTitle.text = "\(dictionary.value(forKey: "title")!)"
            lblTitle.textColor = COLOR.Gray
            viewParent.backgroundColor = COLOR.White
            self.setCornerRadius(border: 1, Color: COLOR.background_Gray, corner: 5)
        }
    }
    
    func reloadServiceData(dictionary:NSDictionary)
    {
        if dictionary.value(forKey: get_all_servicesResponce.isSelected) as! Bool == true{
            imgIcon.contentMode = .scaleAspectFit
            imgIcon.sd_setImage(with: URL(string: "\(dictionary.value(forKey: get_all_servicesResponce.wash_service_value.active_service_img)!)"), completed: nil)
            lblTitle.textColor = COLOR.Green
            viewParent.backgroundColor = COLOR.background_Gray
            self.setCornerRadius(border: 1, Color: COLOR.Blue, corner: 5)
        }
        else{
            imgIcon.sd_setImage(with: URL(string: "\(dictionary.value(forKey: get_all_servicesResponce.wash_service_value.service_img)!)"), completed: nil)
            imgIcon.contentMode = .scaleAspectFit
            lblTitle.textColor = COLOR.Gray
            viewParent.backgroundColor = COLOR.White
            self.setCornerRadius(border: 1, Color: COLOR.background_Gray, corner: 5)
        }
    }
}
