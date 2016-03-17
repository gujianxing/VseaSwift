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
let LOGIN = "http://api.vseatest.com/V2/login/memberlogin?" //登录
let QQLOGIN = "http://api.vsea.com.cn/User/user_bindfind"  //qq登录
let SMS_CODE = "http://api.vseatest.com/login/sms_code/?"  //短信验证码
let UPlOADPHOTO = "http://api.vseatest.com/User/uploadAppPortrait"  //上传图片
let REGISTER = "http://api.vseatest.com/V2/login/RegisterMember/"  //注册
let MINE = "http://api.vsea.com.cn/User/get_user_info" //获取个人信息



let SEARCHGOODS = "http://api.vsea.com.cn/Goods/get_list" //搜索商品
let SEARCHSHOP = "http://api.vsea.com.cn/BrandElevent/seek?"  //搜索店铺

let CART = "http://api.vsea.com.cn/Cart/get_cart_list?user_id=" //购物车列表


let USER = "/User/get_user_info?user_id=166&istown=1" //获取个人信息



let GETWITHDRAWNAME = "http://api.vsea.com.cn/Cash/get_user_bank?"  //获取用户账号(银行卡，支付宝)列表

let ADDADDRESS = "http://api.vsea.com.cn/User/add_address"   //添加收货地址
let EDITADDRESS = "http://api.vsea.com.cn/User/edit_address"  //修改收货地址
let DELETEADDRESS = "http://api.vsea.com.cn/User/del_address?"   //删除收货地址



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let tabbarVC = TabBarVC()
        self.window = UIWindow(frame: CGRectMake(0, 0, WIDTH, HEIGHT))
        let nav = UINavigationController(rootViewController: tabbarVC)
//        nav.navigationBar.hidden = true
        self.window?.rootViewController = nav
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

