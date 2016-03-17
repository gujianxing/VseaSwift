//
//  WithdrawVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/12.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class WithdrawVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "提现"
        self.navigationItem.setLeftBarButtonItemWithImage("return", style: UIBarButtonItemStyle.Done, target: self, action: "leftAction:", tintColor: nil)
        // Do any additional setup after loading the view.
    }

    func leftAction(sender:UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func nextAction(sender: UIButton) {
        let vc = WithdrawChooseVC(nibName: "WithdrawChooseVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
