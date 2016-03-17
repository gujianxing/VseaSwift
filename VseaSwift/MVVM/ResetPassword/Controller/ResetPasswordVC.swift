//
//  ResetPasswordVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/8.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var phone86: UILabel!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var gerSMSCode: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setHiddenWithTranslucentWithBarTintColorWithTitleColorWithAlphaWithTitle(false, translucent: false, barTintColor: UIColor.whiteColor(), titleColor: UIColor.blackColor(), alpha: 1.0, title: "重置密码")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "return")?.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Done, target: self, action: "leftAction:")

    }
    func leftAction(sender:UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func getSMSCode(sender: UIButton) {
        if phoneNumber.text?.characters.count == 0 {
            let alert = UIAlertView()
            alert.title = "通知"
            alert.message = "请输入手机号"
            alert.addButtonWithTitle("确定")
            alert.show()
        }else {
            
            sender.backgroundColor = JX_HexToRGB().hexFloatColor("9999999")
            sender.userInteractionEnabled = false
            let timer = NSTimer(timeInterval: 1, target: self, selector: "timerAction:", userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
            timer.fireDate = NSDate()
            timer.fire()
        }
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
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
