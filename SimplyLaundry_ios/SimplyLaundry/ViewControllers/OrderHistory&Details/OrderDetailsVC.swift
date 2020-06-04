//
//  OrderDetailsVC.swift
//  SimplyLaundry
//
//  Created by webclues on 04/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class OrderDetailsVC: UIViewController {
    
    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnBack:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var scrollContent:UIScrollView!
    @IBOutlet weak var viewContent:UIView!
    
    @IBOutlet weak var viewPDFContent:UIView!
    @IBOutlet weak var lblPDFNote:UILabel!
    @IBOutlet weak var btnDownloadPDF:UIButton!
    @IBOutlet weak var consViewPDFContentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewOrderIdAndDate:UIView!
    @IBOutlet weak var lblOrderID:UILabel!
    @IBOutlet weak var lblOrderDate:UILabel!
    
    @IBOutlet weak var viewOrderDetails:UIView!
    @IBOutlet weak var lblPaymentMethodTitle:UILabel!
    @IBOutlet weak var lblPaymentMethod:UILabel!
    
    @IBOutlet weak var lblDriverTipTitle:UILabel!
    @IBOutlet weak var lblDriverTip:UILabel!
    
    @IBOutlet weak var lblPickupDateTitle:UILabel!
    @IBOutlet weak var lblPickupDate:UILabel!
    @IBOutlet weak var lblPickupTimeTitle:UILabel!
    @IBOutlet weak var lblPickupTime:UILabel!
    
    @IBOutlet weak var lblDropoffDateTitle:UILabel!
    @IBOutlet weak var lblDropoffDate:UILabel!
    @IBOutlet weak var lblDropoffTimeTitle:UILabel!
    @IBOutlet weak var lblDropoffTime:UILabel!

    @IBOutlet weak var viewPickupAddressParent:UIView!
    @IBOutlet weak var lblPickupAddressTitle:UILabel!
    @IBOutlet weak var lblPickupAddress:UILabel!
    @IBOutlet weak var consViewPickupAddressParentTop: NSLayoutConstraint!

    @IBOutlet weak var viewDeliveryAddressParent:UIView!
    @IBOutlet weak var lblDeliveryAddressTitle:UILabel!
    @IBOutlet weak var lblDeliveryAddressTwo:UILabel!
    
    @IBOutlet weak var viewServiceParent:UIView!
    @IBOutlet weak var lblServiceTitle:UILabel!
    @IBOutlet weak var lblServises:UILabel!
    
