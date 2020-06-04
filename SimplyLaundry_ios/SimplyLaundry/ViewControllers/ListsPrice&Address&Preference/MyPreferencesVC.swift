//
//  MyPreferencesVC.swift
//  SimplyLaundry
//
//  Created by webclues on 11/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class MyPreferencesVC: UIViewController {

    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnManu:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var scrollContent:UIScrollView!
    @IBOutlet weak var viewContent:UIView!
    
    @IBOutlet weak var tableViewObj:UITableView!
    @IBOutlet weak var consTableViewObjHeight: NSLayoutConstraint!

    //Submit button
    @IBOutlet weak var btnSubmit:UIButton!
    @IBOutlet weak var lblButtonCircle:UILabel!

    // Variable Declarations and Initlizations
    var dicPreferences = NSDictionary()
    var arrPreferences = NSMutableArray()
    var isServicesSelected :Int = 0
    var isDeliveryOptionSelected :Int = 0
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        processGetAllUserPreference()
    }

    //MARK:- set Outlet's Theme
    /*
     Function Name :- setTheme
     Function Parameters :- (nil)
     Function Description :- This function used for set a Cotroller outlet's theme.
     */
    func setTheme()
    {
        //Parent theme
        self.view.addGradientsWithTwoColor()
        viewParent.backgroundColor = COLOR.White
        
        //header theme
        viewHeader.backgroundColor = COLOR.Green
        
        imgBackground.image = UIImage.init(named: "header_bg")
        
        lblVCTitle.setVCTitle("Order Preferences")

        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        viewContent.isHidden = true
        scrollContent.setThemeForScrollView()
        
        tableViewObj.register(UINib(nibName: "PreferencesHeaderCell", bundle: nil), forCellReuseIdentifier: "PreferencesHeaderCell")
        tableViewObj.register(UINib(nibName: "PreferencesSelectionCell", bundle: nil), forCellReuseIdentifier: "PreferencesSelectionCell")
        tableViewObj.separatorStyle = .none
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.backgroundColor = COLOR.White
        tableViewObj.maskToBounds = false
        tableViewObj.isScrollEnabled = false

        btnSubmit.setThemeForAppButton("SAVE FOR ALL FUTURE ORDERS     ") // 5 Blank Space after text
        btnSubmit.addTarget(self, action: #selector(btnSubmitClick(_:)), for: .touchUpInside)
        
        lblButtonCircle.text = ""
        lblButtonCircle.backgroundColor = COLOR.White
        lblButtonCircle.setCornerRadius()
    }
    
    /*
     Function Name :- setDataOfViewController
     Function Parameters :- (nil)
     Function Description :- This function used to set the data for Controller initial screen values
     */
    func setDataOfViewController()
    {
        arrPreferences = { () -> NSMutableArray in
            let arrayMain : NSMutableArray = [
                ["title":"Preferred Detergent", "data":dicPreferences.value(forKey: get_all_servicesResponce.detergent) as! NSArray],
                ["title":"Bleach Whites?", "data": dicPreferences.value(forKey: get_all_servicesResponce.bleach) as! NSArray],
                ["title":"Fabric Softener?", "data":dicPreferences.value(forKey: get_all_servicesResponce.fabric_softner) as! NSArray]
                ]
            return arrayMain
        }()
        tableViewObj.reloadData()
        callMethodAfterDelay(funcName: #selector(setTableViewHeight))
        viewContent.isHidden = false
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }

    @IBAction func btnSubmitClick(_ sender: Any)
    {
        let service_id = NSMutableString()
        let category_id : String = { () -> String in
            let cate_id = NSMutableString()
            for i in 0..<arrPreferences.count
            {
                let array = NSArray(array: (arrPreferences[i] as! NSDictionary).value(forKey: "data") as! NSArray)
                let predicateSearch = NSPredicate(format: "\(get_all_servicesResponce.values.is_selected) == %d", 1)
                let arrayFilter = NSMutableArray(array: array.filtered(using: predicateSearch) as NSArray)
                if arrayFilter.count > 0
                {
                    let dic : NSDictionary = arrayFilter[0] as! NSDictionary
                    if service_id.length > 0
                    {
                        service_id.append(",\(dic.value(forKey: get_all_servicesResponce.values.additional_service_id)!)")
                        cate_id.append(",\(dic.value(forKey: get_all_servicesResponce.values.additional_service_category_id)!)")
                    }
                    else{
                        service_id.append("\(dic.value(forKey: get_all_servicesResponce.values.additional_service_id)!)")
                        cate_id.append("\(dic.value(forKey: get_all_servicesResponce.values.additional_service_category_id)!)")
                    }
                }
            }
            return cate_id as String
        }()
        
        if category_id.count > 0
        {
            processSetUserPreference(serviseID: service_id as String, CateID: category_id)
        }
        else{
            showMyAlertView(message: "Please select preference then submit.") { (action) in }
        }
    }

    @objc func setTableViewHeight()
    {
        consTableViewObjHeight.constant = tableViewObj.contentSize.height
    }
    
    //MARK:- API Call Funtions
    func processGetAllUserPreference()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetUserPreference, dictParameter: parameters as NSDictionary)
    }

    func processSetUserPreference(serviseID: String,CateID: String)
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID(),
                                         "additional_service_category_id":CateID,
                                         "additional_service_id":serviseID]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqAddPreference, dictParameter: parameters as NSDictionary)
    }

}
/*
 Extension Description :- Delegate method for table view.
 */
