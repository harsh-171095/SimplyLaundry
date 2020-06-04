
//
//  nativeAPICall.swift
//  SimplyLaundry
//
//  Created by webclues on 28/03/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import Foundation

func callPaypalLoginURL(URL myURL:String = String(),body bodyParameters:[String:String] = [String:String](),dicHeaderData:NSDictionary,completionHandler : @escaping (NSDictionary) -> ())
{
    let headers = [
        "Content-Type": "application/json",
        "Authorization": "\(dicHeaderData.value(forKey: "token_type")!) \(dicHeaderData.value(forKey: "access_token")!)",
        "cache-control": "no-cache",
    ]
    
    var parameters : [String : Any]!
    if bodyParameters.count > 0
    {
        parameters = bodyParameters
    }
    else{
        parameters = [
            "description": "Billing Agreement",
            "payer": ["payment_method": "PAYPAL"],
            "plan": [
                "type": "MERCHANT_INITIATED_BILLING",
                "merchant_preferences": [
                    "return_url": "https://simply-laundry.com/paypal/paypal_success.php",
                    "cancel_url": "https://simply-laundry.com/paypal/paypal_cancel.php"
                ]
            ]
            ] as [String : Any]
    }
    
    var postData : Data!
    do{
        postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
    }
    catch{
        print(error.localizedDescription)
    }
    
    let request = NSMutableURLRequest(url: NSURL(string: myURL)! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = postData
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            let errorData : [String : Any] = ["status":false,"message":"Error :- \(error?.localizedDescription ?? "No Data")"]
            completionHandler(errorData as NSDictionary)
        } else {
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                completionHandler(jsonResponse as! NSDictionary)
                print ("data = \(jsonResponse)")
            }catch _ {
                let errorData : [String : Any] = ["status":false,"message":"Error :- Sorry data is not json formate"]
                completionHandler(errorData as NSDictionary)
                print ("OOps not good JSON formatted response")
            }
        }

    })
    
    dataTask.resume()
}
