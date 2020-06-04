//
//  PackagesVC.swift
//  SimplyLaundry
//
//  Created by webclues on 29/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class PackagesVC: UIViewController {
    
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
    var arrPackagesList = NSMutableArray()
    var selectedIndex : Int = 0
    var isUpdate : Bool = false
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        processGetAllCreditCard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if isUpdate == true
        {
            processGetAllCreditCard()
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
        
        lblVCTitle.setVCTitle("Packages")

        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        viewContent.isHidden = true
        
        //Order History Listing View Theme
        tableViewObj.register(UINib(nibName: "PackagesCell", bundle: nil), forCellReuseIdentifier: "PackagesCell")
        tableViewObj.separatorStyle = .none
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.backgroundColor = COLOR.White
        tableViewObj.isScrollEnabled = false
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }
    
    @IBAction func btnBuyPackagesClick(PackagesCell sender: UIButton)
    {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "BuyPackagesVC") as! BuyPackagesVC
        controller.delegate = self
        controller.dicPackagesDetails = arrPackagesList[sender.tag] as! NSDictionary
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func setTableViewHeight()
    {
        consTableViewObjHeight.constant = tableViewObj.contentSize.height
        viewContent.isHidden = false
        tableViewObj.isHidden = false
    }
    
    //MARK:- API Call Funtions
    func processGetAllCreditCard()
    {
        if Application_Delegate.navigationController.topViewController is PackagesVC
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetPackages, dictParameter: parameters as NSDictionary)
    }
}
/*
 Extension Description :- Delegate method for table view.
 */
extension PackagesVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPackagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "PackagesCell") as! PackagesCell
        cell.selectionStyle = .none
        cell.reloadPackages(dictionary: arrPackagesList[indexPath.row] as! NSDictionary)
        cell.btnSubmit.tag = indexPath.row
        cell.btnSubmit.addTarget(self, action: #selector(btnBuyPackagesClick(PackagesCell:)), for: .touchUpInside)
        return cell
    }
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension PackagesVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqGetPackages
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSArray = responseData.value(forKey: ResKeyData) as? NSArray
                    {
                        arrPackagesList = NSMutableArray(array: resKeyData)
                        tableViewObj.reloadData()
                        callMethodAfterDelay(funcName: #selector(setTableViewHeight))
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
 Extension Description :- Delegate method for buy package.
 */
extension PackagesVC : BuyPackagesVCDelegate
{
    @objc func updatePackages()
    {
        isUpdate = true
        viewContent.isHidden = true
    }
}