extension MyPreferencesVC : UITableViewDelegate, UITableViewDataSource
{
    //Diplay Header sections
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return arrPreferences.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "PreferencesHeaderCell") as! PreferencesHeaderCell
        cell.selectionStyle = .none
        cell.reloadData(dictionary: arrPreferences[section] as! NSDictionary)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let strTitle = (arrPreferences[section] as! NSDictionary).value(forKey: "title") as! String
        let height = CGFloat(calculateHeight(forLbl: strTitle, width: Float(tableView.frame.width - 30)))
        print("\(strTitle) Height is :- \(height)")
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE
        {
            return height + 12
        }
        else if (UIDevice.current.screenType == .iPhones_X_XS) || UIDevice.current.screenType == .iPhone_XR ||  UIDevice.current.screenType == .iPhone_XSMax
        {
            return height < 41 ? 40 : height + 20
        }
        else{
          return height < 41 ? 40 : height + 20
        }
    }
    
    //Diplay sections cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let array = NSArray(array: (arrPreferences[section] as! NSDictionary).value(forKey: "data") as! NSArray)
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "PreferencesSelectionCell") as! PreferencesSelectionCell
        cell.selectionStyle = .none
        let array = NSArray(array: (arrPreferences[indexPath.section] as! NSDictionary).value(forKey: "data") as! NSArray)
        
        cell.reloadData(dictionary: array[indexPath.row] as! NSDictionary)
        cell.btnChechUncheck.tag = indexPath.section
        cell.btnChechUncheck.addTarget(self, action: #selector(btnTableViewDidSelect(PreferencesSelectionCell:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let array : NSMutableArray = NSMutableArray(array: (arrPreferences[indexPath.section] as! NSDictionary).value(forKey: "data") as! NSArray)
        for i in 0..<array.count
        {
            let dic : NSMutableDictionary = NSMutableDictionary(dictionary: array[i] as! NSDictionary)
            if indexPath.row == i
            {
                dic.setValue(1, forKeyPath: get_all_servicesResponce.values.is_selected)
            }
            else{
                dic.setValue(0, forKeyPath: get_all_servicesResponce.values.is_selected)
            }
            array.replaceObject(at: i, with: dic)
        }
        let dic = NSMutableDictionary(dictionary: (arrPreferences[indexPath.section] as! NSDictionary))
        dic.setValue(array, forKey: "data")
        arrPreferences.replaceObject(at: indexPath.section, with: dic)
        tableViewObj.reloadData()
    }
    
    @IBAction func btnTableViewDidSelect(PreferencesSelectionCell sender:UIButton)
    {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableViewObj)
        let indexPath : IndexPath = self.tableViewObj.indexPathForRow(at:buttonPosition)!
        let array : NSMutableArray = NSMutableArray(array: (arrPreferences[indexPath.section] as! NSDictionary).value(forKey: "data") as! NSArray)
        for i in 0..<array.count
        {
            let dic : NSMutableDictionary = NSMutableDictionary(dictionary: array[i] as! NSDictionary)
            if indexPath.row == i
            {
                dic.setValue(1, forKeyPath: get_all_servicesResponce.values.is_selected)
            }
            else{
                dic.setValue(0, forKeyPath: get_all_servicesResponce.values.is_selected)
            }
            array.replaceObject(at: i, with: dic)
        }
        let dic = NSMutableDictionary(dictionary: (arrPreferences[indexPath.section] as! NSDictionary))
        dic.setValue(array, forKey: "data")
        arrPreferences.replaceObject(at: indexPath.section, with: dic)
        tableViewObj.reloadData()
    }
}
/*
Extension Description :- Delegate methods for the Response of API Calling
*/
extension MyPreferencesVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqGetUserPreference
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        dicPreferences = NSDictionary(dictionary: resKeyData)
                        setDataOfViewController()
                    }
                }
                else
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            if statusCode == aouthStatus
                            {
                                Application_Delegate.processLogout()
                            }
                        }
                    }
                }
            }
        }
        else if reqTask == reqAddPreference
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            self.goBackToViewController(ViewController: CleanMyClothesFirstVC.self)
                        }
                    }
                }
                else
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            if statusCode == aouthStatus
                            {
                                Application_Delegate.processLogout()
                            }
                        }
                    }
                }
            }
        }
    }
}
