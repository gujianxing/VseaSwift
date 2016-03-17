//
//  MineVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/10.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class MineVC: UIViewController,MineViewDelegate {
    
    @IBOutlet weak var backView: MineView!
    
    var user_money = String()
    
    
    //修改个人信息
    func pushMineDetailVC() {
        let vc = MineDetailVC(nibName: "MineDetailVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //资金管理
    func pushFundsManagerVC() {
        let vc = MyWalletVC(nibName: "MyWalletVC", bundle: nil)
        vc.user_money = self.user_money
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //收货地址
    func pushShippingAddressVC() {
        let vc = ShippingAddressVC(nibName: "ShippingAddressVC", bundle: nil)
        vc.ifDatas = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //设置
    @IBAction func pushSetVC(sender: UITapGestureRecognizer) {
        
    }
    //全部订单
    @IBAction func pushAllOrder(sender: UITapGestureRecognizer) {
        
    }
    //待付款
    @IBAction func pushwitePay(sender: UITapGestureRecognizer) {
        
    }
    //待发货
    @IBAction func pushwaitShip(sender: UITapGestureRecognizer) {
        
    }
    //待收货
    @IBAction func pushwaitReceive(sender: UITapGestureRecognizer) {
        
    }
    //退款售后
    @IBAction func pushwaitRefund(sender: UITapGestureRecognizer) {
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController!.tabBar.hidden = false
        if (NSUserDefaults.standardUserDefaults().objectForKey("uid") as? String) == nil {
            
        }else {
            let user_id = NSUserDefaults.standardUserDefaults().objectForKey("uid") as? String
            let manager = AFHTTPSessionManager()   //POST??
            manager.GET("http://api.vsea.com.cn/User/get_user_info?user_id=" + user_id!, parameters: nil, progress: { (progress:NSProgress) -> Void in
                
                }, success: { (task:NSURLSessionDataTask, objects:AnyObject?) -> Void in
                    print(objects)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let dic = (objects as! NSDictionary)["data"] as! NSDictionary
                        self.user_money = dic["user_money"] as! String
                        if dic["head_portrait"] === NSNull() {
                            
                        }else {
                            self.backView.headPicture.sd_setImageWithURL(NSURL(string: (dic["head_portrait"] as? String)!))
                        }
                        self.backView.phoneNumber.text = dic["mobile_phone"] as? String
                        self.backView.depositsLabel.text = dic["user_money"] as? String
                    })
                }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                    print(error)

            })
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = true
        self.navigationController?.setHiddenWithTranslucentWithBarTintColorWithTitleColorWithAlphaWithTitle(false, translucent: false, barTintColor: UIColor.whiteColor(), titleColor: UIColor.blackColor(), alpha: 1.0, title: "个人中心")
        NSBundle.mainBundle().loadNibNamed("MineView", owner: self, options: nil)
        self.backView.frame = CGRectMake(0, 0, WIDTH, 600)
        self.backView.delegate = self
        let scrollView = UIScrollView(frame: CGRectMake(0, 0, WIDTH, HEIGHT))
        scrollView.contentSize = CGSizeMake(WIDTH, 600)
        scrollView.backgroundColor = JX_HexToRGB().hexFloatColor("eeeeee")
        scrollView.addSubview(self.backView)
        self.view.addSubview(scrollView)
        
        // Do any additional setup after loading the view.
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    override func updateViewConstraints() {
//        super.updateViewConstraints()
//        self.scrollViewHeight.constant = 2
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
