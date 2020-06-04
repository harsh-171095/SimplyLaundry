//
//  MyPackagesVC.swift
//  SimplyLaundry
//
//  Created by webclues on 29/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class MyPackagesVC: UIViewController {
    
    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    @IBOutlet weak var lblNoData:UILabel!
    
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
    var dicPackages = NSDictionary()
    var arrPackagesList = NSMutableArray()
    var selectedIndex : Int = 0
    var intOffset : Int = -5
    var isPaging : Bool = true
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        Application_Delegate.showSpinnerView(isShow: true)
        processGetMyPackages()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
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
        
        lblNoData.text = "No Package Available"
        lblNoData.textColor = COLOR.Green
        lblNoData.textAlignment = .center
        lblNoData.isHidden = true
        lblNoData.numberOfLines = 0
        lblNoData.lineBreakMode = .byWordWrapping
        lblNoData.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_SIXTEEN)
        
        //header theme
        viewHeader.backgroundColor = COLOR.Green
        
        imgBackground.image = UIImage.init(named: "header_bg")
        
        lblVCTitle.setVCTitle("My Packages")
        
        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        viewContent.isHidden = true
        
        //Order History Listing View Theme
        tableViewObj.register(UINib(nibName: "MyPackagesCell", bundle: nil), forCellReuseIdentifier: "MyPackagesCell")
        tableViewObj.register(UINib(nibName: "ServicesCell", bundle: nil), forCellReuseIdentifier: "ServicesCell")
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
    func setDataFromViewController()
    {
        arrPackagesList = { () -> NSMutableArray in
            let array = NSMutableArray()
            if dicPackages.count > 0
            {
                if dicPackages.value(forKey: ResponceKey_pack_detail.active_package) != nil
                {
                    if (dicPackages.value(forKey: ResponceKey_pack_detail.active_package) as! NSDictionary).count > 0
                    {
                       array.add(["title":"Active Package",ResKeyData:[dicPackages.value(forKey: ResponceKey_pack_detail.active_package) as! NSDictionary]])
                    }
                }
                if dicPackages.value(forKey: ResponceKey_pack_detail.history_package) != nil
                {
                    if (dicPackages.value(forKey: ResponceKey_pack_detail.history_package) as! NSArray).count > 0
                    {
                        if intOffset == 0
                        {
                            array.add(["title":"Packages History",ResKeyData:dicPackages.value(forKey: ResponceKey_pack_detail.history_package) as! NSArray])
                        }
                        else{
                            let arrayHistory = NSArray(array: dicPackages.value(forKey: ResponceKey_pack_detail.history_package) as! NSArray)
                            let arrData = NSMutableArray(array: (arrPackagesList[1] as! NSDictionary).value(forKey: ResKeyData) as! NSArray)
                            if  arrayHistory.count > 0
                            {
                                for i in 0..<arrayHistory.count
                                {
                                    arrData.add(arrayHistory[i])
                                }
                                isPaging = true
                            }
                            else{
                                isPaging = false
                            }
                            array.add(["title":"Packages History",ResKeyData:arrData])
                        }

                    }
                    else{
                        if arrPackagesList.count > 0
                        {
                            let arrData = NSMutableArray(array: (arrPackagesList[1] as! NSDictionary).value(forKey: ResKeyData) as! NSArray)
                            if arrData.count > 0
                            {
                                array.add(["title":"Packages History",ResKeyData:arrData])
                            }
                        }
                        isPaging = false
                    }
                }
            }
            return array
        }()
        if arrPackagesList.count > 0
        {
            tableViewObj.isHidden = false
            lblNoData.isHidden = true
        }
        else{
            tableViewObj.isHidden = true
            lblNoData.isHidden = false
        }
        tableViewObj.reloadData()
        callMethodAfterDelay(funcName: #selector(setTableViewHeight))
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }
    
    @IBAction func btnCancelPackageClick(MyPackagesCell sender: UIButton)
    {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableViewObj)
        let indexPath : IndexPath = self.tableViewObj.indexPathForRow(at:buttonPosition)!
        let dic = ((arrPackagesList[indexPath.section] as! NSDictionary).value(forKey: ResKeyData) as! NSArray)[indexPath.row] as! NSDictionary

        
        showMyAlertView(message: "Are you sure you want to cancel this package?", title: [Alert_no,Alert_yes]) { (action) in
            if action.title == Alert_yes
            {
                self.processDeletePackage(packageID: "\(dic.value(forKey: ResponceKey_pack_detail.user_package_id)!)")
            }
        }
    }
    
    @objc func setTableViewHeight()
    {
        consTableViewObjHeight.constant = tableViewObj.contentSize.height
        viewContent.isHidden = false
        tableViewObj.isHidden = false
        if  self.intOffset == 0
        {
            tableViewObj.reloadData()
        }
    }
    
    //MARK:- API Call Funtions
    func processGetMyPackages()
    {
        intOffset += 5
        if intOffset == 0
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID(),"offset":intOffset]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqPackDetail, dictParameter: parameters as NSDictionary)
    }
    
    func processDeletePackage(packageID ID:String)
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID(),"package_id":ID]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqDeletePackage, dictParameter: parameters as NSDictionary)
    }
}
/*
 Extension Description :- Delegate method for table view.
 */
