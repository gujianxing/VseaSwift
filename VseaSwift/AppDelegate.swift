//
//  AppDelegate.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/2/29.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit
let WIDTH = UIScreen.mainScreen().bounds.size.width
let HEIGHT = UIScreen.mainScreen().bounds.size.height
let BOUNDS = UIScreen.mainScreen().bounds
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let tabbarVC = TabBarVC()
        self.window = UIWindow(frame: CGRectMake(0, 0, WIDTH, HEIGHT))
        self.window?.rootViewController = tabbarVC
        self.window?.makeKeyAndVisible()
        
        //JPush,,支付宝微信支付,
        
        //Bugly
//        CrashReporter.sharedInstance().enableLog(true)   //崩溃调试
        CrashReporter.sharedInstance().installWithAppId("900013131")
        
        //Jpush
        
        
        
        //UM分享,登录
        UMSocialData.setAppKey("55ff995867e58e4fd20003e1")
        UMSocialWechatHandler.setWXAppId("wx6164f12e118f863f", appSecret: "f909a93ac14c6f44887cf68c4b2b4532", url: "http://login.vsea.com.cn/")
        UMSocialQQHandler.setQQWithAppId("101236466", appKey: "f0b7cd47385926754cb49f480e4fd7e1", url: "http://www.vsea.com.cn/app/")
        
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let result = UMSocialSnsService.handleOpenURL(url)
        if(result == false) {
            //调用其他SDK
        }
        
        return result
    }
    
    
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

