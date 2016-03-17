//
//  ShippingAddressAddVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/11.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class ShippingAddressAddVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    
    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countyLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var detailAddress: UITextField!
    @IBOutlet weak var ifDefault: UISwitch!
    
    
    @IBAction func chooseAddress(sender: AnyObject) {
        self.view.addSubview(self.picker)
        self.view.addSubview(self.pickerButton)
    }
    
    
    //接口传的省市县必须为id，且是json格式
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        self.title = "新增收货地址"
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)], forState: UIControlState.Normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Done, target: self, action: "leftAction:")
        self.navigationItem.leftBarButtonItem?.tintColor = JX_HexToRGB().hexFloatColor("000000")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Done, target: self, action: "rightAction:")
        self.navigationItem.rightBarButtonItem?.tintColor = JX_HexToRGB().hexFloatColor("FE4732")
        
        let filePath = NSBundle.mainBundle().pathForResource("Address", ofType: "json")! as String
        let data = NSData(contentsOfFile: filePath)
        do {
            let dic = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as! NSDictionary
            self.addressSource = dic["data"] as! NSMutableArray
        }catch {
            
        }
        
        self.secondSource = self.addressSource[self.chooseFirstComponent]["child"] as! NSMutableArray
        self.thirdSource = self.secondSource[self.chooseSecondComponent]["child"] as! NSMutableArray
        
        self.province = self.addressSource[self.chooseFirstComponent]["region_name"] as! String
        self.provinceCode = self.addressSource[self.chooseFirstComponent]["region_id"] as! String
        self.city = self.secondSource[self.chooseSecondComponent]["region_name"] as! String
        self.cityCode = self.addressSource[self.chooseFirstComponent]["region_id"] as! String
        self.county = self.thirdSource[self.chooseThirdComponent]["region_name"] as! String
        self.countyCode = self.thirdSource[self.chooseThirdComponent]["region_id"] as! String
        
    }
    
    func pickerButtonAction(sender:UIButton) {
        self.picker.removeFromSuperview()
        self.pickerButton.removeFromSuperview()
    }
    
    
    func leftAction(sender:UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    //MARK:添加地址
    func rightAction(sender:UIBarButtonItem) {
        let manager = AFHTTPSessionManager()
        let user_id = NSUserDefaults.standardUserDefaults().objectForKey("uid") as! String
        let dic = ["province":self.provinceCode,"city":self.cityCode,"district":self.countyCode,"address":self.detailAddress.text!,"user_id":user_id,"consignee":self.nameTextField.text!,"mobile":self.phoneNumber.text!,"is_default":Int(self.ifDefault.on)]
        do {
            let datas = try NSJSONSerialization.dataWithJSONObject(dic, options: .PrettyPrinted)
            let data = String(data: datas, encoding: NSUTF8StringEncoding)!
            
            if self.provinceLabel.text?.characters.count != 0 && self.cityLabel.text?.characters.count != 0 && self.countyLabel.text?.characters.count != 0 && self.detailAddress.text?.characters.count != 0 && self.nameTextField.text?.characters.count != 0 && self.phoneNumber.text?.characters.count != 0   {
                
                let params = ["data":data]
                manager.POST(ADDADDRESS, parameters: params, progress: { (progress:NSProgress) -> Void in
                    
                    }, success: { (task:NSURLSessionDataTask, objects:AnyObject?) -> Void in
                        let dic = objects as! NSDictionary
                        if dic["status"] as! Int == 1 {
                            self.navigationController?.popViewControllerAnimated(true)
                        }else {
                            let alert = UIAlertView()
                            alert.title = "通知"
                            alert.message = "错误"
                            alert.addButtonWithTitle("确定")
                            alert.show()
                        }
                    }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                        
                }
                
            }else {
                let alert = UIAlertView()
                alert.title = "通知"
                alert.message = "请完善您的信息"
                alert.addButtonWithTitle("确定")
                alert.show()
            }
            
            
        }catch {
            
        }
        

        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.addressSource.count
        }else if component == 1 {
            return self.secondSource.count
        }else {
            return self.thirdSource.count
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            if self.addressSource.count > row {
                return self.addressSource[row]["region_name"] as? String
            }else {
                return nil
            }
        }else if component == 1 {
            if self.secondSource.count > row {
                return self.secondSource[row]["region_name"] as? String
            }else {
                return nil
            }
        }else {
            if self.thirdSource.count > row {
                return self.thirdSource[row]["region_name"] as? String
            }else {
             return nil
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.chooseFirstComponent = row
            self.chooseSecondComponent = 0
            self.chooseThirdComponent = 0
            
            self.secondSource = self.addressSource[self.chooseFirstComponent]["child"] as! NSMutableArray
            self.thirdSource = self.secondSource[self.chooseSecondComponent]["child"] as! NSMutableArray
            
            self.province = self.addressSource[self.chooseFirstComponent]["region_name"] as! String
            self.provinceCode = self.addressSource[self.chooseFirstComponent]["region_id"] as! String
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            self.provinceLabel.text = self.province
        }else if component == 1 {
            self.chooseSecondComponent = row
            self.chooseThirdComponent = 0
            self.thirdSource = self.secondSource[self.chooseSecondComponent]["child"] as! NSMutableArray
            self.city = self.secondSource[self.chooseSecondComponent]["region_name"] as! String
            self.cityCode = self.addressSource[self.chooseFirstComponent]["region_id"] as! String
            pickerView.reloadComponent(2)
            self.cityLabel.text = self.city
        }else {
            self.chooseThirdComponent = row
            self.county = self.thirdSource[self.chooseThirdComponent]["region_name"] as! String
            self.countyCode = self.thirdSource[self.chooseThirdComponent]["region_id"] as! String
            self.countyLabel.text = self.county
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
    lazy var pickerButton:UIButton = {
        var button = UIButton(frame: CGRectMake(0, HEIGHT - self.picker.frame.size.height - 30, WIDTH, 30))
        button.setTitle("取消", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.addTarget(self, action: "pickerButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button.backgroundColor = UIColor.lightGrayColor()
        return button
    }()
    lazy var picker:UIPickerView = {
        var view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        view.frame = CGRectMake(0, HEIGHT - 150, WIDTH, 150)
        return view
    }()

    lazy var addressSource:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    lazy var secondSource:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    lazy var thirdSource:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    
    var province = String()
    var city = String()
    var county = String()
    
    var provinceCode = String()
    var cityCode = String()
    var countyCode = String()
    
    var chooseFirstComponent = 0
    var chooseSecondComponent = 0
    var chooseThirdComponent = 0

    

    
    
    

}