extension MyPackagesVC : UITableViewDelegate, UITableViewDataSource
{
    //Diplay Header sections
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return arrPackagesList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "ServicesCell") as! ServicesCell
        cell.selectionStyle = .none
        cell.reloadMyPackagesHeaderData(dictionary: arrPackagesList[section] as! NSDictionary)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 35
    }

    //Diplay sections cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = (arrPackagesList[section] as! NSDictionary).value(forKey: ResKeyData) as! NSArray
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "MyPackagesCell") as! MyPackagesCell
        cell.selectionStyle = .none
        let array = (arrPackagesList[indexPath.section] as! NSDictionary).value(forKey: ResKeyData) as! NSArray
        
        cell.setPackagesDeatils(dictionary: array[indexPath.row] as! NSDictionary)
        cell.btnCancelPackage.tag = indexPath.row
        cell.btnCancelPackage.addTarget(self, action: #selector(btnCancelPackageClick(MyPackagesCell:)), for: .touchUpInside)
        cell.btnDownloadPackageInvoice.indexPath = indexPath
        cell.btnDownloadPackageInvoice.addTarget(self, action: #selector(btnDownloadPackageInvoice_click(MyPackagesCell:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1
        {
            let histryCount = ((arrPackagesList[1] as! NSDictionary).value(forKey: ResKeyData) as! NSArray).count
            if indexPath.row == (histryCount - 1)
            {
                if isPaging == true
                {
                    processGetMyPackages()
                    isPaging = false
                }
            }
        }
    }
    
    @IBAction func btnDownloadPackageInvoice_click(MyPackagesCell sender : HGButton){
        let indexPath = sender.indexPath
        let array = (arrPackagesList[indexPath!.section] as! NSDictionary).value(forKey: ResKeyData) as! NSArray
        let strUserPackageId = "\((array[indexPath!.row] as! NSDictionary).value(forKey: "user_package_id")!)"
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_package_id":strUserPackageId]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGeneratePDF, dictParameter: parameters as NSDictionary)
    }
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension MyPackagesVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqPackDetail
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        dicPackages = resKeyData
                    }
                    setDataFromViewController()
                }
                else
                {
                   setDataFromViewController()
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        if statusCode == aouthStatus
                        {
                            showMyAlertView(message: message) { (action) in
                                Application_Delegate.processLogout()
                            }
                        }
                        
                    }
                }
            }
        }
        else if reqTask == reqDeletePackage
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in
                            self.intOffset = -5
                            self.processGetMyPackages()
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
        else if reqTask == reqGeneratePDF
        {
            Application_Delegate.showSpinnerView(isShow: true)
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : String = responseData.value(forKey: ResKeyData) as? String
                    {
                        storeAndShare(withURLString: resKeyData)
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

extension MyPackagesVC {
    /// This function will set all the required properties, and then provide a preview for the document
    func share(url: URL) {
        let documentInteractionController = UIDocumentInteractionController()
        documentInteractionController.url = url
        documentInteractionController.delegate = self
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentPreview(animated: true)
    }
    
    /// This function will store your document to some temporary URL and then provide sharing, copying, printing, saving options to the user
    func storeAndShare(withURLString: String) {
        guard let url = URL(string: withURLString) else { return }
        /// START YOUR ACTIVITY INDICATOR HERE
        Application_Delegate.showSpinnerView(isShow: true)
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? "fileName.pdf")
            do {
                try data.write(to: tmpURL)
            } catch {
                Application_Delegate.showSpinnerView(isShow: false)
                print(error)
            }
            DispatchQueue.main.async {
                Application_Delegate.showSpinnerView(isShow: false)
                /// STOP YOUR ACTIVITY INDICATOR HERE
                self.share(url: tmpURL)
            }
            }.resume()
    }
}

extension MyPackagesVC: UIDocumentInteractionControllerDelegate {
    /// If presenting atop a navigation stack, provide the navigation controller in order to animate in a manner consistent with the rest of the platform
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        guard let navVC = self.navigationController else {
            return self
            
        }
        navVC.view.backgroundColor = COLOR.Green
        return navVC
    }
}
