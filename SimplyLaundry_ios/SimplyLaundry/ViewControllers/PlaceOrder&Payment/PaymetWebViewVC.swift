//
//  PaymetWebViewVC.swift
//  SimplyLaundry
//
//  Created by webclues on 28/02/19.
//  Copyright © 2019 webclues. All rights reserved.
//
import Foundation
import UIKit

class PaymetWebViewVC: UIViewController {
    
    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnManu:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var viewContent:UIView!
    @IBOutlet weak var webViewContent:UIWebView!
    
    // Variable Declarations and Initlizations
    var intScreenNo : Int = 1 // 1 : PrivacyPolicy, 2 : FAQ's, 3 : Terms&Condition
    var dicCleanClothInfo = NSMutableDictionary()
    var dicPaypalToken = NSDictionary()
    var strPaypalURL = String()
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        processOfScreen()
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
        
        lblVCTitle.setVCTitle("Clean My Clothes")
        
        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "back"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        webViewContent.backgroundColor = COLOR.White
        webViewContent.delegate = self
    }
    
    func processOfScreen()
    {
        let url: URL = URL(string: strPaypalURL)!
        webViewContent.loadRequest(URLRequest(url: url))
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        webViewContent.delegate = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- API Call Funtions
    func processPlaceOrder()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqPlaceOrder, dictParameter: dicCleanClothInfo)
    }
}
/*
Extension Description :- Delegate methods for the Response of API Calling
*/
extension PaymetWebViewVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqPlaceOrder
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        let controller = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "SuccessOrderVC") as! SuccessOrderVC
                        controller.dicOrderDetails = resKeyData
                        Application_Delegate.navigationController.pushViewController(controller, animated: true)
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
    
    func processGetBillingID(BA_tokan:String)
    {
        Application_Delegate.showSpinnerView(isShow: true)
        btnManu.isUserInteractionEnabled = false
        callPaypalLoginURL(URL: getAgreements, body: ["token_id":BA_tokan], dicHeaderData: dicPaypalToken) { (responceData) in
            if let strBillingId : String = responceData.value(forKey: "id") as? String
            {
                DispatchQueue.main.async {
                    self.dicCleanClothInfo.setValue(strBillingId, forKey: RequestParameters_place_order.billing_agreement_id)
                    self.processPlaceOrder()
                }
            }
        }
    }
}
/*
 Extension Description :- Delegate methods for web view.
 */
extension PaymetWebViewVC: UIWebViewDelegate
{
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        print("webViewDidStartLoad:- \(webView.request!.url!.absoluteString)")
        Application_Delegate.showSpinnerView(isShow: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        print("webViewDidFinishLoad:- \(webView.request!.url!.absoluteString)")
        if (webView.request!.url!.absoluteString.range(of:"paypal_success.php") == nil)
        {
             Application_Delegate.showSpinnerView(isShow: false)
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool
    {
        print("shouldStartLoadWith:- \(request.url!.absoluteString)")
        if (request.url?.absoluteString.range(of:"paypal_success.php") != nil)
        {
            print("exists")
             webViewContent.delegate = nil
            let strBA_tokan = request.url!.absoluteString.split(separator: "=")
            
            processGetBillingID(BA_tokan: "\(strBA_tokan.last!)")
        }
        else{
            if (request.url?.absoluteString.range(of:"paypal_cancel.php") != nil)
            {
                webViewContent.delegate = nil
                self.navigationController?.popViewController(animated: true)
                Application_Delegate.showSpinnerView(isShow: false)
            }
        }
        return true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("didFailLoadWithError:- \(webView.request!.url!.absoluteString)")
        showMyAlertView(message: "It seems your network connection is slow. Please, try after some time.") { (action) in
            self.navigationController?.popViewController(animated: true)
            Application_Delegate.showSpinnerView(isShow: false)
        }
    }
    
    
}
