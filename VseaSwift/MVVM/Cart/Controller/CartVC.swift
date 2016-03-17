//
//  CartVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/10.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class CartVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    lazy var tableView:UITableView = {
        var view = UITableView(frame: CGRectMake(0, 0, WIDTH, HEIGHT - 64), style: UITableViewStyle.Grouped)
        view.dataSource = self
        view.delegate = self
        view.registerNib(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        view.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        return view
    }()
    
    lazy var dataSource:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    
    var section = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.title = "购物车"
        // Do any additional setup after loading the view.
        self.requestData()
    }
    
    func requestData() {
        let user_id:String = NSUserDefaults.standardUserDefaults().objectForKey("uid") as! String
        let manager = AFHTTPSessionManager()
        let str = CART + "253"
        manager.GET(str, parameters: nil, progress: { (progress:NSProgress) -> Void in
            
            }, success: { (task:NSURLSessionDataTask, objects:AnyObject?) -> Void in
                let arr:NSArray = objects!["data"] as! NSArray
                for dic in arr {
                    let shopModel = CartShopModel()
                    shopModel.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                    self.dataSource.addObject(shopModel)
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataSource.count > section {
            return (self.dataSource[section] as! CartShopModel).goods_list.count
        }else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CartCell") as! CartTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if self.dataSource.count > indexPath.section {
            let shopModel = self.dataSource[indexPath.section] as! CartShopModel
            if shopModel.goods_list.count > indexPath.row {
                let goodsModel = shopModel.goods_list[indexPath.row] as! CartGoodsModel
                cell.setValuesWithModel(goodsModel)
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 146
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let views:NSArray = NSBundle.mainBundle().loadNibNamed("CartCellHeader", owner: self, options: nil) as NSArray
        let view = views.lastObject as! CartCellHeader
        let tap = UITapGestureRecognizer(target: self, action: "tapHeaderAction:")
        view.tag = 10000 + section
        view.addGestureRecognizer(tap)
        return view
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let views:NSArray = NSBundle.mainBundle().loadNibNamed("CartCellFooter", owner: self, options: nil) as NSArray
        let view = views.lastObject as! CartCellFooter
        return view
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 13
    }
    
    func tapHeaderAction(sender:UITapGestureRecognizer) {
        self.section = (sender.view?.tag)! - 10000
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
