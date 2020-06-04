//
//  OrderHistoryViewController.swift
//  SimplyLaundry
//
//  Created by webclues on 04/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit
import DropDown
import StoreKit
class OrderHistoryVC: UIViewController
{
    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    @IBOutlet weak var lblNotData:UILabel!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnManu:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var viewContent:UIView!
    
    @IBOutlet weak var tableViewObj:UITableView!

    //Repeat Order view outlet's
    @IBOutlet weak var viewRepeatOrderPerent:UIView!
    @IBOutlet weak var viewRepeatOrder:UIView!
    @IBOutlet weak var lblRepeatOrderTitle:UILabel!
    @IBOutlet weak var btnCancelRepeatOrder:UIButton!
    @IBOutlet weak var viewRepeatOrderOptionPerent:UIView!
    @IBOutlet weak var lblRepeatOrderOptionParentTitle:UILabel!
    @IBOutlet weak var viewRepeatOrderOption:UIView!
    @IBOutlet weak var imgRepeatOrderOption:UIImageView!
    @IBOutlet weak var txtRepeatOrderOption:UITextField!
    @IBOutlet weak var btnRepeatOrderOption:UIButton!
    @IBOutlet weak var btnRepeatOrder:UIButton!
    
    // Variable Declarations and Initlizations
    var pullRefresh : UIRefreshControl = UIRefreshControl()

    var intPageNo : Int = 0
    var intTotalPages : Int = 0
    var intNumberOfRow : Int = 0
    var intSelectRow : Int = -1
    var arrListing = NSMutableArray()
    
