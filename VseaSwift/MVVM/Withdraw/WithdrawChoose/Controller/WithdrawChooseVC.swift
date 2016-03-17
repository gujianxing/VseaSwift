//
//  WithdrawChooseVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/12.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class WithdrawChooseVC: UIViewController,UITableViewDataSource,UITableViewDelegate{

    lazy var tableView:UITableView = {
        var view = UITableView(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: UITableViewStyle.Grouped)
        view.dataSource = self
        view.delegate = self
        view.registerNib(UINib(nibName: "WithdrawTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        return view
    }()
    
    var chooseBankCard = Bool()
    var chooseAliPay = Bool()
    
    var selectCell = Int()
    
    lazy var paySource:NSDictionary = {
        var source = NSMutableDictionary()
        return source
    }()
    
    var footerHeightOne:CGFloat = 0.0001
    var footerHeightTwo:CGFloat = 0.0001

    override func loadView() {
        super.loadView()
        self.view.addSubview(self.tableView)
        self.requestData()
    }
    
    func requestData() {
        let user_id = NSUserDefaults.standardUserDefaults().objectForKey("uid") as! String
        let str = GETWITHDRAWNAME + "user_id=" + user_id + "&type=bank"
        let manager = AFHTTPSessionManager()
        manager.GET(str, parameters: nil, progress: { (progress:NSProgress) -> Void in
            
            }, success: { (task:NSURLSessionDataTask, objects:AnyObject?) -> Void in
                print(objects)
            }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择提现账户"
        self.navigationItem.setLeftBarButtonItemWithImage("return", style: UIBarButtonItemStyle.Done, target: self, action: "leftAction:", tintColor: nil)
        //添加按钮
        self.paySource.setValue([], forKey: "支付宝提现")
        self.paySource.setValue([], forKey: "银行卡提现")
    }
    func leftAction(sender:UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pays = self.paySource.allKeys[section] as! String
        let arr = self.paySource[pays] as! NSArray
        return arr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! WithdrawTableViewCell
        if self.selectCell == indexPath.row {
            cell.picture.image = UIImage(named: "Withdraw_select")
        }else {
            cell.picture.image = UIImage(named: "Withdraw_unselect")
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectCell = indexPath.row
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let views = NSBundle.mainBundle().loadNibNamed("WithdrawCellHeaderView", owner: self, options: nil)
        let view = views.last as! WithdrawCellHeaderView
        view.chooseMethodOfPayment(self, action: "headerViewAction:")
        if section != 0 {
            view.title.text = "银行卡提现"
        }
        return view
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let views = NSBundle.mainBundle().loadNibNamed("WithdrawCellFooterView", owner: self, options: nil)
        let view = views.last as! WithdrawCellFooterView
        view.chooseMethodOfPayment(self, action: "footerViewAction:")
        view.section = section
        if section != 0 {
            view.title.text = "+添加银行卡帐号"
        }
        return view
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return self.footerHeightOne
        }else {
            return self.footerHeightTwo
        }
    }

    func headerViewAction(sender:UITapGestureRecognizer) {
        if (sender.view as! WithdrawCellHeaderView).title.text == "支付宝提现" {
            self.chooseBankCard = !self.chooseBankCard
            if self.chooseAliPay == true {
                self.chooseAliPay = false
            }
            if self.chooseBankCard == true {
                self.paySource.setValue(["",""], forKey: "支付宝提现")
                self.footerHeightOne = 46
            }else {
                self.footerHeightOne = 0.0001
                self.paySource.setValue([], forKey: "支付宝提现")
            }
            self.paySource.setValue([], forKey: "银行卡提现")
            self.footerHeightTwo = 0.001
            self.tableView.reloadData()
        }else {
            self.chooseAliPay = !self.chooseAliPay
            if self.chooseBankCard == true {
                self.chooseBankCard = false
            }
            if self.chooseAliPay == true {
                self.paySource.setValue(["","","",""], forKey: "银行卡提现")
                self.footerHeightTwo = 46
            }else {
                self.paySource.setValue([], forKey: "银行卡提现")
                self.footerHeightTwo = 0.0001
            }
            self.paySource.setValue([], forKey: "支付宝提现")
            self.footerHeightOne = 0.001
            self.tableView.reloadData()
        }
    }
    
    
    
    func footerViewAction(sender:UITapGestureRecognizer) {
        if (sender.view as! WithdrawCellFooterView).section == 0 {
            let vc = AliPayAddVC(nibName: "AliPayAddVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = BankCardAddVC(nibName: "BankCardAddVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
