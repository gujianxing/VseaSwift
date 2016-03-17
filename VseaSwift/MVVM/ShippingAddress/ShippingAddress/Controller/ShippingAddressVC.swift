//
//  ShippingAddressVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/10.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class ShippingAddressVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ifDatas = Bool()
    
    lazy var dataSource:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    
    lazy var tableView:UITableView = {
        var view = UITableView(frame: CGRectMake(0, 0, WIDTH, HEIGHT))
        view.registerNib(UINib(nibName: "ShippingAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = JX_HexToRGB().hexFloatColor("eeeeee")
        view.separatorStyle = .None
        return view
    }()
    
    lazy var addButton:UIButton = {
        let btn = UIButton(frame: CGRectMake(45, HEIGHT - 90 - 64, WIDTH - 90, 45))
        btn.layer.cornerRadius = 22
        btn.addTarget(self, action: "addShippingAddress:", forControlEvents: .TouchUpInside)
        btn.backgroundColor = JX_HexToRGB().hexFloatColor("FE4732")
        btn.setTitle("新增地址", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(21)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.reuqestData()
    }
    
    func reuqestData() {
        self.dataSource.removeAllObjects()
        let user_id = NSUserDefaults.standardUserDefaults().objectForKey("uid") as? String
        if user_id == nil {
            
        }else {
            let manager = AFHTTPSessionManager()
            manager.GET("http://api.vsea.com.cn/User/get_address_list?user_id=" + user_id!, parameters: nil, progress: { (progress:NSProgress) -> Void in
                
                }, success: { (task:NSURLSessionDataTask, objects:AnyObject?) -> Void in
                    let arr = objects!["data"] as! NSArray
                    for dic in arr {
                        let model = ShippingAddressModel()
                        model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                        self.dataSource.addObject(model)
                    }
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if self.dataSource.count > 0 {
                            self.view.addSubview(self.tableView)
                            self.tableView.reloadData()
                        }else {
                            
                        }
                        self.view.addSubview(self.addButton)
                    })
//                                    print(objects)
                }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                    print(error)
            }
        }

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ShippingAddressTableViewCell
        if self.dataSource.count > indexPath.row {
            let model = self.dataSource[indexPath.row] as! ShippingAddressModel
            if model.is_default != "1" {
                cell.defaultView.hidden = true    //隐藏按钮
            }else {
                cell.defaultView.hidden = false
            }
            cell.setValuesWithModel(model)
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = ShippingAddressEditVC(nibName: "ShippingAddressEditVC", bundle: nil)
        let model = self.dataSource[indexPath.row] as! ShippingAddressModel
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    override func loadView() {
        super.loadView()
        self.tabBarController!.tabBar.hidden = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "return")?.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Done, target: self, action: "leftAction:")
        self.title = "我的收货地址"
        self.tabBarController!.tabBar.hidden = true
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func leftAction(sender:UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func addShippingAddress(sender:UIButton) {
        let vc = ShippingAddressAddVC(nibName: "ShippingAddressAddVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