    var dictSelectedOrder: NSDictionary! = NSDictionary()
    var intSelectedRepeatOrder: Int = 0
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        processGetOrderHistroy()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        lblNotData.text = "No Data Available"
        lblNotData.textColor = COLOR.Green
        lblNotData.textAlignment = .center
        lblNotData.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_SIXTEEN)
        lblNotData.isHidden = true
        
        //header theme
        viewHeader.backgroundColor = COLOR.Green
        
        imgBackground.image = UIImage.init(named: "header_bg")
        
        lblVCTitle.setVCTitle("My Orders")

        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        
        tableViewObj.register(UINib(nibName: "OrderHistoryCell", bundle: nil), forCellReuseIdentifier: "OrderHistoryCell")
        tableViewObj.separatorStyle = .none
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.backgroundColor = COLOR.White
        
        pullRefresh.addTarget(self, action: #selector(self.pullRefreshView), for: .valueChanged)
        pullRefresh.tintColor = UIColor.clear
        tableViewObj!.addSubview(pullRefresh)
        tableViewObj!.alwaysBounceVertical = true
        tableViewObj!.bounces = true

        //Repeat Order popup
        viewRepeatOrderPerent.backgroundColor = COLOR.Balck.withAlphaComponent(0.5)
        viewRepeatOrderPerent.isHidden = true

        viewRepeatOrder.backgroundColor = COLOR.White
        viewRepeatOrder.setCornerRadius(corner:5)
        
        lblRepeatOrderTitle.text = "Repeat Order"
        lblRepeatOrderTitle.textColor = COLOR.Gray
        lblRepeatOrderTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_TWENTY)
        
        btnCancelRepeatOrder.setTitle("", for: .normal)
        btnCancelRepeatOrder.setImage(UIImage.init(named: "cancel_popup"), for: .normal)
        btnCancelRepeatOrder.tintColor = COLOR.Gray
        btnCancelRepeatOrder.addTarget(self, action: #selector(btnCancelRepeatOrderPopupPressed(_:)), for: .touchUpInside)
        
        viewRepeatOrderOptionPerent.backgroundColor = COLOR.clear
        lblRepeatOrderOptionParentTitle.setThemeForTextFiledTitle("Select Frequency")
        viewRepeatOrderOption.backgroundColor = COLOR.background_Gray
        viewRepeatOrderOption.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: 5)
        txtRepeatOrderOption.setThemeFor("Select Frequency", returnKeyType : .default)
        imgRepeatOrderOption.image = UIImage.init(named: "down_arrow")
        
        btnRepeatOrderOption.setTitle("", for: .normal)
        btnRepeatOrderOption.addTarget(self, action: #selector(btnRepeatOrderOptionPressed(_:)), for: .touchUpInside)
        
        btnRepeatOrder.setThemeForAppButton("Repeat Order")
        btnRepeatOrder.addTarget(self, action: #selector(btnRepeatOrderPressed(_:)), for: .touchUpInside)
    }
    
    /*
     Function Name :- setDataOfViewController
     Function Parameters :- (nil)
     Function Description :- This function used to set the data for Controller initial screen values
     */
    func setDataOfViewController()
    {       
        if arrListing.count > 0
        {
            tableViewObj.isHidden = false
            tableViewObj.reloadData()
            lblNotData.isHidden = true
        }
        else
        {
            tableViewObj.isHidden = true
            lblNotData.isHidden = false
        }
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }

    @objc func pullRefreshView()
    {
        pullRefresh.endRefreshing()
        arrListing.removeAllObjects()
        tableViewObj.reloadData()
        intPageNo = 0
        processGetOrderHistroy()
    }
    
    @IBAction func btnRepeatOrderPressed(_ sender: Any)
    {
        viewRepeatOrderPerent.isHidden = true
        processChangeOrderStatus("\(dictSelectedOrder.value(forKey: ResponceKey_order_data.order_id)!)", "\(dictSelectedOrder.value(forKey: ResponceKey_order_data.is_repeat)!)", isRepeatType: "\(intSelectedRepeatOrder)")
    }
    
    @IBAction func btnCancelRepeatOrderPopupPressed(_ sender: Any)
    {
        viewRepeatOrderPerent.isHidden = true
    }
    
    @IBAction func btnRepeatOrderOptionPressed(_ sender: Any)
    {
        
        self.view.endEditing(true)
        initDropDown(dataSource: arrRepeatOrder, textFiled: txtRepeatOrderOption) { (index, value) in
            self.intSelectedRepeatOrder = index + 1
        }
    }
    
    //MARK:- API Call Funtions
    func processGetOrderHistroy()
    {
        intPageNo = intPageNo + 1
        if intPageNo == 1
        {
            Application_Delegate.showSpinnerView(isShow: true)
        }
        let parameters : [String:Any] = ["user_id":getUserID(),"page":intPageNo]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqOrderHistory, dictParameter: parameters as NSDictionary)
    }

    func processChangeOrderStatus(_ OrderID:String,_ status:String, isRepeatType: String = String())
    {
        Application_Delegate.showSpinnerView(isShow: true)
        
        var parameters : [String:Any]
        if isRepeatType == ""
        {
            parameters = ["order_id":OrderID,"is_repeat":status]
        }
        else
        {
            parameters = ["order_id":OrderID,"is_repeat":status, "is_repeat_order_type":isRepeatType]
        }
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqChangeOrderStatus, dictParameter: parameters as NSDictionary)
    }
    
    func processToCancelOrder(_ orderID:String)
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["order_id":orderID]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqCancelOrder, dictParameter: parameters as NSDictionary)
    }
}
/*
 Extension Description :- Delegate method for table view.
 */
