//
//  MyAddressListVC.swift
//  SimplyLaundry
//
//  Created by webclues on 07/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit


class MyAddressListVC: UIViewController {
    
    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnManu:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var viewContent:UIView!

    @IBOutlet weak var tableViewObj:UITableView!
    @IBOutlet weak var consTableViewObjHeight: NSLayoutConstraint!

    // Variable Declarations and Initlizations
    var arrAddressList = NSMutableArray()
    var selectedIndex : Int = 0
    var intIndexRow : Int = -1
    var isUpdate : Bool = false
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        if arrAddressMain.count > 0
        {
            arrAddressList = NSMutableArray(array: arrAddressMain)
            setDataOfViewController()
        }
        else{
            processGetAddressList()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if isUpdate == true
        {
          processGetAddressList()
        }
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
        
        lblVCTitle.setVCTitle("My Address")

        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        viewContent.isHidden = true
        
        //Order History Listing View Theme
        tableViewObj.register(UINib(nibName: "MyAddressListCell", bundle: nil), forCellReuseIdentifier: "MyAddressListCell")
        tableViewObj.register(UINib(nibName: "AddAddressCell", bundle: nil), forCellReuseIdentifier: "AddAddressCell")
        tableViewObj.separatorStyle = .none
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.backgroundColor = COLOR.White
        tableViewObj.isScrollEnabled = false
    }
    
    /*
     Function Name :- setDataAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set the data for Controller initial screen values
     */
    func setDataOfViewController()
    {
        tableViewObj.reloadData()
        callMethodAfterDelay(funcName: #selector(setTableViewHeight))
        viewContent.isHidden = false
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }
    
    @IBAction func btnEditAddressClick(MyAddressListCell sender:UIButton)
    {
        let controler = self.storyboard?.instantiateViewController(withIdentifier: "RagistrationsSecondVC") as! RagistrationsSecondVC
        controler.delegate = self
        controler.screenNo = 3
        controler.dicAddress = arrAddressList[sender.tag] as! NSDictionary
        self.navigationController?.pushViewController(controler, animated: true)
    }
    
    @IBAction func btnDeleteAddressClick(MyAddressListCell sender:UIButton)
    {
        let dic = arrAddressList[sender.tag] as! NSDictionary
        if "\(dic.value(forKey: "is_default")!)" == "1"
        {
            showMyAlertView(message: "You cannot delete default address.\n Please select another address as default, then delete it."){ (action) in }
        }
        else{
            showMyAlertView(message: "Are you sure you want to delete this address?",title: [Alert_cancel,Alert_Ok]) { (action) in
                if action.title == Alert_Ok
                {
                    self.intIndexRow = sender.tag
                    self.processDeleteAddress(addressID: "\(dic.value(forKey: "address_id")!)")
                }
            }
        }
    }
    
    @IBAction func btnCheckUnCheckAddressClick(MyAddressListCell sender:UIButton)
    {
        if selectedIndex != sender.tag
        {
            selectedIndex = sender.tag
            let strAddressID = "\((arrAddressList[selectedIndex] as! NSDictionary).value(forKey: "address_id")!)"
            processSetDefaultAddress(addressID: strAddressID)
        }
    }
    
    @IBAction func btnAddAddressClick(AddAddressCell sender: UIButton)
    {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RagistrationsSecondVC") as! RagistrationsSecondVC
        controller.delegate = self
        controller.screenNo = 2
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func setTableViewHeight()
    {
        consTableViewObjHeight.constant = tableViewObj.contentSize.height + 60
        isUpdate = false
    }
    
    //MARK:- API Call Funtions
    func processGetAddressList()
    {
        if Application_Delegate.navigationController.topViewController is MyAddressListVC
        {
          Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetAllMyAddress, dictParameter: parameters as NSDictionary,isHeader: false)
        
    }

    func processSetDefaultAddress(addressID : String)
    {
        if Application_Delegate.navigationController.topViewController is MyAddressListVC
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID(),"address_id":addressID]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqSetDefaultAddress, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    func processDeleteAddress(addressID : String)
    {
        if Application_Delegate.navigationController.topViewController is MyAddressListVC
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID(),"address_id":addressID]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqDeleteAddress, dictParameter: parameters as NSDictionary,isHeader: false)
    }
}
/*
 Extension Description :- Delegate method for table view.
 */
extension MyAddressListVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrAddressList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrAddressList.count == indexPath.row
        {
            let cell = tableViewObj.dequeueReusableCell(withIdentifier: "AddAddressCell") as! AddAddressCell
            cell.selectionStyle = .none
            cell.btnAddAddress.setTitle("ADD ADDRESS     ", for: .normal) // 5 Blank Space after text
            cell.btnAddAddress.tag = indexPath.row
            cell.btnAddAddress.addTarget(self, action: #selector(btnAddAddressClick(AddAddressCell:)), for: .touchUpInside)
            return cell
        }
        else{
            let cell = tableViewObj.dequeueReusableCell(withIdentifier: "MyAddressListCell") as! MyAddressListCell
            cell.selectionStyle = .none
            cell.reloadData(dictionary: arrAddressList[indexPath.row] as! NSDictionary)
            cell.btnCheckUncheck.tag = indexPath.row
            cell.btnCheckUncheck.addTarget(self, action: #selector(btnCheckUnCheckAddressClick(MyAddressListCell:)), for: .touchUpInside)
            cell.btnEdit.tag = indexPath.row
            cell.btnEdit.addTarget(self, action: #selector(btnEditAddressClick(MyAddressListCell:)), for: .touchUpInside)
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(btnDeleteAddressClick(MyAddressListCell:)), for: .touchUpInside)
            if "\((arrAddressList[indexPath.row] as! NSDictionary).value(forKey: ResponceKey_get_all_credit_card.dataValues.is_default)!)" == "1"
            {
                selectedIndex = indexPath.row
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrAddressList.count != indexPath.row
        {
            let btn = UIButton()
            btn.tag = indexPath.row
            btnCheckUnCheckAddressClick(MyAddressListCell: btn)
        }
    }
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension MyAddressListVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqGetAllMyAddress
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let responseKeyData : NSArray = responseData.value(forKey: ResKeyData) as? NSArray
                    {
                        self.arrAddressList = NSMutableArray(array: responseKeyData)
                        arrAddressMain = NSArray(array: responseKeyData)
                        self.setDataOfViewController()
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
        else if reqTask == reqSetDefaultAddress
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    processGetAddressList()
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
        else if reqTask == reqDeleteAddress
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    arrAddressList.removeObject(at: intIndexRow)
                    tableViewObj.reloadData()
                    arrAddressMain = NSArray(array: arrAddressList)
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in }
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
/*
 Extension Description :- Delegate methods for the add new address response
 */
extension MyAddressListVC : RagistrationsSecondVCDelegate
{
    @objc func updateAddress()
    {
        isUpdate = true
    }
}
