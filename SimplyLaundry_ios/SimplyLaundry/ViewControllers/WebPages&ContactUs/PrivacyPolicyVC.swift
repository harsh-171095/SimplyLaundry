//
//  PrivacyPolicyVC.swift
//  SimplyLaundry
//
//  Created by webclues on 09/02/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class PrivacyPolicyVC: UIViewController {

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
    var isSidemanu : Bool = true
    var strContent : String = String()
    
     //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        setThemeAccrodingToScreen()
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
        
        lblVCTitle.setVCTitle("")
        
        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        webViewContent.backgroundColor = COLOR.White
    }
    
    /*
     Function Name :- setThemeAccrodingToScreen
     Function Parameters :- (nil)
     Function Description :- This function used to set a theme for Controller initial screen values
     */
    func setThemeAccrodingToScreen()
    {
        if intScreenNo == 1
        {
            processGetPages(parameter: RequestParameters_pages.privacypolicy)
            lblVCTitle.text = "Privacy Policy"
        }
        else if intScreenNo == 2
        {
            processGetPages(parameter: RequestParameters_pages.faq)
            lblVCTitle.text = "FAQ"
        }
        else if intScreenNo == 3
        {
            processGetPages(parameter: RequestParameters_pages.termsandconditions)
            lblVCTitle.text = "Terms & Conditions"
        }
        if isSidemanu == true{
             btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        }
        else{
             btnManu.setImage(UIImage.init(named: "back"), for: .normal)
        }
    }
    
    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        if isSidemanu == true{
            sideMenuController?.toggle()
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }

    //MARK:- API Call Funtions
    func processGetPages(parameter:String)
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["page_slug":parameter]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqPages, dictParameter: parameters as NSDictionary)
    }

    
}
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension PrivacyPolicyVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqPages
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    strContent = "\(responseData.value(forKey: ResKeyData)!)"
                    webViewContent.loadHTMLString(strContent, baseURL: nil)
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

