//
//  WebServiceDataProvider.swift
//  YooUii
//
//  Created by Developer on 8/11/16.
//  Copyright © 2016 ebizTrait. All rights reserved.
//

import UIKit
import AFNetworking
import CoreLocation

protocol webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String)
}


class WebServiceDataProvider: NSObject
{
    var delegate : webServiceDataProviderDelegate?
    
    class var sharedInstance: WebServiceDataProvider
    {
        struct Static
        {
            static let instance = WebServiceDataProvider()
        }
        return Static.instance
    }
    
    class func sharedInstanceWithDelegate (delgate : webServiceDataProviderDelegate) -> WebServiceDataProvider
    {
        sharedInstance.delegate = delgate
        return sharedInstance
    }
    
    func sendRequestToServer_POST (reqTask: String!, dictParameter: NSDictionary, isHeader:Bool = true, arrHeaderData:NSDictionary = NSDictionary())
    {
        if isInternetAvailable()
        {
            var strURL: String = "\(SERVER_URL)\(reqTask!)"
            
            
            let manager = AFHTTPSessionManager()
            let dictUser: NSDictionary! = getUserInfo()
            if reqTask == paypal_Pament_url
            {
                strURL = paypal_Pament_url
                manager.requestSerializer.setValue("\(arrHeaderData.value(forKey: "token_type")!) \(arrHeaderData.value(forKey: "access_token")!)", forHTTPHeaderField: "Authorization")
//                manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
            }
            else if reqTask == get_paypal_Token{
                strURL = get_paypal_Token
                
                let client_id = "AeeZjKyBm6stXl_jSbjBTpH31ftD3W8wb7DL7KnhXH3EU0JS1wqYYspI3DBiFTpzbhqDl37wTr3FJ2h6"
                let secrate_keys = "EHgCIl7RUcyMKLqs2AyOep16XR1geg8PkYkq795PXRmTrEMnxmsi1brFUdO-1SRpdg0lOeswkKbJHt_o"
                let encodeData = "\(client_id):\(secrate_keys)".data(using: String.Encoding.utf8)!
                let base64Credentials = encodeData.base64EncodedString(options: [])
                manager.requestSerializer.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
            }
            else{
                if dictUser.allKeys.count > 0
                {
                    let strAuthToken : String! = "\(getAuthTocken())"
                    if strAuthToken.count > 0
                    {
                        if(reqTask != reqLogin && reqTask != reqSignUp && reqTask != reqPages && reqTask != reqGetAllCountry && reqTask != reqGetAllState && reqTask != reqGetGlobal && reqTask != reqLogout && reqTask != reqCheckEmail && reqTask != reqVerifyReferralCode && reqTask != reqForgotPassword  && reqTask != reqGetAllCategory)
                        {
                            manager.requestSerializer.setValue(strAuthToken!, forHTTPHeaderField: "authorizations")
                            manager.requestSerializer.setValue(getUserID(), forHTTPHeaderField: "userid")
                            print("AUTHTOKEN : \(String(describing: strAuthToken))")
                            print("USERID : \(getUserID())")
                        }
                       
                    }
                }
            }
            print("ServerURL:- \(strURL)")
            print("RequestObj:- \(dictParameter)")
            manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript","text/html") as? Set<String>
            manager.requestSerializer.timeoutInterval = 120
            manager.post(strURL, parameters: dictParameter, progress: nil, success: {(URLSessionDataTask, responseObject: Any) -> Void in
                
                print("Response Success:- \(responseObject)")
                
                if let _ : NSDictionary = responseObject as? NSDictionary
                {
                    if (responseObject as! NSDictionary).value(forKey: ResKeyStatus_code) != nil
                    {
                        if "\((responseObject as! NSDictionary).value(forKey: ResKeyStatus_code)!)" == "6"
                        {
                            //                    SVProgressHUD.dismiss()
                            
                            if let strMsg: String = (responseObject as! NSDictionary).value(forKey: ResKeyMessage) as? String
                            {
                                let alert = UIAlertController(title: APP_NAME, message:strMsg , preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: Alert_Ok, style: .default, handler: {
                                    (action: UIAlertAction!) in
                                    removeKeyFromUserDefaults(keyName: User_Info)
                                    
                                }))
                                Application_Delegate.navigationController.present(alert, animated: true, completion: nil)
                                
                            }
                        }
                        else{
                            if self.delegate != nil
                            {
                                if reqTask != nil
                                {
                                    if let _: Int = (responseObject as! NSDictionary).value(forKey: ResKeyStatus_code)! as? Int
                                    {
                                        self.delegate!.dataRecievedFromServer(responseData: responseObject as! NSDictionary, withTask: reqTask)
                                    }
                                    else
                                    {
                                        self.delegate!.dataRecievedFromServer(responseData: responseObject as! NSDictionary, withTask: reqTask)
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        if self.delegate != nil
                        {
                            if reqTask != nil
                            {
                                if (responseObject as! NSDictionary).value(forKey: ResKeyStatus_code) != nil{
                                    if let _: Int = (responseObject as! NSDictionary).value(forKey: ResKeyStatus_code)! as? Int
                                    {
                                        self.delegate!.dataRecievedFromServer(responseData: responseObject as! NSDictionary, withTask: reqTask)
                                    }
                                    else
                                    {
                                        self.delegate!.dataRecievedFromServer(responseData: responseObject as! NSDictionary, withTask: reqTask)
                                    }

                                }
                                else
                                {
                                    self.delegate!.dataRecievedFromServer(responseData: responseObject as! NSDictionary, withTask: reqTask)
                                }
                            }
                        }
                    }
                }
                else{
                    if self.delegate != nil
                    {
                        var errorDict: [String : AnyObject] = [:]
                        errorDict[ResKeyStatus_code] = 1111 as AnyObject
                        errorDict[ResKeyMessage] = "It seems your network connection is slow. Please, try after some time." as AnyObject
                        
                        if reqTask != nil
                        {
                            self.delegate!.dataRecievedFromServer(responseData: errorDict as NSDictionary, withTask: reqTask)
                        }
                    }
                }
                
            }, failure: {(URLSessionDataTask, error: Any) -> Void in
                
                print("Response Error:- \(error)")
                
                if self.delegate != nil
                {
                    var errorDict: [String : AnyObject] = [:]
                    errorDict[ResKeyStatus_code] = 1111 as AnyObject
                    errorDict[ResKeyMessage] = "It seems your network connection is slow. Please, try after some time." as AnyObject
                    
                    if reqTask != nil
                    {
                        self.delegate!.dataRecievedFromServer(responseData: errorDict as NSDictionary, withTask: reqTask)
                    }
                }
            })
        }
        else
        {
            var errorDict: [String : AnyObject] = [:]
            errorDict[ResKeyStatus_code] = 1111 as AnyObject
            errorDict[ResKeyMessage] = "It seems your network connection is slow. Please, try after some time." as AnyObject
            
            if reqTask != nil
            {
                self.delegate!.dataRecievedFromServer(responseData: errorDict as NSDictionary, withTask: reqTask)
            }
        }
    }
    
    func sendRequestToServer_GET (reqTask: String!, dictParameter: NSDictionary, isHeader:Bool = true)
    {
        if isInternetAvailable()
        {
            let strURL: String = "\(SERVER_URL)\(reqTask!)"
            print("ServerURL:- \(strURL)")
            print("RequestObj:- \(dictParameter.JSONString())")
            
            let manager = AFHTTPSessionManager()
            let dictUser: NSDictionary! = getUserProfileDict()
            if dictUser.allKeys.count > 0
            {
                let strAuthToken : String! = "\(getAuthTocken())"
                if strAuthToken.count > 0
                {
                    if(reqTask != reqLogin && reqTask != reqSignUp && reqTask != reqPages && reqTask != reqGetAllCountry && reqTask != reqGetAllState && reqTask != reqGetGlobal && reqTask != reqLogout && reqTask != reqCheckEmail && reqTask != reqVerifyReferralCode && reqTask != reqForgotPassword && reqTask != ReqGetAllPriceDetails && reqTask != reqGetAllCategory && reqTask != reqGetGlobal)
                    {
//                        manager.requestSerializer.setValue(strAuthToken!, forHTTPHeaderField: "authorizations")
//                        manager.requestSerializer.setValue(getUserID(), forHTTPHeaderField: "userid")
                        print("AUTHTOKEN : \(String(describing: strAuthToken))")
                        print("USERID : \(getUserID())")
                    }
                    
                }
            }
            manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript","text/html") as? Set<String>
            manager.requestSerializer.timeoutInterval = 120
            manager.get(strURL, parameters: dictParameter, progress: nil, success: {(URLSessionDataTask, responseObject: Any) -> Void in
                
                print("Response Success:- \(responseObject)")
                
                if "\((responseObject as! NSDictionary).value(forKey: ResKeyStatus_code)!)" == "6"
                {
//                    SVProgressHUD.dismiss()
                    if let strMsg: String = (responseObject as! NSDictionary).value(forKey: ResKeyMessage) as? String
                    {
                        let alert = UIAlertController(title: APP_NAME, message:strMsg , preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: Alert_Ok, style: .default, handler: {
                            (action: UIAlertAction!) in
                            removeKeyFromUserDefaults(keyName: User_Info)
                        }))
                        Application_Delegate.navigationController.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    
                    if self.delegate != nil
                    {
                        if reqTask != nil
                        {
                            if let statusCode: Int = (responseObject as! NSDictionary).value(forKey: ResKeyStatus_code)! as? Int
                            {
                                if statusCode == 2
                                {
                                    var errorDict: [String : AnyObject] = [:]
                                    errorDict[ResKeyStatus_code] = 1111 as AnyObject
                                    self.delegate!.dataRecievedFromServer(responseData: errorDict as NSDictionary, withTask: reqTask)
                                }
                                else
                                {
                                    self.delegate!.dataRecievedFromServer(responseData: responseObject as! NSDictionary, withTask: reqTask)
                                }
                            }
                            else
                            {
                                self.delegate!.dataRecievedFromServer(responseData: responseObject as! NSDictionary, withTask: reqTask)
                            }
                        }
                    }
                }
                
            }, failure: {(URLSessionDataTask, error: Any) -> Void in
                
                print("Response Error:- \(error)")
                
                if self.delegate != nil
                {
                    var errorDict: [String : AnyObject] = [:]
                    errorDict[ResKeyStatus_code] = 1111 as AnyObject
                    errorDict[ResKeyMessage] = "It seems your network connection is slow. Please, try after some time." as AnyObject
                    
                    if reqTask != nil
                    {
                        self.delegate!.dataRecievedFromServer(responseData: errorDict as NSDictionary, withTask: reqTask)
                    }
                }
            })
        }
        else
        {
            var errorDict: [String : AnyObject] = [:]
            errorDict[ResKeyStatus_code] = 1111 as AnyObject
            
            if reqTask != nil
            {
                self.delegate!.dataRecievedFromServer(responseData: errorDict as NSDictionary, withTask: reqTask)
            }
        }
    }
    
    
    func sendRequestToServerWithFile (reqTask: String!, dictParameter: NSDictionary, arrFile: NSMutableArray, isHeader:Bool = true)
    {
        if isInternetAvailable()
        {
            let strURL: String = "\(SERVER_URL)\(reqTask!)"
            print("ServerURL:- \(strURL)")
            print("RequestObj:- \(dictParameter.JSONString())")
            
            let manager = AFHTTPSessionManager()
            let dictUser: NSDictionary! = getUserProfileDict()
            if dictUser.allKeys.count > 0
            {
                let strAuthToken : String! = "\(getAuthTocken())"
                if strAuthToken.count > 0
                {
                    manager.requestSerializer.setValue(strAuthToken!, forHTTPHeaderField: "AUTHTOKEN")
                    manager.requestSerializer.setValue(getUserID(), forHTTPHeaderField: "USERID")
                    print("AUTHTOKEN : \(String(describing: strAuthToken))")
                    print("USERID : \(getUserID())")
                }
            }
            manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript","text/html") as? Set<String>
            manager.requestSerializer.timeoutInterval = 120
            manager.post(strURL, parameters: dictParameter, constructingBodyWith: {(formData: AFMultipartFormData) -> Void in
                
                if arrFile.count > 0
                {
                    for i in 0..<arrFile.count
                    {
                        let dictTemp : NSMutableDictionary = arrFile.object(at: i) as! NSMutableDictionary
                        
                        let imageData : NSData = dictTemp.value(forKey: "imageData") as! NSData
                        let name : String = dictTemp.value(forKey: "name") as! String
                        let fileName : String = dictTemp.value(forKey: "fileName") as! String
                        let mimeType : String = dictTemp.value(forKey: "mimeType") as! String
                        
                        formData.appendPart(withFileData: imageData as Data, name: name, fileName: fileName, mimeType: mimeType)
                    }
                }
                
            }, progress: nil, success: {(URLSessionDataTask, responseObject:Any) -> Void in
                
                print("Response Success:- \(responseObject)")
                
                if "\((responseObject as! NSDictionary).value(forKey: ResKeyStatus_code)!)" == "6"
                {
//                    SVProgressHUD.dismiss()

                    if let strMsg: String = (responseObject as! NSDictionary).value(forKey: ResKeyMessage) as? String
                    {
                        let alert = UIAlertController(title: APP_NAME, message:strMsg , preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: Alert_Ok, style: .default, handler: {
                            (action: UIAlertAction!) in
                            removeKeyFromUserDefaults(keyName: User_Info)
                        }))
                        Application_Delegate.navigationController.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    if self.delegate != nil
                    {
                        if reqTask != nil
                        {
                            if let statusCode: Int = (responseObject as! NSDictionary).value(forKey: ResKeyStatus_code)! as? Int
                            {
                                if statusCode == 2
                                {
                                    var errorDict: [String : AnyObject] = [:]
                                    errorDict[ResKeyStatus_code] = 1111 as AnyObject
                                    self.delegate!.dataRecievedFromServer(responseData: errorDict as NSDictionary, withTask: reqTask)
                                }
                                else
                                {
                                    self.delegate!.dataRecievedFromServer(responseData: responseObject as! NSDictionary, withTask: reqTask)
                                }
                            }
                            else
                            {
                                self.delegate!.dataRecievedFromServer(responseData: responseObject as! NSDictionary, withTask: reqTask)
                            }
                        }
                    }
                }
                
                
            }, failure: {(URLSessionDataTask, error: Any) -> Void in
                
                print("Response Error:- \(error)")
                
                if self.delegate != nil
                {
                    var errorDict: [String : AnyObject] = [:]
                    errorDict[ResKeyStatus_code] = 1111 as AnyObject
                    errorDict[ResKeyMessage] = "It seems your network connection is slow. Please, try after some time." as AnyObject
                    
                    if reqTask != nil
                    {
                        self.delegate!.dataRecievedFromServer(responseData: errorDict as NSDictionary, withTask: reqTask)
                    }
                }
            })
        }
        else
        {
            var errorDict: [String : AnyObject] = [:]
            errorDict[ResKeyStatus_code] = 1111 as AnyObject
            
            if reqTask != nil
            {
                self.delegate!.dataRecievedFromServer(responseData: errorDict as NSDictionary, withTask: reqTask)
            }
        }
    }
    
    func searchLocationPlaceDetailAPI(strPlaceID:String)
    {
        var strURL = "\(Place_API)\(Place_API_Type_detail)/json?placeid=\(strPlaceID)&key=\(Place_API_key)&\(Place_API_SearchInArea)"
        strURL = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print("PlaceDetail_API :- \(strURL)")
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 120
        manager.post(strURL, parameters: nil, progress: nil, success: { (URLSessionDataTask, responseObject) in
            print("Response Success:- \(String(describing: responseObject))")
            
            if self.delegate != nil
            {
                self.delegate!.dataRecievedFromServer(responseData: responseObject as! NSDictionary, withTask: reqTask_PlaceDetail_API)
            }
        }, failure: { (URLSessionDataTask, error) in
            print("Response Error:- \(error)")
            
            if self.delegate != nil
            {
                var errorDict: [String : AnyObject] = [:]
                errorDict[ResKeyStatus_code] = 1111 as AnyObject
                errorDict[ResKeyMessage] = "It seems your network connection is slow. Please, try after some time." as AnyObject
                self.delegate!.dataRecievedFromServer(responseData: errorDict as NSDictionary, withTask: reqTask_PlaceDetail_API)
            }
        })
    }
    func searchLocationPlaceAPI(strPlace:String)
    {
        var strURL = "\(Place_API)\(Place_API_autocomplete)/json?input=\(strPlace)&key=\(Place_API_key)&\(Place_API_SearchInArea)"
        strURL = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print("PlaceDetail_API :- \(strURL)")
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 120
        manager.post(strURL, parameters: nil, progress: nil, success: { (URLSessionDataTask, responseObject) in
            print("Response Success:- \(String(describing: responseObject))")
            
            if self.delegate != nil
            {
                self.delegate!.dataRecievedFromServer(responseData: responseObject as! NSDictionary, withTask: Place_API_autocomplete)
            }
        }, failure: { (URLSessionDataTask, error) in
            print("Response Error:- \(error)")
            
            if self.delegate != nil
            {
                var errorDict: [String : AnyObject] = [:]
                errorDict[ResKeyStatus_code] = 1111 as AnyObject
                errorDict[ResKeyMessage] = "It seems your network connection is slow. Please, try after some time." as AnyObject
                self.delegate!.dataRecievedFromServer(responseData: errorDict as NSDictionary, withTask: Place_API_autocomplete)
            }
        })
    }
    
    
}
