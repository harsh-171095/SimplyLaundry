//
//  File.swift
//  SimplyLaundry
//
//  Created by webclues on 11/12/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

class RateForApplication : NSObject {
    
    static let instance = RateForApplication()
    
    func openAlertForRate() {
        if UserDefaults.standard.value(forKey: "isUserRate") != nil {
            if let intOrderNumber : Int = UserDefaults.standard.value(forKey: "isUserRate") as? Int {
                if intOrderNumber >= 5 {
                    SKStoreReviewController.requestReview()
                    UserDefaults.standard.setValue(0, forKey: "isUserRate")
                    UserDefaults.standard.synchronize()
                }
                else {
                    UserDefaults.standard.setValue((intOrderNumber+1), forKey: "isUserRate")
                    UserDefaults.standard.synchronize()
                }
            }
            else {
                UserDefaults.standard.setValue(0, forKey: "isUserRate")
                UserDefaults.standard.synchronize()
            }
        }
        else {
            SKStoreReviewController.requestReview()
            UserDefaults.standard.setValue(0, forKey: "isUserRate")
            UserDefaults.standard.synchronize()
        }
    }
    
}