extension OrderHistoryVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrListing.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "OrderHistoryCell") as! OrderHistoryCell
        cell.selectionStyle = .none
        cell.reloadData(dictionary: arrListing[indexPath.row] as! NSDictionary)
        
        cell.btnOne.tag = indexPath.row
        cell.btnOne.addTarget(self, action: #selector(btnChangeOrderStausClick(OrderDetailsVC:)), for: .touchUpInside)
        cell.btnTwo.tag = indexPath.row
        cell.btnTwo.addTarget(self, action: #selector(btnCancelRepeatOrderClick(OrderDetailsVC:)), for: .touchUpInside)
        cell.btnCancelOrder.tag = indexPath.row
        cell.btnCancelOrder.addTarget(self, action: #selector(btnCancelOrderClick(OrderDetailsVC:)), for: .touchUpInside)
        cell.btnDuplicateOrder.tag = indexPath.row
        cell.btnDuplicateOrder.addTarget(self, action: #selector(btnDuplicateOrderClick(OrderDetailsVC:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contoller = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsVC") as! OrderDetailsVC
        contoller.strOrderID = "\((arrListing[indexPath.row] as! NSDictionary).value(forKey: ResponceKey_order_data.order_id)!)"
        self.navigationController?.pushViewController(contoller, animated: true)        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (arrListing.count-1) == indexPath.row{
            if intPageNo < intTotalPages
            {
                if arrListing.count < intNumberOfRow
                {
                    processGetOrderHistroy()
                }
            }
        }
    }

    @IBAction func btnCancelOrderClick(OrderDetailsVC sender:UIButton)
    {
        intSelectRow = sender.tag
        let dic = arrListing[intSelectRow] as! NSDictionary
        showMyAlertView(message: "Are you sure you want to cancel this order?", title: [Alert_no,Alert_yes]) { (action) in
            if action.title == Alert_yes
            {
                self.processToCancelOrder("\(dic.value(forKey: ResponceKey_order_data.order_id)!)")
            }
        }
    }
    
    @IBAction func btnDuplicateOrderClick(OrderDetailsVC sender:UIButton)
    {
        intSelectRow = sender.tag
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CleanMyClothesFirstVC") as! CleanMyClothesFirstVC
        controller.screenName = .dublicateOrder
        controller.strOrderId = (arrListing[sender.tag] as! NSDictionary)[ResponceKey_order_data.order_id] as? String ?? ""
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    @IBAction func btnChangeOrderStausClick(OrderDetailsVC sender:UIButton)
    {
        intSelectRow = sender.tag
        let dic = arrListing[intSelectRow] as! NSDictionary
        
        if "\(dic.value(forKey: ResponceKey_order_data.is_repeat)!)" == "0" // No-Repeat Order
        {
            dictSelectedOrder = dic
            viewRepeatOrderPerent.isHidden = false
            intSelectedRepeatOrder = 1
            txtRepeatOrderOption.text = "Every Week"
        }
        else
        {
            processChangeOrderStatus("\(dic.value(forKey: ResponceKey_order_data.order_id)!)", "\(dic.value(forKey: ResponceKey_order_data.is_repeat)!)",isRepeatType: "\(dic.value(forKey: ResponceKey_order_data.is_repeat_order_type)!)")
        }
    }
    
    @IBAction func btnCancelRepeatOrderClick(OrderDetailsVC sender:UIButton)
    {
        intSelectRow = sender.tag
        let dic = arrListing[intSelectRow] as! NSDictionary
        processChangeOrderStatus("\(dic.value(forKey: ResponceKey_order_data.order_id)!)", "3")
    }
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension OrderHistoryVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqOrderHistory
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSArray = responseData.value(forKey: ResKeyData) as? NSArray
                    {
                        intNumberOfRow = responseData.value(forKey: "total_rows") as! Int
                        intTotalPages = responseData.value(forKey: "pages") as! Int
                        resKeyData.forEach({ (data) in
                            self.arrListing.add(data)
                        })
                        self.setDataOfViewController()
                        viewContent.isHidden = false
                    }
                }
                else
                {
                    self.setDataOfViewController()
                    viewContent.isHidden = false
                }
            }
        }
        else if reqTask == reqChangeOrderStatus
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        let dic : NSMutableDictionary = NSMutableDictionary(dictionary: arrListing[intSelectRow] as! NSDictionary)
                        dic.setValue(resKeyData.value(forKey: ResponceKey_order_data.is_repeat)!, forKey: ResponceKey_order_data.is_repeat)
                        dic.setValue(resKeyData.value(forKey: ResponceKey_order_data.is_repeat_order_type)!, forKey: ResponceKey_order_data.is_repeat_order_type)
                        arrListing.replaceObject(at: intSelectRow, with: dic)
                        tableViewObj.reloadRows(at: [IndexPath(row: intSelectRow, section: 0)], with: .none)
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
        else if reqTask == reqCancelOrder
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        let dic : NSMutableDictionary = NSMutableDictionary(dictionary: arrListing[intSelectRow] as! NSDictionary)
                        dic.setValue(resKeyData.value(forKey: ResponceKey_order_data.order_status)!, forKey: ResponceKey_order_data.order_status)
                        dic.setValue(resKeyData.value(forKey: ResponceKey_order_data.cancel_order_status)!, forKey: ResponceKey_order_data.cancel_order_status)
                        dic.setValue(resKeyData.value(forKey: ResponceKey_order_data.slug)!, forKey: ResponceKey_order_data.slug)
                        
                        arrListing.replaceObject(at: intSelectRow, with: dic)
                        tableViewObj.reloadRows(at: [IndexPath(row: intSelectRow, section: 0)], with: .none)
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
