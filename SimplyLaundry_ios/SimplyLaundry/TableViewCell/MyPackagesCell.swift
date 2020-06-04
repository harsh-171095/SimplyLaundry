//
//  MyPackagesCell.swift
//  SimplyLaundry
//
//  Created by webclues on 29/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit
class HGButton : UIButton{
    var indexPath : IndexPath!
}
class MyPackagesCell: UITableViewCell {

    //Parent View Outlet's
    @IBOutlet weak var viewParent:UIView!
    
    @IBOutlet weak var lblPackageName:UILabel!
    @IBOutlet weak var lblPackageCredit:UILabel!
    @IBOutlet weak var btnCancelPackage:UIButton!
    @IBOutlet weak var btnDownloadPackageInvoice:HGButton!
    @IBOutlet weak var consbtnCancelPackageWidth: NSLayoutConstraint!

    //Package Deatils View Outlet's
    @IBOutlet weak var viewPackageDetails:UIView!
    
    @IBOutlet weak var lblPackageTitle:UILabel!
    @IBOutlet weak var lblSeparatorVericalOne:UILabel!
    @IBOutlet weak var conslblSeparatorVericalOneTraling: NSLayoutConstraint!// Constraint: set 90 for other iPhone and iphone 5,5c,5s set 70
    
    @IBOutlet weak var lblStartDateTitle:UILabel!
    @IBOutlet weak var lblSeparatorVericalTwo:UILabel!
    @IBOutlet weak var conslblSeparatorVericalTwoTraling: NSLayoutConstraint! // Constraint: set 90 for other iPhone and iphone 5,5c,5s set 70
    
    @IBOutlet weak var lblEndDateTitle:UILabel!
    @IBOutlet weak var lblSeparatorVericalThree:UILabel!
    @IBOutlet weak var conslblSeparatorVericalThreeTraling: NSLayoutConstraint! // Constraint: set 80 for other iPhone and iphone 5,5c,5s set 70
    
    @IBOutlet weak var lblPriceTitle:UILabel!
    @IBOutlet weak var lblSeparatorHorizontalOne:UILabel!
    
    @IBOutlet weak var lblPackage:UILabel!
    @IBOutlet weak var lblStartDate:UILabel!
    @IBOutlet weak var lblEndDate:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var lblSeparatorHorizontalTwo:UILabel!
    
    @IBOutlet weak var lblDescription:UILabel!

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
        
        //set Parent View Theme
        self.viewParent.backgroundColor = COLOR.clear
        
