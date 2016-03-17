//
//  LoginVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/7.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,UIAlertViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func loadView() {
        super.loadView()

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.setHiddenWithTranslucentWithBarTintColorWithTitleColorWithAlphaWithTitle(false, translucent: true, barTintColor: UIColor.whiteColor(), titleColor: UIColor.whiteColor(), alpha: 0, title: "登录注册")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "return_white")?.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Done, target: self, action: "leftAction:")
        let tap = UITapGestureRecognizer(target: self, action: "firstTouch:")
        self.scrollView.addGestureRecognizer(tap)
        self.tabBarController?.tabBar.hidden = true
    }
    
    func firstTouch(sender:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func leftAction(sender:UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
//        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func login(sender: UIButton) {
        if self.name.text?.characters.count == 0 || self.password.text?.characters.count == 0 {
            let alertView = UIAlertView()
            alertView.title = "通知"
            alertView.message = "用户名或者密码不能为空"
            alertView.addButtonWithTitle("确定")
            alertView.show()
        }else {
            LoginVCRequest.GetRequest(self.name.text!, password: self.password.text!) { (details) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if details!["status"] as! Int == 0 {
                        let alertView = UIAlertView()
                        alertView.title = "通知"
                        alertView.message = "账号密码错误"
                        alertView.addButtonWithTitle("确定")
                        alertView.show()
                    }else {
                        let alertView = UIAlertView()
                        alertView.title = "通知"
                        alertView.message = "登录成功"
                        alertView.addButtonWithTitle("确定")
                        alertView.show()
                        let dic = details!["data"] as! NSDictionary
                        NSUserDefaults.standardUserDefaults().setValue(dic["mobile"], forKey: "mobile")
                        NSUserDefaults.standardUserDefaults().setValue(dic["nick"], forKey: "nick")
                        NSUserDefaults.standardUserDefaults().setValue(dic["uid"], forKey: "uid")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        self.navigationController?.popToRootViewControllerAnimated(false)
                    }
                })
            }
        }
    }
    
    @IBAction func forgetPassword(sender: AnyObject) {
        let resetPasswordVC = ResetPasswordVC(nibName: "ResetPasswordVC", bundle: nil)
        self.navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
    
    @IBAction func register(sender: AnyObject) {
        let registerVC = RegisterVC(nibName: "RegisterVC", bundle: nil)
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    //QQ
    @IBAction func QQLogin(sender: UIButton) {
        let platform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToWechatSession)
        platform.loginClickHandler(self,UMSocialControllerService.defaultControllerService(),true) {(response)-> Void in
            if(response.responseCode == UMSResponseCodeSuccess) {
                let snsAccount = UMSocialAccountManager.socialAccountDictionary()[UMShareToWechatSession]
                let manager = AFHTTPSessionManager()
                let paras = ["type":1,"openid":String(snsAccount?.usid) ]
                manager.POST(QQLOGIN, parameters: paras, progress: { (progress:NSProgress) -> Void in
                    
                    }, success: { (task:NSURLSessionDataTask, objects:AnyObject?) -> Void in
                        print(objects)
                    }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                        
                })
                
                
                
            }
        }
    }
    //微信
    @IBAction func weixinLogin(sender: AnyObject) {
        let platform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToWechatSession)
        platform.loginClickHandler(self,UMSocialControllerService.defaultControllerService(),true) {(response)-> Void in
            if(response.responseCode == UMSResponseCodeSuccess) {
                let snsAccount = UMSocialAccountManager.socialAccountDictionary()[UMShareToWechatSession]
                let manager = AFHTTPSessionManager()
                let paras = ["type":2,"openid":String(snsAccount?.usid) ]
                manager.POST(QQLOGIN, parameters: paras, progress: { (progress:NSProgress) -> Void in
                    
                    }, success: { (task:NSURLSessionDataTask, objects:AnyObject?) -> Void in
                        print(objects)
                    }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                        
                })
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
 
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        if self.view.frame.size.width == 320 {
            self.scrollViewHeight.constant = HEIGHT * 0.5
            
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
