//
//  AppDelegate.swift
//  WalmartBeauty
//
//  Created by Siddhant Goyal
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

import UIKit

import WalmartSDKKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        /**
        Intialize the WalmartSDKKit using sharedInstance of WMTSDK class only.
        You can optionally use `WMTSDK.sharedInstance.initSDKWithDisableTracking(disableTracking: Bool)` to disable tracking 
        of user information.
        */
        WMTSDK.sharedInstance().initSDK()
        
        /**
        You may optionally change the default logger logging level. The default logging level is Error. See `WMTLogLevel`
        */
        WMTLogger.defaultLogger().logLevel = .Error
        
        return true
    }

}

