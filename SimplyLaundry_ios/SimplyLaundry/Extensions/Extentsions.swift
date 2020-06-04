//
//  Extentsions.swift
//  SimplyLaundry
//
//  Created by webclues on 28/12/18.
//  Copyright © 2018 webclues. All rights reserved.
//

import Foundation
import UIKit

// ------------------------------------------------------------- For NSDictionary to Json String ---------------------------------------------------------------------
extension NSDictionary
{
    func JSONString() -> NSString
    {
        var jsonString: NSString = ""
        var jsonData: NSData!
        
        do
        {
            jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0)) as NSData
        }
        catch let error as NSError
        {
            print(error)
        }
        
        jsonString = NSString.init(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)!
        
        return jsonString
    }
}

extension Float
{
    var clean: String {
        return self .truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Double
{
    var clean: String {
        return self .truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension NSLocale
{
    class func getCountryCode(countryName1 : String) -> String
    {
        let locales : String = ""
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: localeCode)
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            if countryName1.lowercased() == countryName?.lowercased() {
                return localeCode
            }
        }
        return locales
    }
}

// ------------------------------------------------------------- For NSArray to Json String ---------------------------------------------------------------------
extension NSArray
{
    func JSONString() -> NSString
    {
        var jsonString: NSString = ""
        var jsonData: NSData!
        
        do
        {
            jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0)) as NSData
        }
        catch let error as NSError
        {
            print(error)
        }
        
        jsonString = NSString.init(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)!
        
        return jsonString
    }
}


extension String
{
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var removeSpace: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public func format(_ seprator: String) -> String {
        let src = self
        var dst = [String]()
        var i = 1
        for char in src {
            let mod = i % 4
            dst.append(String(char))
            if mod == 0 {
                dst.append(seprator)
            }
            i += 1
        }
        return dst.joined(separator: "")
    }
}
extension String
{
    var isNumber: Bool
    {
        let characters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty && rangeOfCharacter(from: characters) == nil
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat
    {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    func removeDots() -> String
    {
        return self.replacingOccurrences(of: ".", with: "")
    }
}


extension UITextView
{
    override open func layoutSubviews()
    {
        super.layoutSubviews()
        for view in subviews {
            if let button = view as? UIButton {
                button.setImage(button.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
                button.tintColor = .white
            }
        }
    }
}
extension UITextField
{
    func setPlaceholderColor(color:UIColor)
    {
        self.setValue(color, forKeyPath: "_placeholderLabel.textColor")
    }
}
extension UIView {
    
    // OUTPUT 1
    func callMethodAfterDelay(funcName : Selector )
    {
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:funcName , userInfo: nil, repeats: false)
    }

}

extension UIViewController
{
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    func callMethodAfterDelay(funcName : Selector )
    {
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:funcName , userInfo: nil, repeats: false)
    }
    
}
extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.tintColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.tintColor = newValue
        }
    }
}

extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}

extension NSAttributedString {
    func replace(placeholder: String, with hyperlink: String, url: String) -> NSAttributedString {
        let mutableAttr = NSMutableAttributedString(attributedString: self)
        
        let hyperlinkAttr = NSAttributedString(string: hyperlink, attributes: [NSAttributedString.Key.link: URL(string: url)!])
        
        let placeholderRange = (self.string as NSString).range(of: placeholder)
        
        mutableAttr.replaceCharacters(in: placeholderRange, with: hyperlinkAttr)
        return mutableAttr
    }
}
extension String {
//    var alphaNumeric: String {
//        return components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
//
//    }
    func isAlphanumeric() -> Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && self != ""
    }
}
