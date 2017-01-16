//
//  AppDelegate.swift
//  ShoutAboutApp
//
//  Created by VIRENDRA GUPTA on 05/11/16.
//  Copyright © 2016 VIRENDRA GUPTA. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging

@UIApplicationMain



class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?
    
    //MARK:// GET CONTACT
    func retrieveContacts() -> [SearchPerson]?
    {
        if let unarchivedObject = NSUserDefaults.standardUserDefaults().objectForKey(contactStored) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [SearchPerson]
        }
        return nil
    }
    
    
    //MARK: Refresh Token
    func tokenRefreshNotification(notification: NSNotification)
    {
        if let refreshedToken = FIRInstanceID.instanceID().token()
        {
            print("InstanceID token: \(refreshedToken)")
        }
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(tokenRefreshNotification(_:)),
                                                         name: kFIRInstanceIDTokenRefreshNotification,
                                                         object: nil)
        
      //  UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        let appUserId = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_id)
        let appUserToken = NSUserDefaults.standardUserDefaults().objectForKey(kapp_user_token)
        
        if appUserId != nil && appUserToken != nil
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let tabBarVC = storyboard.instantiateViewControllerWithIdentifier("SWRevealViewController") as? SWRevealViewController
            
            appDelegate.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
            appDelegate.window?.rootViewController = tabBarVC
            appDelegate.window?.makeKeyAndVisible()
            
            if let contactStored = self.retrieveContacts()
            {
                ProfileManager.sharedInstance.syncedContactArray.appendContentsOf(contactStored)
            }
            
            
            
            
        }
        FIRApp.configure()
        /*
         
         if #available(iOS 10.0, *)
         
         {
         
         let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
         
         UNUserNotificationCenter.current().requestAuthorization(
         
         options: authOptions,
         
         completionHandler: {_, _ in })
         
         
         
         // For iOS 10 display notification (sent via APNS)
         
         UNUserNotificationCenter.current().delegate = self
         
         // For iOS 10 data message (sent via FCM)
         
         FIRMessaging.messaging().remoteMessageDelegate = self
         
         
         
         } else*/
    
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        
        let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
        
        return true
}

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        
        FIRMessaging.messaging().disconnect()
        print("Disconnected from FCM.")

    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}



func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError)
{
    print(error)
}

func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData)
{
    
    let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
    
    var tokenString = ""
    for i in 0..<deviceToken.length
    {
        
        tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        
    }
    
    FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.Sandbox)
    
    print("Device Token:", tokenString)
}



func connectToFcm()
{
    FIRMessaging.messaging().connectWithCompletion { (error) in
        if error != nil
        {
           print("Unable to connect with FCM. \(error)")
        } else
        {
            let refreshedToken = FIRInstanceID.instanceID().token()
            print("InstanceID token: \(refreshedToken)")
            print("Connected to FCM.")
            
        }
    }
    
}


func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void)
{
    if userInfo["gcm.message_id"] != nil
    {
        print("Message ID: \(userInfo["gcm.message_id"]!)")
        
    }
    // Print full message.
    print(userInfo)
}

func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject])
{
    
    // If you are receiving a notification message while your app is in the background,
    
    // this callback will not be fired till the user taps on the notification launching the application.
    
    // TODO: Handle data of notification
    // Print message ID.
    
    print("Message ID: \(userInfo["gcm.message_id"]!)")
    // Print full message.
    
    print(userInfo)
    FIRMessaging.messaging().appDidReceiveMessage(userInfo)
    
}