//    @IBOutlet weak var viewAddServicesParent:UIView!
//    @IBOutlet weak var lblAddServicesTitle:UILabel!
//    @IBOutlet weak var lblAddServices:UILabel!
    
    @IBOutlet weak var viewSpecialInstructionsParent:UIView!
    @IBOutlet weak var lblSpecialInstructionsTitle:UILabel!
    @IBOutlet weak var lblSpecialInstructions:UILabel!
    @IBOutlet weak var consViewSpecialInstructionsTop: NSLayoutConstraint!
    
    @IBOutlet weak var viewAddOrderHistoryParent:UIView!
    @IBOutlet weak var viewAddOrderHistory:UIView!
    @IBOutlet weak var lblAddOrderHistoryTitle:UILabel!
    @IBOutlet weak var viewOrderHistoryListingParent:UIView!
    @IBOutlet weak var tableViewOrderHistory:UITableView!
    @IBOutlet weak var consTableViewObjOrderHistoryHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewOrderTotalParent:UIView!
    @IBOutlet weak var viewOrderTotal:UIView!
    @IBOutlet weak var lblViewOrderTotalTitle:UILabel!
    
    @IBOutlet weak var viewOrderTotalDetails:UIView!
    @IBOutlet weak var lblDeliveryCostTitle:UILabel!
    @IBOutlet weak var lblDeliveryCost:UILabel!
    @IBOutlet weak var lblSubTotalTitle:UILabel!
    @IBOutlet weak var lblSubTotal:UILabel!
    @IBOutlet weak var lblTipTitle:UILabel!
    @IBOutlet weak var lblTip:UILabel!
    @IBOutlet weak var lblPromoCodeTitle:UILabel!
    @IBOutlet weak var lblPromoCode:UILabel!
    @IBOutlet weak var lblSepratorTwo:UILabel!
    @IBOutlet weak var lblOrderTotalTitle:UILabel!
    @IBOutlet weak var lblOrderTotal:UILabel!
    
    // Variable Declarations and Initlizations
    var dicOrderDetails :NSDictionary = NSDictionary()
    var arrOrderListing = NSArray()
    var strOrderID = String()
    var intScreenNo : Int = 1 //1: Order Detail, 2: Notification Order Details
    let documentInteractionController = UIDocumentInteractionController()

    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        processGetOrderDetails(OrderID: strOrderID)
        documentInteractionController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        
        //header theme
        viewHeader.backgroundColor = COLOR.Green
        
        imgBackground.image = UIImage.init(named: "header_bg")
        
        lblVCTitle.setVCTitle("Order Details")
        
        btnBack.setTitle("", for: .normal)
        btnBack.setImage(UIImage.init(named: "back"), for: .normal)
        btnBack.addTarget(self, action: #selector(btnBackClick(_:)), for: .touchUpInside)
        
        //Content theme
        scrollContent.setThemeForScrollView()
        viewContent.backgroundColor = COLOR.White
        viewContent.isHidden = true
        
        viewPDFContent.backgroundColor = COLOR.background_Gray
        lblPDFNote.text = "For complete Order Details"
        lblPDFNote.textColor = COLOR.Gray
        lblPDFNote.numberOfLines = 0
        lblPDFNote.lineBreakMode = .byWordWrapping
        lblPDFNote.font = UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)
        btnDownloadPDF.setTitle("  Download PDF", for: .normal)
        btnDownloadPDF.setTitleColor(COLOR.Red, for: .normal)
        btnDownloadPDF.setImage(UIImage.init(named: "pdf"), for: .normal)
        btnDownloadPDF.tintColor = COLOR.Red
        btnDownloadPDF.titleLabel?.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        btnDownloadPDF.addTarget(self, action: #selector(btnDownloadPDFClick(_:)), for: .touchUpInside)
        
        viewOrderIdAndDate.backgroundColor = COLOR.background_Gray
        lblOrderID.text = " "
        lblOrderID.font = UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_FOURTEEN)
        lblOrderDate.text = " "
        lblOrderDate.font = UIFont.init(name: SourceSansPro_Bold, size: FONT_SIZE_FOURTEEN)

        //Set Order Details Theme
        viewOrderDetails.backgroundColor = COLOR.White
        
        lblPaymentMethodTitle.setThemeForTitle("Payment Method:")
        lblPaymentMethod.setThemeForTitle(isTitle : false)
        
        lblDriverTipTitle.setThemeForTitle("Driver's Tip:")
        lblDriverTip.setThemeForTitle(isTitle : false)
        
        lblPickupDateTitle.setThemeForTitle("Pickup Date:")
        lblPickupDate.setThemeForTitle(isTitle : false)
        
        lblPickupTimeTitle.setThemeForTitle("Pickup Time:")
        lblPickupTime.setThemeForTitle(isTitle : false)

        lblDropoffDateTitle.setThemeForTitle("Drop-Off Date:")
        lblDropoffDate.setThemeForTitle(isTitle : false)
        
        lblDropoffTimeTitle.setThemeForTitle("Drop-Off Time:")
        lblDropoffTime.setThemeForTitle(isTitle : false)

        //Set Paymen And Delivery Address
        viewPickupAddressParent.backgroundColor = COLOR.White
        lblPickupAddressTitle.setThemeForUnderlineTitle("Pickup Address")
        lblPickupAddress.setThemeForTitle(isTitle : false, numberOfLines : 0)

        viewDeliveryAddressParent.backgroundColor = COLOR.White
        lblDeliveryAddressTitle.setThemeForUnderlineTitle("Delivery Address")
        lblDeliveryAddressTwo.setThemeForTitle(isTitle : false, numberOfLines : 0)
        
        //Set Service View Theme
        viewServiceParent.backgroundColor = COLOR.White
        lblServiceTitle.setThemeForUnderlineTitle("Services")
        lblServises.setThemeForTitle(isTitle : false, numberOfLines : 0)
        
        //Set Special Instructions
        viewSpecialInstructionsParent.backgroundColor = COLOR.White
        lblSpecialInstructionsTitle.setThemeForUnderlineTitle("Special Instructions")
        lblSpecialInstructions.setThemeForTitle(isTitle : false, numberOfLines : 0)
        
        viewAddOrderHistoryParent.backgroundColor = COLOR.White
        viewAddOrderHistory.backgroundColor = COLOR.background_Gray
        lblAddOrderHistoryTitle.setThemeForTitle( "Add Order History")
        //Order History Listing View Theme
        tableViewOrderHistory.register(UINib(nibName: "AddOrderHistoryXSLCell", bundle: nil), forCellReuseIdentifier: "AddOrderHistoryXSLCell")
        tableViewOrderHistory.separatorStyle = .none
        tableViewOrderHistory.delegate = self
        tableViewOrderHistory.dataSource = self
        tableViewOrderHistory.backgroundColor = COLOR.White
        tableViewOrderHistory.isScrollEnabled = false
        
        // Set Order Total Parent View Theme
        viewOrderTotalParent.backgroundColor = COLOR.White
        
        //Set Order Total View Theme
        viewOrderTotal.backgroundColor = COLOR.background_Gray
        lblViewOrderTotalTitle.setThemeForTitle("Final Order Total", textColor: COLOR.Balck, isTitle: false)

        //Set Order Total Details View Theme
        viewOrderTotalDetails.backgroundColor = COLOR.White
        
        lblSubTotalTitle.setThemeForTitle("Order Total")
        lblSubTotal.setThemeForTitle("")
        
        lblDeliveryCostTitle.setThemeForTitle("- Package Credits", isTitle : false)
        lblDeliveryCost.setThemeForTitle("", isTitle : false)
        
        lblTipTitle.setThemeForTitle("- User Credits", isTitle : false)
        lblTip.setThemeForTitle("", isTitle : false)
        
        lblPromoCodeTitle.setThemeForTitle("+ Extra Change", isTitle : false)
        lblPromoCode.setThemeForTitle("", isTitle : false)
        
        lblSepratorTwo.setThemeForSeprator()
        
        lblOrderTotalTitle.setThemeForTitle("Final Order Total")
        lblOrderTotal.setThemeForTitle("")

        setThemeAccrodingToScreen()
    }
    
    /*
     Function Name :- setThemeAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set a theme for Controller initial screen values
     */
    func setThemeAccrodingToScreen()
    {
        if intScreenNo == 2
        {
            btnBack.setImage(UIImage.init(named: "side_menu"), for: .normal)
        }
    }
    
    /*
     Function Name :- setDataAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set the data for Controller initial screen values
     */
    func setDataOfViewController()
    {
        reloadData(dictionary: dicOrderDetails.value(forKey: ResponceKey_order_data.order_data) as! NSDictionary)
        arrOrderListing = dicOrderDetails.value(forKey: ResponceKey_order_data.order_status) as! NSArray
        tableViewOrderHistory.isHidden = false
        tableViewOrderHistory.reloadData()
        callMethodAfterDelay(funcName: #selector(setTableViewHeight))
    }
    
    func reloadData(dictionary:NSDictionary)
    {
        // Set Download PDF View Display
        if "\(dictionary.value(forKey: ResponceKey_order_data.slug)!)"  == ResponceKey_order_data.slug_values.complete
        {
            consViewPDFContentHeight.priority = UILayoutPriority(rawValue: 250)
            viewPDFContent.isHidden = false
        }
        else{
            consViewPDFContentHeight.priority = UILayoutPriority(rawValue: 999)
            viewPDFContent.isHidden = true
        }
        //Set Attributed Order ID
        let attributedStrOrderID = NSMutableAttributedString(string: "Order ID : " , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Balck])
        let attributedStrOrderID1 = NSMutableAttributedString(string: "\(dictionary.value(forKey: ResponceKey_order_data.display_order_id)!)" , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
        attributedStrOrderID.append(attributedStrOrderID1)
        lblOrderID.attributedText = attributedStrOrderID

        //Set Attributed Order Date
        let strAddedDate : String = getDateFrom(string: "\(dictionary.value(forKey: ResponceKey_order_data.created_on)!)"
            , getDateFormate: "dd/MM/yyyy")
        let attributedStr = NSMutableAttributedString(string: "Date Added : " , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Semibold, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Balck])
        let attributedStr1 = NSMutableAttributedString(string: "\(strAddedDate)" , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)!, NSAttributedString.Key.foregroundColor : COLOR.Gray])
        attributedStr.append(attributedStr1)
        lblOrderDate.attributedText = attributedStr
        
        lblPaymentMethod.text = "\(dictionary.value(forKey: ResponceKey_order_data.payment_method)!)"
        lblDriverTip.text = "\(dictionary.value(forKey: ResponceKey_order_data.tip_percentage)!)%"
        
        let strPickupDate : String = getDateFrom(string: "\(dictionary.value(forKey: ResponceKey_order_data.pickup_date)!)", fromDateFormate: "yyyy-MM-dd", getDateFormate: "dd/MM/yyyy")
        lblPickupDate.text = "\(strPickupDate)"
        lblPickupTime.text = "\(dictionary.value(forKey: ResponceKey_order_data.pickup_time)!)"
        
        let strDropoffDate : String = getDateFrom(string: "\(dictionary.value(forKey: ResponceKey_order_data.delivery_date)!)", fromDateFormate: "yyyy-MM-dd", getDateFormate: "dd/MM/yyyy")
        lblDropoffDate.text = "\(strDropoffDate)"
        lblDropoffTime.text = "\(dictionary.value(forKey: ResponceKey_order_data.delivery_time)!)"

        lblPickupAddress.text = { () -> String in
            let string = "\(dictionary.value(forKey: ResponceKey_success_order.pickup_address)!)".split(separator: ",")
            
            var myAddress = "\(dictionary.value(forKey: ResponceKey_success_order.display_name)!)\n"
            for address in string
            {
                if address == string[string.count - 3]
                {
                    myAddress.append("\n\(address)")
                }
                else if address == string[string.count - 2]
                {
                    myAddress.append(",\(address)")
                }
                else if address == string[string.count - 1]
                {
                    myAddress.append(",\(address)")
                }
                else{
                    if address == string.first
                    {
                        myAddress.append("\(address)")
                    }
                    else{
                        myAddress.append(", \(address)")
                    }
                    
                }
            }
            
            return myAddress
        }()
        lblDeliveryAddressTwo.text = { () -> String in
            let string = "\(dictionary.value(forKey: ResponceKey_success_order.delivery_address)!)".split(separator: ",")
            
            var myAddress = "\(dictionary.value(forKey: ResponceKey_success_order.display_name)!)\n"
            for address in string
            {
                if address == string[string.count - 3]
                {
                    myAddress.append("\n\(address)")
                }
                else if address == string[string.count - 2]
                {
                    myAddress.append(",\(address)")
                }
                else if address == string[string.count - 1]
                {
                    myAddress.append(",\(address)")
                }
                else{
                    if address == string.first
                    {
                        myAddress.append("\(address)")
                    }
                    else{
                        myAddress.append(", \(address)")
                    }
                    
                }
            }
            
            return myAddress
        }()
        
        lblServises.text = { () -> String in
                let array = "\((dicOrderDetails.value(forKey: ResponceKey_order_data.order_data) as! NSDictionary).value(forKey: ResponceKey_order_data.service)!)".split(separator: ",")
                let strServices = NSMutableString()
                for i in 0..<array.count
                {
                    if i == 0{
                        strServices.append(" \(array[i])")
                    }
                    else{
                        strServices.append("\n\(array[i])")
                    }
                }
                return strServices as String
            }()
        
