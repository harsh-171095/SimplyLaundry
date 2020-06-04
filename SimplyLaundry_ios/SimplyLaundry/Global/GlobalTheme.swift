//
//  GlobalTheme.swift
//  SimplyLaundry
//
//  Created by webclues on 24/06/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import Foundation
import UIKit

extension UILabel
{
    func setVCTitle(_ text : String)
    {
        self.text = text
        self.textColor = COLOR.White
        self.textAlignment = .center
        self.font = UIFont(name: SourceSansPro_Regular, size: FONT_SIZE_TWENTY_FOUR - 2)
    }
    
    func setThemeForTextFiledTitle(_ text : String , textColor : UIColor = COLOR.Gray.withAlphaComponent(0.6))
    {
        self.text = text
        self.textColor = textColor
        self.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
    }
    
    func setThemeForTitle(_ text : String = "", textColor : UIColor = COLOR.Gray, isTitle : Bool = true, numberOfLines : Int = 1, titleFontName : String = SourceSansPro_Bold, size : CGFloat = FONT_SIZE_FOURTEEN )
    {
        self.text = text
        self.textColor = textColor
        self.font = UIFont.init(name: isTitle == true ? titleFontName : SourceSansPro_Regular, size: size)
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = numberOfLines
    }
    
    func setThemeForUnderlineTitle(_ text : String,textColor : UIColor = COLOR.Blue, underlineColor : UIColor = COLOR.Blue)
    {
        self.text = ""
        self.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        self.textColor = textColor
        self.attributedText = NSAttributedString(string: text, attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor : underlineColor])
    }
    
    func setThemeForSeprator(_ sepratorColor : UIColor = COLOR.background_Gray)
    {
        self.text = ""
        self.textColor = COLOR.clear
        self.backgroundColor = sepratorColor
    }
}

extension UITextField
{
    func setThemeFor(_ placehoder : String = "", text : String = "",textColor : UIColor = COLOR.textFiled,placehoderColor : UIColor = COLOR.placeholder,keyboardType : UIKeyboardType = .default,returnKeyType : UIReturnKeyType = .next)
    {
        self.text = text
        self.textColor = textColor
        self.placeholder = placehoder
        self.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        self.setPlaceholderColor(color: placehoderColor)
        self.autocorrectionType = .yes
        self.keyboardType = keyboardType
        self.autocapitalizationType = .sentences
        self.returnKeyType = returnKeyType
    }
    
    func setThemeWithImage(_ placehoder : String = "", text : String = "",textColor : UIColor = COLOR.textFiled,placehoderColor : UIColor = COLOR.placeholder,keyboardType : UIKeyboardType = .default,returnKeyType : UIReturnKeyType = .default, imageName : String)
    {
        self.text = text
        self.textColor = textColor
        self.placeholder = placehoder
        self.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        self.setPlaceholderColor(color: placehoderColor)
        self.autocorrectionType = .yes
        self.keyboardType = keyboardType
        self.autocapitalizationType = .sentences
        self.returnKeyType = returnKeyType
        
        self.rightViewMode = .always
        let image = UIImage.init(named: imageName)
        let imageview = UIImageView(image: image)
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        
        self.rightView = imageview
    }
    
    func setThemeWithImageNoCorrection(_ placehoder : String = "", text : String = "",textColor : UIColor = COLOR.textFiled,placehoderColor : UIColor = COLOR.placeholder,keyboardType : UIKeyboardType = .default,returnKeyType : UIReturnKeyType = .default, imageName : String)
    {
        self.text = text
        self.textColor = textColor
        self.placeholder = placehoder
        self.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        self.setPlaceholderColor(color: placehoderColor)
        self.autocorrectionType = .no
        self.keyboardType = keyboardType
        self.autocapitalizationType = .none
        self.returnKeyType = returnKeyType
        
        self.rightViewMode = .always
        let image = UIImage.init(named: imageName)
        let imageview = UIImageView(image: image)
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        
        self.rightView = imageview
    }
}

extension UITextView
{
    func setThemeFor(_ placehoder:String = "", textColor : UIColor = COLOR.placeholder,returnKeyType : UIReturnKeyType = .next)
    {
        self.text = placehoder
        self.textColor = textColor
        self.backgroundColor = COLOR.clear
        self.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        self.autocorrectionType = .yes
        self.keyboardType = .default
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = .sentences
    }
}

extension UIButton
{
    func setThemeForAppButton(_ title : String = "")
    {
        self.setTitle(title, for: .normal)
        self.setTitleColor(COLOR.White, for: .normal)
        self.backgroundColor = COLOR.Blue
        self.titleLabel?.font = UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_FOURTEEN)
        self.setCornerRadius(corner: 5)
    }
    
    func setThemeForOrderHistory(_ title : String = "", textColor : UIColor = COLOR.White, backgroundColor : UIColor , numberOfLines : Int = 1)
    {
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_TWELVE)
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.numberOfLines = numberOfLines
        self.titleLabel?.textAlignment = .center
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        self.setCornerRadius(corner:5)
    }
    
    func setThemeForRadioBtton(_ title : String , isSelected : Bool = false)
    {
        self.setTitle("   \(title)", for: .normal)
        self.setTitleColor(COLOR.Balck, for: .normal)
        self.tintColor = COLOR.clear
        self.setImage(UIImage(named: "radio_button_selected"), for: .normal)
        self.titleLabel?.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        if isSelected == true
        {
            self.setImage(UIImage(named: "radio_button_selected"), for: .normal)
        }
        else
        {
            self.setImage(UIImage(named: "radio_button"), for: .normal)
        }
    }
    
    func setThemeForPSWButton(_ title : String = "")
    {
        self.setTitle(title, for: .normal)
        self.setTitleColor(COLOR.Gray, for: .normal)
        self.titleLabel?.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_TEN)
    }
}
extension UIScrollView
{
    func setThemeForScrollView(_ backgroundColor : UIColor = COLOR.White)
    {
        self.backgroundColor = backgroundColor
        self.bounces = false
        self.isScrollEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bouncesZoom = false
    }
}