        lblPackageName.text = ""
        lblPackageName.textColor = COLOR.Green
        lblPackageName.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_SIXTEEN)
        
        lblPackageCredit.text = ""
        lblPackageCredit.textColor = COLOR.White
        lblPackageCredit.backgroundColor = COLOR.Gray
        lblPackageCredit.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_THIRTEEN)
        lblPackageCredit.numberOfLines = 1
        lblPackageCredit.setCornerRadius(corner:3)
        
        btnCancelPackage.setTitle("CANCEL", for: .normal)
        btnCancelPackage.backgroundColor = COLOR.Red
        btnCancelPackage.setTitleColor(COLOR.White, for: .normal)
        btnCancelPackage.titleLabel?.font = UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_ELEVEN)
        btnCancelPackage.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        btnCancelPackage.setCornerRadius(corner:3)
        
        btnDownloadPackageInvoice.backgroundColor = COLOR.clear
        btnDownloadPackageInvoice.setImage(UIImage.init(named: "invoice_download"), for: .normal)
        
        //Packages View Theme
        viewPackageDetails.backgroundColor = COLOR.background_Gray
        viewPackageDetails.setCornerRadius(corner:5)
        
        lblPackageTitle.text = "Package"
        lblPackageTitle.textColor = COLOR.Gray
        lblPackageTitle.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_SIXTEEN)
        lblPackageTitle.numberOfLines = 0
        lblPackageTitle.lineBreakMode = .byWordWrapping
        lblPackageTitle.textAlignment = .center
        
        lblSeparatorVericalOne.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.5))
        
        lblStartDateTitle.text = "Start Date"
        lblStartDateTitle.textColor = COLOR.Gray
        lblStartDateTitle.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_SIXTEEN)
        lblStartDateTitle.numberOfLines = 0
        lblStartDateTitle.lineBreakMode = .byWordWrapping
        lblStartDateTitle.textAlignment = .center

        lblSeparatorVericalTwo.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.5))
        
        lblEndDateTitle.text = "End Date"
        lblEndDateTitle.textColor = COLOR.Gray
        lblEndDateTitle.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_SIXTEEN)
        lblEndDateTitle.numberOfLines = 0
        lblEndDateTitle.lineBreakMode = .byWordWrapping
        lblEndDateTitle.textAlignment = .center

        lblSeparatorVericalThree.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.3))
        
        lblPriceTitle.text = "Price"
        lblPriceTitle.textColor = COLOR.Gray
        lblPriceTitle.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_SIXTEEN)
        lblPriceTitle.numberOfLines = 0
        lblPriceTitle.lineBreakMode = .byWordWrapping
        lblPriceTitle.textAlignment = .center

        lblSeparatorHorizontalOne.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.3))

        lblPackage.setThemeForTitle(isTitle : false, numberOfLines : 0)
        lblPackage.textAlignment = .center
        
        lblStartDate.setThemeForTitle(isTitle : false, numberOfLines : 0)
        lblStartDate.textAlignment = .center

        lblEndDate.setThemeForTitle(isTitle : false, numberOfLines : 0)
        lblEndDate.textAlignment = .center
        
        lblPrice.setThemeForTitle(isTitle : false, numberOfLines : 0)
        lblPrice.textAlignment = .center
        
        lblSeparatorHorizontalTwo.setThemeForSeprator(COLOR.Gray.withAlphaComponent(0.5))

        lblDescription.setThemeForTitle(isTitle : false, numberOfLines : 0)
        
    }
    
    func setActivePlanTheme()
    {
        //Set Theme acroding to active plan
        consbtnCancelPackageWidth.priority = UILayoutPriority(rawValue: 250)
        viewPackageDetails.backgroundColor = COLOR.Green
        lblPackageTitle.textColor = COLOR.White
        lblPackage.textColor = COLOR.White
        lblStartDateTitle.textColor = COLOR.White
        lblStartDate.textColor = COLOR.White
        lblEndDateTitle.textColor = COLOR.White
        lblEndDateTitle.isHidden = true
        lblEndDate.textColor = COLOR.White
        lblEndDate.isHidden = true
        lblPriceTitle.textColor = COLOR.White
        lblPrice.textColor = COLOR.White
        lblDescription.textColor = COLOR.White
        
        lblSeparatorVericalOne.backgroundColor = COLOR.White.withAlphaComponent(0.3)
        lblSeparatorVericalTwo.backgroundColor = COLOR.White.withAlphaComponent(0.3)
        lblSeparatorVericalTwo.isHidden = true
        lblSeparatorVericalThree.backgroundColor = COLOR.White.withAlphaComponent(0.3)
        lblSeparatorHorizontalOne.backgroundColor = COLOR.White.withAlphaComponent(0.3)
        lblSeparatorHorizontalTwo.backgroundColor = COLOR.White.withAlphaComponent(0.3)
        
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE
        {
            conslblSeparatorVericalOneTraling.constant = 100
            conslblSeparatorVericalTwoTraling.constant = 0
            conslblSeparatorVericalThreeTraling.constant = 80
        }
        else
        {
            conslblSeparatorVericalOneTraling.constant = 100
            conslblSeparatorVericalTwoTraling.constant = 0
            conslblSeparatorVericalThreeTraling.constant = 100
        }
    }
    
    func setDeactivePlanTheme()
    {
        //Set Theme Deacroding to active plan
        consbtnCancelPackageWidth.priority = UILayoutPriority(rawValue: 999)
        btnCancelPackage.isHidden = true
        lblPackageCredit.isHidden = false

        viewPackageDetails.backgroundColor = COLOR.background_Gray
        lblPackageTitle.textColor = COLOR.Gray
        lblPackage.textColor = COLOR.Gray
        lblStartDateTitle.textColor = COLOR.Gray
        lblStartDate.textColor = COLOR.Gray
        lblEndDateTitle.textColor = COLOR.Gray
        lblEndDateTitle.isHidden = false
        lblEndDate.textColor = COLOR.Gray
        lblEndDate.isHidden = false
        lblPriceTitle.textColor = COLOR.Gray
        lblPrice.textColor = COLOR.Gray
        lblDescription.textColor = COLOR.Gray
        lblSeparatorVericalOne.backgroundColor = COLOR.Gray.withAlphaComponent(0.3)
        lblSeparatorVericalTwo.backgroundColor = COLOR.Gray.withAlphaComponent(0.3)
        lblSeparatorVericalTwo.isHidden = false
        lblSeparatorVericalThree.backgroundColor = COLOR.Gray.withAlphaComponent(0.3)
        lblSeparatorHorizontalOne.backgroundColor = COLOR.Gray.withAlphaComponent(0.3)
        lblSeparatorHorizontalTwo.backgroundColor = COLOR.Gray.withAlphaComponent(0.3)
        
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE
        {
            conslblSeparatorVericalOneTraling.constant = 70
            conslblSeparatorVericalTwoTraling.constant = 70
            conslblSeparatorVericalThreeTraling.constant = 60
        }
        else
        {
            conslblSeparatorVericalOneTraling.constant = 90
            conslblSeparatorVericalTwoTraling.constant = 90
            conslblSeparatorVericalThreeTraling.constant = 80
        }
    }
    
    // Set Details of active plan
    func setPackagesDeatils(dictionary:NSDictionary)
    {
        let array = NSArray(array: dictionary.value(forKey: ResponceKey_pack_detail.package_price) as! NSArray)
        let packages : NSMutableString = NSMutableString()
        let price : NSMutableString = NSMutableString()
        for i in 0..<array.count
        {
            if i == 0
            {
                packages.append("\((array[i] as! NSDictionary).value(forKey: ResponceKey_pack_detail.package_price_value.service_name)!)")
                if "\((array[i] as! NSDictionary).value(forKey: ResponceKey_pack_detail.package_price_value.price)!)".count < 1
                {
                    price.append("-")
                }
                else{
                    price.append("$\((array[i] as! NSDictionary).value(forKey: ResponceKey_pack_detail.package_price_value.price)!)/lb ")
                }
            }
            else{
                packages.append(",\n\((array[i] as! NSDictionary).value(forKey: ResponceKey_pack_detail.package_price_value.service_name)!)")
                if "\((array[i] as! NSDictionary).value(forKey: ResponceKey_pack_detail.package_price_value.price)!)".count < 1
                {
                    price.append("-")
                }
                else{
                    if "\((array[i-1] as! NSDictionary).value(forKey: ResponceKey_pack_detail.package_price_value.price)!)".count < 1
                    {
                        price.append("\n$\((array[i] as! NSDictionary).value(forKey: ResponceKey_pack_detail.package_price_value.price)!)/lb ")
                    }
                    else{
                        price.append(",\n$\((array[i] as! NSDictionary).value(forKey: ResponceKey_pack_detail.package_price_value.price)!)/lb ")
                    }
                    
                }
            }
        }

        lblPackageName.text = "\(dictionary.value(forKey: ResponceKey_pack_detail.package_name)!)"
        lblPackage.text = packages as String
        lblPrice.text = price as String
        lblDescription.text = "\(dictionary.value(forKey: ResponceKey_pack_detail.package_description)!)"
        if "\(dictionary.value(forKey: ResponceKey_pack_detail.status)!)" == "1"
        {
            setActivePlanTheme()
            lblStartDate.text = getDateFrom(string: "\(dictionary.value(forKey: ResponceKey_pack_detail.created_on)!)", getDateFormate: "dd/MM/yyyy")
            lblEndDate.text = getDateFrom(string: "\(dictionary.value(forKey: ResponceKey_pack_detail.expired_on)!)", getDateFormate: "dd/MM/yyyy")
            lblPackageCredit.text = "   Available Credit: $\(dictionary.value(forKey: ResponceKey_pack_detail.credits)!)   "
        }
        else{
            setDeactivePlanTheme()
            lblStartDate.text = getDateFrom(string: "\(dictionary.value(forKey: ResponceKey_pack_detail.created_on)!)", fromDateFormate: "dd-MM-yyyy", getDateFormate: "dd/MM/yyyy")
            lblEndDate.text = getDateFrom(string: "\(dictionary.value(forKey: ResponceKey_pack_detail.expired_on)!)", fromDateFormate: "dd-MM-yyyy", getDateFormate: "dd/MM/yyyy")
            lblPackageCredit.text = "   Remaining Credit: $\(dictionary.value(forKey: ResponceKey_pack_detail.credits)!)   "
        }
    }
}