//        lblAddServices.text = { () -> String in
//            
//            return "Detergent : Basic - Scented $0 \nBleach : None $0 \nFabric Softnener : None $0"
//        }()
        lblSpecialInstructions.text = "\(dictionary.value(forKey: ResponceKey_order_data.special_instructions)!)"
        // Final Order Total view data
        lblSubTotal.text = "$\(dictionary.value(forKey: ResponceKey_order_data.order_total)!)"// Order Total
        lblDeliveryCost.text = "$\(dictionary.value(forKey: ResponceKey_order_data.package_credits)!)" //Package Credits
        lblTip.text = "$\(dictionary.value(forKey: ResponceKey_order_data.user_credits)!)" // User Credits
        lblPromoCode.text = "$\(dictionary.value(forKey: ResponceKey_order_data.extra_charge)!)" // Extra Charge
        lblOrderTotal.text = "$\(dictionary.value(forKey: ResponceKey_order_data.final_order_total)!)" // Final Order Total
        
        callMethodAfterDelay(funcName: #selector(setdata))

        Application_Delegate.showSpinnerView(isShow: false)
    }
    
    //MARK:- Button Actions
    @objc func setdata()
    {
        let dictionary = dicOrderDetails.value(forKey: "order_data") as! NSDictionary
        if "\(dictionary.value(forKey: ResponceKey_success_order.delivery_address_id)!)" == "\(dictionary.value(forKey: ResponceKey_success_order.pickup_address_id)!)"
        {
            consViewPickupAddressParentTop.constant = -(viewPickupAddressParent.bounds.height)
            viewPickupAddressParent.isHidden = true
            lblDeliveryAddressTitle.attributedText = NSAttributedString(string: "Pickup/Delivery Address", attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor : COLOR.Blue])
        }
        else{
            consViewPickupAddressParentTop.constant = 10
            viewPickupAddressParent.isHidden = false
        }
        
        if "\(dictionary.value(forKey: ResponceKey_order_data.special_instructions)!)" == ""
        {
            consViewSpecialInstructionsTop.constant = -(viewSpecialInstructionsParent.frame.height)
            viewSpecialInstructionsParent.isHidden = true
        }
        else{
            consViewSpecialInstructionsTop.constant = 10
            viewSpecialInstructionsParent.isHidden = false
        }
    }
    
    @IBAction func btnBackClick(_ sender: Any)
    {
        if intScreenNo == 1
        {
           self.navigationController?.popViewController(animated: true)
        }
        else if intScreenNo == 2
        {
            sideMenuController?.toggle()
        }
    }
    
    @IBAction func btnDownloadPDFClick(_ sender: Any)
    {
        processGetDownloadPDFLink()
    }
    
    @objc func setTableViewHeight()
    {
        consTableViewObjOrderHistoryHeight.constant = tableViewOrderHistory.contentSize.height
    }

    //MARK:- API Call Funtions
    func processGetOrderDetails(OrderID:String)
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["order_id":strOrderID]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqOrderDetail, dictParameter: parameters as NSDictionary)
    }
    
    func processGetDownloadPDFLink()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["order_id":strOrderID]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetInvoice, dictParameter: parameters as NSDictionary)
    }
}
/*
 Extension Description :- Delegate method for table view.
 */
