//
//  MineDetailVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/14.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit
import AVFoundation
class MineDetailVC: UIViewController, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countyLabel: UILabel!
    
    var headeImageURL = String()  //图片的链接
    
    
    lazy var alert:UIAlertView = {
        var view = UIAlertView()
        view.addButtonWithTitle("确定")
        return view
    }()
    
    //地址
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

    lazy var dataSource:NSDictionary = {
        let file:String = NSBundle.mainBundle().pathForResource("Address", ofType: "plist")!
        var source:NSDictionary = NSDictionary(contentsOfFile: file)!
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
    
    var chooseFirstComponent = 0
    var chooseSecondComponent = 0
    //时间
    lazy var datePickButton:UIButton = {
        var button = UIButton(frame: CGRectMake(0, HEIGHT - self.picker.frame.size.height - 30, WIDTH, 30))
        button.setTitle("取消", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.addTarget(self, action: "datePickButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button.backgroundColor = UIColor.lightGrayColor()
        return button
    }()
    lazy var datePick:UIDatePicker = {
        var date = UIDatePicker()
        date.datePickerMode = .Date
        date.frame = CGRectMake(0, HEIGHT - 150, WIDTH, 150)
        date.addTarget(self, action: "dataPickAction:", forControlEvents: UIControlEvents.ValueChanged)
        return date
    }()
    
    
    //修改个人信息
    @IBAction func headPicture(sender: UITapGestureRecognizer) {
        let sheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil)
        sheet.addButtonWithTitle("拍照选择头像")
        sheet.addButtonWithTitle("从图库选择头像")
        sheet.showInView(self.view)
    }
    @IBAction func birthday(sender: UITapGestureRecognizer) {
        self.picker.removeFromSuperview()
        self.pickerButton.removeFromSuperview()
        self.view.addSubview(self.datePick)
        self.view.addSubview(self.datePickButton)
    }
    @IBAction func hometown(sender: UITapGestureRecognizer) {
        self.datePick.removeFromSuperview()
        self.datePickButton.removeFromSuperview()
        self.view.addSubview(self.picker)
        self.view.addSubview(self.pickerButton)
    }
    
    @IBAction func bindingAccount(sender: UITapGestureRecognizer) {
        
    }
    @IBAction func verifiedAccounts(sender: UITapGestureRecognizer) {
        
    }
    
    //MARK:DatePick
    func datePickButtonAction(sender:UIButton) {
        self.datePick.removeFromSuperview()
        self.datePickButton.removeFromSuperview()
    }
    func dataPickAction(sender:UIDatePicker) {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-d"
        let str = formatter.stringFromDate(sender.date)
        self.birthdayLabel.text = str
    }
    
    //MARK:pickerView
    func pickerButtonAction(sender:UIButton) {
        self.picker.removeFromSuperview()
        self.pickerButton.removeFromSuperview()
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.dataSource.allKeys.count
        }else if component == 1 {
            return (self.secondSource[0] as! NSDictionary).allKeys.count
        }else {
            return self.thirdSource.count
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            if self.dataSource.allKeys.count > row {
                return self.dataSource.allKeys[row] as? String
            }else {
                return nil
            }
        }else if component == 1 {
            if (self.secondSource[0] as! NSDictionary).allKeys.count > row {
                return (self.secondSource[0] as! NSDictionary).allKeys[row] as? String
            }else {
                return nil
            }
        }else {
            if self.thirdSource.count > row {
                return self.thirdSource[row] as? String
            }else {
                return nil
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.chooseFirstComponent = row
            self.province = self.dataSource.allKeys[self.chooseFirstComponent] as! String
            self.secondSource = self.dataSource[self.province] as! NSMutableArray
            self.chooseSecondComponent = 0
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            self.provinceLabel.text = self.province
        }else if component == 1 {
            self.chooseSecondComponent = row
            self.city = (self.secondSource[0] as! NSDictionary).allKeys[self.chooseSecondComponent] as! String
            self.thirdSource = (self.secondSource[0] as! NSDictionary)[city] as! NSMutableArray
            pickerView.reloadComponent(2)
            self.cityLabel.text = self.city
        }else {
            self.county = self.thirdSource[row] as! String
            self.countyLabel.text = self.county
        }
    }
    
    //MARK:actionSheet
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        if buttonIndex == 1 {
            imagePicker.sourceType = .Camera
            if AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) == .Restricted || AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) == .Denied {
                self.alert.title = "通知"
                self.alert.message = "相机设备不可用"
                self.alert.show()
            }else {
                self.navigationController!.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }else if buttonIndex == 2 {
            imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }else {
            
        }
        
    }
    
    //MARK:IMAGEPICK
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.headImage.image = image
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        let data = UIImagePNGRepresentation(self.headImage.image!)
        AddDataRequest.uploadPhoto(data!, params: nil) { (detail) -> Void in
            if (detail as! NSDictionary)["error_code"] as! Int == 1 {
                self.headeImageURL = (detail as! NSDictionary)["data"] as! String
            }else {
                
            }
        }
    }
    
    
    //MARK:TextFileDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    
    
    override func loadView() {
        super.loadView()

    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人资料"
        self.navigationItem.setLeftBarButtonItemWithImage("return", style: UIBarButtonItemStyle.Done, target: self, action: "leftAction:", tintColor: nil)
        self.tabBarController?.tabBar.hidden = true
        
        self.province = self.dataSource.allKeys[self.chooseFirstComponent] as! String
        self.secondSource = self.dataSource[self.province] as! NSMutableArray
        self.city = (self.secondSource[0] as! NSDictionary).allKeys[self.chooseSecondComponent] as! String
        self.thirdSource = (self.secondSource[0] as! NSDictionary)[self.city] as! NSMutableArray
        self.county = self.thirdSource[0] as! String
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("123")
    }
    
    func leftAction(sender:UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
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
