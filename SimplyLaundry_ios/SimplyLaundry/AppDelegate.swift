//
//  AppDelegate.swift
//  SimplyLaundry
//
//  Created by webclues on 28/12/18.
//  Copyright © 2018 webclues. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import SideMenuController
import GoogleSignIn
import FacebookCore
import FacebookLogin
//import FacebookShare
import IQKeyboardManagerSwift
import GooglePlaces
import GooglePlacePicker
import GoogleMaps
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var sideMenuVC:SideMenuController!
    let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var window: UIWindow?
    var navigationController : UINavigationController = UINavigationController()
    var spinner_view: SpinnerView!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setSideMenuSetting()
        FirebaseApp.configure()
        
        //Firbase Push Notitifications init
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            
            UNUserNotificationCenter.current().delegate = self
            Messaging.messaging().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            application.applicationIconBadgeNumber = 0
            application.cancelAllLocalNotifications()
            
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: .InstanceIDTokenRefresh,
                                               object: nil)
        // Sign-in with FB
//        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //Sign-in with google
        GIDSignIn.sharedInstance().clientID = GoogleClient_ID
        GMSServices.provideAPIKey(google_api_key)
        GMSPlacesClient.provideAPIKey(google_api_key)
        
        var controller = UIViewController()
        let dicUserInfo = getUserInfo()
        let sideMenuController: SideManuVC = mainStoryboard.instantiateViewController(withIdentifier: "SideManuVC") as! SideManuVC
        if dicUserInfo.allKeys.count > 0
        {
            controller = mainStoryboard.instantiateViewController(withIdentifier: "CleanMyClothesFirstVC") as! CleanMyClothesFirstVC
        }
        else{
            controller = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        }
        
        navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.isHidden = true
        navigationController.interactivePopGestureRecognizer!.isEnabled = false;
        sideMenuVC = SideMenuController()
        sideMenuVC.embed(sideViewController: sideMenuController)
        sideMenuVC.embed(centerViewController: navigationController)
        window!.rootViewController = sideMenuVC
        window!.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        connectToFcm()
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEventsLogger.activate(application)
        connectToFcm()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    @objc func tokenRefreshNotification(_ notification: Notification)
    {
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("InstanceID token: \(result.token)")
                TAG_Device_Token = result.token
            }
        }
        connectToFcm()
    }
    
    func connectToFcm()
    {
        guard InstanceID.instanceID().token() != nil else
        {
            return;
        }
        Messaging.messaging().shouldEstablishDirectChannel = false
        //Messaging.messaging().disconnect()
        
        Messaging.messaging().connect{ (error) in
            if error != nil
            {
                print("Unable to connect with FCM. \(String(describing: error))")
            }
            else
            {
                print("Connected to FCM.")
                
                InstanceID.instanceID().instanceID { (result, error) in
                    if let error = error {
                        print("Error fetching remote instange ID: \(error)")
                    } else if let result = result {
                        print("Remote instance ID token: \(result.token)")
                        TAG_Device_Token = result.token
//                        self.processRefreshToken()
                    }
                }
                print(TAG_Device_Token)
            }
        }
    }

    func setSideMenuSetting()
    {
        SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = SCREEN_SIZE.WIDTH * 0.8
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .horizontalPan
        SideMenuController.preferences.animating.transitionAnimator = FadeAnimator.self
        SideMenuController.preferences.interaction.swipingEnabled = false
        SideMenuController.preferences.interaction.panningEnabled = true
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func showSpinnerView(isShow: Bool)
    {
        if isShow == true
        {
            if spinner_view != nil
            {
                spinner_view.removeFromSuperview()
            }
            spinner_view = Bundle.main.loadNibNamed(String(describing: SpinnerView.self), owner: self, options: nil)![0] as? SpinnerView
            spinner_view.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            spinner_view.backgroundColor = COLOR.White.withAlphaComponent(0.5)
            spinner_view.spinner.startAnimating()
            spinner_view.spinner.color = COLOR.Green
            Application_Delegate.window?.addSubview(spinner_view)
        }
        else
        {
            if spinner_view != nil
            {
                spinner_view.removeFromSuperview()
            }
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool
    {
        if (url.scheme?.hasPrefix("fb"))!
        {
            if #available(iOS 9.0, *) {
                return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?, annotation: nil)
            } else {
            }
        }
        else if (url.scheme?.hasPrefix("com.googleusercontent.apps"))! //
        {
            if #available(iOS 9.0, *) {
                return GIDSignIn.sharedInstance().handle((url as URL??)!, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: nil)
            } else {
                // Fallback on earlier versions
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool
    {
        let isFB: Bool = url.scheme!.hasPrefix("fb")
        if isFB
        {
            let handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
            return handled
        }
        else
        {
            return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
        }
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])
    {
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        #if DEBUG
        Messaging.messaging().setAPNSToken(deviceToken, type: MessagingAPNSTokenType.sandbox)
        #else
        Messaging.messaging().setAPNSToken(deviceToken, type: MessagingAPNSTokenType.prod)
        #endif
    }
    
    private func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        Messaging.messaging().appDidReceiveMessage(userInfo)
    }

}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate
{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        let dictUserInfo: NSDictionary! = notification.request.content.userInfo as NSDictionary
        print(dictUserInfo.JSONString())
        getOnlyNotifications()
        let type = dictUserInfo.value(forKey: "type") as? String
        if type == NotificationHandel.logout
        {
            
            completionHandler(UNNotificationPresentationOptions.alert)
            removeKeyFromUserDefaults(keyName: User_Info)
            GoToLoginPage()
        }
        else{
            if type == NotificationHandel.type_inactive_delete
            {
                processLogout()
            }
            completionHandler(UNNotificationPresentationOptions.alert)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        let dictUserInfo: NSDictionary! = response.notification.request.content.userInfo as NSDictionary
        print(dictUserInfo.JSONString())
        handelPushNotification(NotificationDictionary: dictUserInfo)
        completionHandler()
    }
    
    func handelPushNotification(NotificationDictionary:NSDictionary)
    {
        let type : String = (NotificationDictionary.value(forKey: "type") as? String)!
        if type == NotificationHandel.logout
        {
            removeKeyFromUserDefaults(keyName: User_Info)
            GoToLoginPage()
        }
        else if type == NotificationHandel.order_cancel || type == NotificationHandel.order_complete || type == NotificationHandel.order_received
        {
            if (Application_Delegate.navigationController.topViewController is OrderDetailsVC) == true
            {
                let controller  = Application_Delegate.navigationController.topViewController as? OrderDetailsVC
                controller?.strOrderID = (NotificationDictionary.value(forKey: "order_id") as? String)!
                controller?.processGetOrderDetails(OrderID: (NotificationDictionary.value(forKey: "order_id") as? String)!)
            }
            else{
                let  controller = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "OrderDetailsVC") as! OrderDetailsVC
                controller.strOrderID = (NotificationDictionary.value(forKey: "order_id") as? String)!
                controller.intScreenNo = 2
                Application_Delegate.navigationController.pushViewController(controller, animated: false)
            }
        }
        else if type == NotificationHandel.referred_credit || type == NotificationHandel.referrer_credit
        {
            if (Application_Delegate.navigationController.topViewController is MyCreditVC) == true
            {
                let controller  = Application_Delegate.navigationController.topViewController as? MyCreditVC
                controller?.processGetUserCredits()
            }
            else{
                let  controller = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "MyCreditVC") as! MyCreditVC
                Application_Delegate.navigationController.pushViewController(controller, animated: false)
            }
        }
        else if type == NotificationHandel.package_buy
        {
            if (Application_Delegate.navigationController.topViewController is MyPackagesVC) == true
            {
                let controller  = Application_Delegate.navigationController.topViewController as? MyPackagesVC
                controller?.intOffset = -5
                controller?.processGetMyPackages()
            }
            else{
                let  controller = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "MyPackagesVC") as! MyPackagesVC
                Application_Delegate.navigationController.pushViewController(controller, animated: false)
            }
        }
        else if type == NotificationHandel.type_inactive_delete
        {
            processLogout()
        }
        
    }
    
    func getOnlyNotifications(pushType:[String] = [NotificationHandel.type_inactive_delete, NotificationHandel.package_buy, NotificationHandel.referrer_credit, NotificationHandel.referred_credit, NotificationHandel.order_received, NotificationHandel.order_cancel, NotificationHandel.order_complete, NotificationHandel.logout])
    {
        UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: { (notifications) in
            for noti in notifications
            {
                let dictUserInfo: NSDictionary! = noti.request.content.userInfo as NSDictionary
                
                if let _:String = dictUserInfo.value(forKey: push_type) as? String
                {
                   
                }
                else
                {
                    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [noti.request.identifier])
                }
            }
        })
    }
    
    func processLogout()
    {
        Application_Delegate.showSpinnerView(isShow: true)
        let parameters : [String:Any] = ["user_id":getUserID()]
        WebServiceDataProvider.sharedInstanceWithDelegate(delgate: self).sendRequestToServer_POST(reqTask: reqLogout, dictParameter: parameters as NSDictionary,isHeader: false)
    }
    
    func GoToLoginPage()
    {
        removeKeyFromUserDefaults(keyName: User_Info)
        let controller = Application_Delegate.mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let sideMenuController: SideManuVC = mainStoryboard.instantiateViewController(withIdentifier: "SideManuVC") as! SideManuVC
        navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.isHidden = true
        navigationController.interactivePopGestureRecognizer!.isEnabled = false;
        sideMenuVC = SideMenuController()
        sideMenuVC.embed(sideViewController: sideMenuController)
        sideMenuVC.embed(centerViewController: navigationController)
        window!.rootViewController = sideMenuVC
        window!.makeKeyAndVisible()
    }

    func DeleteNotification()
    {
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
extension AppDelegate : MessagingDelegate {
    // Receive data message on iOS 10 devices.
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print("%@", remoteMessage.appData)
    }
}
extension AppDelegate: webServiceDataProviderDelegate
{
    func dataRecievedFromServer(responseData: NSDictionary, withTask reqTask: String) {
        Application_Delegate.showSpinnerView(isShow: false)
        if reqTask == reqLogout
        {
            if let statusCode = responseData.value(forKey: ResKeyStatus_code) as? Int
            {
                if statusCode == successStatus
                {
                    GoToLoginPage()
                }
                else{
                    if let message : String = responseData.value(forKey: ResKeyMessage) as? String
                    {
                        showMyAlertView(message: message) { (action) in }
                    }
                }
            }
        }
    }
}