extension OrderDetailsVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOrderListing.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOrderHistory.dequeueReusableCell(withIdentifier: "AddOrderHistoryXSLCell") as! AddOrderHistoryXSLCell
        cell.selectionStyle = .none
        if indexPath.row == 0
        {
            cell.reloadHeader()
        }
        else{
            cell.reloadData(dictionary: arrOrderListing[indexPath.row-1] as! NSDictionary)
        }
        return cell
    }
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension OrderDetailsVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        
        if reqTask == reqOrderDetail
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        dicOrderDetails = NSDictionary(dictionary: resKeyData)
                        self.setDataOfViewController()
                        viewContent.isHidden = false
                    }
                }
                else
                {
                    Application_Delegate.showSpinnerView(isShow: false)
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
        else if reqTask == reqGetInvoice
        {
            Application_Delegate.showSpinnerView(isShow: false)
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        if resKeyData.count > 0
                        {
                            storeAndShare(withURLString: "\(resKeyData.value(forKey: "invoice_url")!)")
                        }
                        else{
//                            storeAndShare(withURLString: "http://www.africau.edu/images/default/sample.pdf")
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

/*
 Extension Description :- Share a Document from iCoud
 */
extension OrderDetailsVC {
    /// This function will set all the required properties, and then provide a preview for the document
    func share(url: URL) {
        documentInteractionController.url = url
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
                .appendingPathComponent(response?.suggestedFilename ?? "fileName.png")
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

extension OrderDetailsVC: UIDocumentInteractionControllerDelegate {
    /// If presenting atop a navigation stack, provide the navigation controller in order to animate in a manner consistent with the rest of the platform
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        guard let navVC = self.navigationController else {
            return self
            
        }
        navVC.view.backgroundColor = COLOR.Green
        return navVC
    }
}
