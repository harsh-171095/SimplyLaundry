//
//  ReferFriendsVC.swift
//  SimplyLaundry
//
//  Created by webclues on 09/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import UIKit

class ReferFriendsVC: UIViewController {
    
    //Parent view outlet's
    @IBOutlet weak var viewParent:UIView!
    
    //header view outlet's
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var imgBackground:UIImageView!
    @IBOutlet weak var lblVCTitle:UILabel!
    @IBOutlet weak var btnManu:UIButton!
    
    //Content view outlet's
    @IBOutlet weak var viewContent:UIView!

    @IBOutlet weak var lblReferFriendTitle:UILabel!
    
    @IBOutlet weak var viewReferFriend:UIView!
    @IBOutlet weak var imgReferFriend:UIImageView!
    @IBOutlet weak var lblReferCode:UILabel!
    
    @IBOutlet weak var btnReferDetails:UIButton!
    @IBOutlet weak var lblButtonCircle:UILabel!
    
    // Variable Declarations and Initlizations
    var strReferCode : String = "H854"
    var strSubString = "\nTo earn spread across the world. click below button"
    var dicFerredDetail = NSDictionary()
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        if ResponceKey_ReferrDetails.dicFereDetails.count > 0
        {
            dicFerredDetail = ResponceKey_ReferrDetails.dicFereDetails
            setRaferCode()
            viewContent.isHidden = false
        }
        else{
            processGetReferCode()
        }
        
        // Do any additional setup after loading the view.
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
        
        lblVCTitle.setVCTitle("Refer Friends")

        
        btnManu.setTitle("", for: .normal)
        btnManu.setImage(UIImage.init(named: "side_menu"), for: .normal)
        btnManu.addTarget(self, action: #selector(btnManuClick(_:)), for: .touchUpInside)
        
        //Content theme
        viewContent.backgroundColor = COLOR.White
        viewContent.isHidden = true
        
        lblReferFriendTitle.text = "Friend gets 5 Credits on registration. Friend orders first time, you get 5 Credits. \nTo earn spread across the world. click below button"
        lblReferFriendTitle.textColor = COLOR.Gray
        lblReferFriendTitle.font = UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_FOURTEEN)
        lblReferFriendTitle.numberOfLines = 0
        lblReferFriendTitle.lineBreakMode = .byWordWrapping
        
        viewReferFriend.backgroundColor = COLOR.background_Gray
        imgReferFriend.image = UIImage.init(named: "referral_code_bg")
        
        btnReferDetails.setThemeForAppButton("REFER DETAILS     ") // 5 Blank Space after text
        btnReferDetails.addTarget(self, action: #selector(btnReferDetailsClick(_:)), for: .touchUpInside)
        lblButtonCircle.text = ""
        lblButtonCircle.backgroundColor = COLOR.White
        lblButtonCircle.setCornerRadius(border: 0.01, Color: COLOR.clear, corner: lblButtonCircle.frame.height / 2)
    }

    //MARK:- Button Actions
    @IBAction func btnManuClick(_ sender: Any)
    {
        sideMenuController?.toggle()
    }

    @IBAction func btnReferDetailsClick(_ sender: Any)
    {
        guard let url1 = URL(string: "https://facebook.com/")  else { return }
        UIApplication.shared.canOpenURL(url1)
        let shareString = "Your friend \(getUserInfo().value(forKey: ResponceKey_Login_User.display_name)!) inviting you to use \(APP_NAME). Earn \(dicFerredDetail.value(forKey: "site_referred_credit")!) credits on placing your first order. \nUse \(strReferCode) at the time of registration.\n\(referCodeURL+strReferCode)."
        print(referCodeURL+strReferCode)
        let activityViewController = UIActivityViewController(activityItems:
            [shareString], applicationActivities: nil)

        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: {
            
        })
    }
    /*
     Function Name :- setRaferCode
     Function Parameters :- (nil)
     Function Description :- set Login User Refer code
     */
    func setRaferCode()
    {
        //Refer a friend and both of you will receive $5 off once your referral places their first order
        strReferCode = "\(dicFerredDetail.value(forKey: "referral_code")!)"
        let attributedStr = NSMutableAttributedString(string: "Referral Code: " , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_TWENTY_FOUR - 2)!, NSAttributedString.Key.foregroundColor : COLOR.Blue])
        let attributedStr1 = NSMutableAttributedString(string: strReferCode , attributes:[NSAttributedString.Key.font : UIFont.init(name: SourceSansPro_Regular, size: FONT_SIZE_TWENTY_FOUR - 2)!, NSAttributedString.Key.foregroundColor : COLOR.yellow])
        attributedStr.append(attributedStr1)
        lblReferCode.attributedText = attributedStr
        
        lblReferFriendTitle.text = "Refer a friend and both of you will receive $\(dicFerredDetail.value(forKey: "site_referred_credit")!) off once your referral places their first order.\(strSubString)"
    }
    //MARK:- API Call Funtions
    func processGetReferCode()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqGetReferCode, dictParameter: parameters as NSDictionary)
    }

}
//MARK:- API Response
/*
 Extension Description :- Delegate methods for the Response of API Calling
 */
extension ReferFriendsVC : webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqGetReferCode
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    if let resKeyData : NSDictionary = responseData.value(forKey: ResKeyData) as? NSDictionary
                    {
                        dicFerredDetail = resKeyData
                        setRaferCode()
                        ResponceKey_ReferrDetails.dicFereDetails = resKeyData
                        viewContent.isHidden = false
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
