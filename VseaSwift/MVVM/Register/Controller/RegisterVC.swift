//
//  RegisterVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/7.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var smsCode: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var getSMSButton: UIButton!
    
    var times = 60
    
    lazy var alert:UIAlertView = {
        var alertView = UIAlertView()
        alertView.title = "通知"
        return alertView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setHiddenWithTranslucentWithBarTintColorWithTitleColorWithAlphaWithTitle(false, translucent: false, barTintColor: UIColor.whiteColor(), titleColor: UIColor.blackColor(), alpha: 1.0, title: "快速注册")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "return")?.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Done, target: self, action: "leftAction:")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Done, target: self, action: "rightAction:")
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.blackColor()
    }
    
    func leftAction(sender:UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func rightAction(sender:UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func testGetCode(sender: UIButton) {
        if self.phoneNumber.text?.characters.count > 0 {
            RegisterRequest.GETRequest(self.phoneNumber.text!, allRespond: { (objects) -> Void in
                if (objects as! NSDictionary)["r"] as! Int == 1 {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.alert.message = "短信已发送"
                        self.alert.addButtonWithTitle("确定")
                        self.alert.show()
                        sender.backgroundColor = JX_HexToRGB().hexFloatColor("9999999")
                        sender.userInteractionEnabled = false
                        let timer = NSTimer(timeInterval: 1, target: self, selector: "timerAction:", userInfo: nil, repeats: true)
                        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
                        timer.fireDate = NSDate()
                        timer.fire()
                    })
                }else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.alert.message = (objects as! NSDictionary)["msg"] as? String
                        self.alert.addButtonWithTitle("确定")
                        self.alert.show()
                    })
                }
            })
        }else {
            self.alert.message = "请输入手机号"
            self.alert.addButtonWithTitle("确定")
            self.alert.show()
        }
    }
    func timerAction(sender:NSTimer) {
        self.getSMSButton.setTitle(String(self.times), forState: UIControlState.Normal)
        self.times--
        if self.times == 0 {
            sender.invalidate()
            self.getSMSButton.userInteractionEnabled = true
            self.getSMSButton.setTitle("重新获取", forState: UIControlState.Normal)
        }
    }

    @IBAction func termsOfService(sender: AnyObject) {
        
    }
    @IBAction func registerAction(sender: AnyObject) {
        if self.smsCode.text?.characters.count == 0 {
            self.alert.message = "请输入手机号获取验证码"
            self.alert.addButtonWithTitle("确定")
            self.alert.show()
        }else if self.password.text?.characters.count == 0  {
            self.alert.message = "请输入密码"
            self.alert.addButtonWithTitle("确定")
            self.alert.show()
        }else {
            let addVC = AddDataVC(nibName: "AddDataVC", bundle: nil)
            addVC.phoneNumber = self.phoneNumber.text!
            addVC.SMSCode = self.smsCode.text!
            addVC.passWord = self.password.text!
            self.navigationController?.pushViewController(addVC, animated: true)
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(false)
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
