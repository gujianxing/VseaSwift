//
//  AddDataVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/7.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit
import AVFoundation
class AddDataVC: UIViewController, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countyLabel: UILabel!
    @IBOutlet weak var boyButton: UIButton!
    @IBOutlet weak var girlButton: UIButton!
    
    lazy var alert:UIAlertView = {
        var view = UIAlertView()
        view.addButtonWithTitle("确定")
        return view
    }()
    
    var phoneNumber = String()
    var SMSCode = String()
    var passWord = String()
    var headeImageURL = String()
    var BotOrGirl = Bool()
    var sex = 1
    
    
    lazy var picker:UIPickerView = {
        var view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        view.frame = CGRectMake(0, HEIGHT - 150, WIDTH, 150)
        return view
    }()
    lazy var pickerButton:UIButton = {
        var button = UIButton(frame: CGRectMake(0, HEIGHT - self.picker.frame.size.height - 30, WIDTH, 30))
        button.setTitle("取消", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.addTarget(self, action: "pickerButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button.backgroundColor = UIColor.lightGrayColor()
        return button
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setHiddenWithTranslucentWithBarTintColorWithTitleColorWithAlphaWithTitle(false, translucent: false, barTintColor: UIColor.whiteColor(), titleColor: UIColor.blackColor(), alpha: 1.0, title: "填写资料")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "return")?.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Done, target: self, action: "leftAction:")
        self.province = self.dataSource.allKeys[self.chooseFirstComponent] as! String
        self.secondSource = self.dataSource[self.province] as! NSMutableArray
        self.city = (self.secondSource[0] as! NSDictionary).allKeys[self.chooseSecondComponent] as! String
        self.thirdSource = (self.secondSource[0] as! NSDictionary)[self.city] as! NSMutableArray
        self.county = self.thirdSource[0] as! String
        // Do any additional setup after loading the view.
        let data = UIImagePNGRepresentation(self.headImage.image!)
        AddDataRequest.uploadPhoto(data!, params: nil) { (detail) -> Void in
            if (detail as! NSDictionary)["error_code"] as! Int == 1 {
                self.headeImageURL = (detail as! NSDictionary)["data"] as! String
            }else {
                
            }
        }
    }
    
    func leftAction(sender:UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func selectHomeTown(sender: UITapGestureRecognizer) {
        self.view.addSubview(self.picker)
        self.view.addSubview(self.pickerButton)
     }
    
    func pickerButtonAction(sender:UIButton) {
        self.picker.removeFromSuperview()
        self.pickerButton.removeFromSuperview()
    }
    //MARK:pickerView
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

    
    
    @IBAction func selectPicture(sender: UITapGestureRecognizer) {
        let sheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil)
        sheet.addButtonWithTitle("拍照选择头像")
        sheet.addButtonWithTitle("从图库选择头像")
        sheet.showInView(self.view)
    }

    
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
                self.navigationController?.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }else if buttonIndex == 2 {
            imagePicker.sourceType = .PhotoLibrary
            self.navigationController?.presentViewController(imagePicker, animated: true, completion: nil)
        }else {
            
        }

    }
    
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
    
    @IBAction func selectBoyOrGirl(sender: UIButton) {
        if sender.tag == 2001 {
            boyButton.setImage(UIImage(named: "select"), forState: .Normal)
            girlButton.setImage(UIImage(named: "unselect"), forState: .Normal)
            self.sex = 1
        }else if sender.tag == 2002 {
            girlButton.setImage(UIImage(named: "select"), forState: .Normal)
            boyButton.setImage(UIImage(named: "unselect"), forState: .Normal)
            self.sex = 2
        }else {
            
        }
        
        
    }
    
    @IBAction func allFinish(sender: UIButton) {
        if self.nickName.text?.characters.count == 0 {
            self.alert.message = "请输入昵称"
            self.alert.show()
        }else if self.provinceLabel.text?.characters.count == 0 || self.cityLabel.text?.characters.count == 0 || self.countyLabel.text?.characters.count == 0 {
            self.alert.message = "请输入家乡"
            self.alert.show()
        }else {
            let dic = ["town":["province":self.provinceLabel.text!,"city":self.cityLabel.text!,"area":self.countyLabel.text!]]
            do{
                let data = try NSJSONSerialization.dataWithJSONObject(dic, options: .PrettyPrinted)
                let town:String = String(data: data, encoding: NSUTF8StringEncoding)!
                let params = ["mobile":self.phoneNumber, "password":self.passWord, "sex":self.sex, "nick":self.nickName, "logo":self.headeImageURL, "town":town]
                AddDataRequest.POSTRequest(params, allRespond: { (detail) -> Void in
                    if detail!["status"] as! Int == 1 {
                        self.alert.message = "注册成功"
                        self.alert.show()
                        self.navigationController?.popToRootViewControllerAnimated(false)
                    }else {
                        self.alert.message = "注册失败"
                        self.alert.show()
                    }
                })
            }catch{
                
            }
        }
        
        

        
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
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
