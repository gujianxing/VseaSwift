//
//  MyWalletVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/14.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class MyWalletVC: UIViewController {

    var user_money = String()
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    //充值
    @IBAction func rechargeAction(sender: UITapGestureRecognizer) {
        print("充值")
        let vc = RechargeVC(nibName: "RechargeVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    //提现
    @IBAction func withdrawAction(sender: UITapGestureRecognizer) {
        print("提现")
        let vc = WithdrawVC(nibName: "WithdrawVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)

    }
    //资金明细
    @IBAction func fundsDetail(sender: UITapGestureRecognizer) {
        print("资金明细")

    }
    //支付宝
    @IBAction func aliPay(sender: UITapGestureRecognizer) {
        print("支付宝")

    }
    //银行卡
    @IBAction func BankCard(sender: UITapGestureRecognizer) {
        print("银行卡")

    }
    
    
    
    
    override func loadView() {
        super.loadView()
        self.title = "我的钱袋"
        self.navigationItem.setLeftBarButtonItemWithImage("return", style: UIBarButtonItemStyle.Done, target: self, action: "leftAction:", tintColor: nil)
        self.moneyLabel.text = self.user_money
        
        
    }
    
    
    
    
    func leftAction(sender:UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
