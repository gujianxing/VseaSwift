//
//  SearchVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/15.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class SearchVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UIScrollViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var alert:UIView = {
        var view = UIView()
        view.backgroundColor = JX_HexToRGB().hexFloatColor("373c3d")
        let Goods = UIButton(frame: CGRectMake( 0, 0, 80, 34))
        Goods.setTitle("商品", forState: UIControlState.Normal)
        Goods.addTarget(self, action: "searchGoods:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(Goods)
        let line = UIView(frame: CGRectMake( 0, Goods.frame.origin.y + Goods.frame.size.height, 80, 1))
        line.backgroundColor = UIColor.whiteColor()
        view.addSubview(line)
        let Shop = UIButton(frame: CGRectMake( 0, line.frame.origin.y + line.frame.size.height, 80, 33))
        Shop.setTitle("店铺", forState: UIControlState.Normal)
        Shop.addTarget(self, action: "searchShop:", forControlEvents: UIControlEvents.TouchUpInside)
        view.frame = CGRectMake( 10, 64, 80, 69)
        view.addSubview(Shop)
        let picture = UIImageView(image: UIImage(named: "Search_up"))
        picture.frame = CGRectMake((80  - (picture.image?.size.width)!) / 2, -(picture.image?.size.height)!,(picture.image?.size.width)!, (picture.image?.size.height)!)
        view.addSubview(picture)
        view.clipsToBounds = false
        return view
    }()
    
    var titleButton = UIButton(frame: CGRectMake(5, 0, 50, 30))
    var searchTextField = UITextField()
    lazy var NAVView:UIView = {
        var Aview = UIView()
        Aview.frame = CGRectMake(20, 30, 200, 30)
        self.titleButton.setTitle("商品", forState: UIControlState.Normal)
        self.titleButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.titleButton.addTarget(self, action: "popUpPrompts:", forControlEvents: UIControlEvents.TouchUpInside)
        Aview.addSubview(self.titleButton)
        let picture = UIImageView(image: UIImage(named: "Search_down"))
        picture.frame = CGRectMake(self.titleButton.frame.origin.x + self.titleButton.frame.size.width + 5, 15, picture.image!.size.width, picture.image!.size.height)
        Aview.addSubview(picture)
        self.searchTextField.frame = CGRectMake(picture.frame.origin.x + picture.frame.size.width + 5, 0, 120, 30)
        self.searchTextField.delegate = self
        self.searchTextField.placeholder = "搜索商品"
        self.searchTextField.returnKeyType = .Search
        Aview.addSubview(self.searchTextField)
        Aview.backgroundColor = JX_HexToRGB().hexFloatColor("eeeeee")
        Aview.layer.cornerRadius = 15
        return Aview
    }()

    
    var orPopUpPrompts = Bool()  //判断是否弹出提示框
    
    var goodsSource = NSMutableArray()
    var shopSource = NSMutableArray()
    
    var searchSource = NSMutableDictionary()
    var searchSourceArr = NSMutableArray()  //字典无顺序
    
    var ifSearch = false
    var keyword = String()  //搜索关键字
    
    //商品搜索的三个按钮
    var leftButton = UIButton()
    var middleButton = UIButton()
    var rightButton = UIButton()
    var lineCenter: NSLayoutConstraint!
    
    //背景图
    lazy var backView:SearchBackView = {
        var view = NSBundle.mainBundle().loadNibNamed("SearchBackView", owner: self, options: nil).last as! SearchBackView
        return view
    }()
    
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(self.backView)
        self.view.bringSubviewToFront(self.collectionView)
        
        let a = NSMutableDictionary(contentsOfFile: self.getFilePath())
        if a != nil {
            self.searchSource = NSMutableDictionary(contentsOfFile: self.getFilePath())!
        }
        self.tabBarController!.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController!.tabBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setHiddenWithTranslucentWithBarTintColorWithTitleColorWithAlphaWithTitle(false, translucent: false, barTintColor: UIColor.whiteColor(), titleColor: UIColor.blackColor(), alpha: 1.0, title: "")
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Done, target: self, action: "rightAction:")
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.blackColor()
        
        self.navigationController?.view.addSubview(self.NAVView)
        
        self.collectionView.backgroundColor = JX_HexToRGB().hexFloatColor("eeeeee")
        self.collectionView.registerNib(UINib(nibName: "SearchGoodsCell", bundle: nil), forCellWithReuseIdentifier: "GoodsCell")
        self.collectionView.registerNib(UINib(nibName: "SearchShopCell", bundle: nil), forCellWithReuseIdentifier: "ShopCell")
        self.collectionView.registerNib(UINib(nibName: "SearchRecordCell", bundle: nil), forCellWithReuseIdentifier: "SearchCell")
        self.collectionView.registerNib(UINib(nibName: "SearchGoodsHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        self.collectionView.registerNib(UINib(nibName: "SearchRecordFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView")

        // Do any additional setup after loading the view.
    }
    //MARK:返回
    func rightAction(sender:UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
        self.NAVView.removeFromSuperview()
    }
    
    func popUpPrompts(sender:UIButton) {
        self.orPopUpPrompts = !self.orPopUpPrompts
        if self.orPopUpPrompts == true {
            self.navigationController?.view.addSubview(self.alert)
        }else {
            self.alert.removeFromSuperview()
        }
    }
    
    func searchGoods(sender:UIButton) {
        self.alert.removeFromSuperview()
        self.orPopUpPrompts = !self.orPopUpPrompts
        self.titleButton.setTitle("商品", forState: UIControlState.Normal)
    }
    func searchShop(sender:UIButton) {
        self.alert.removeFromSuperview()
        self.orPopUpPrompts = !self.orPopUpPrompts
        self.titleButton.setTitle("店铺", forState: UIControlState.Normal)
    }
    //获取存储路径
    func getFilePath()-> String {
        let documente = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
        let file = documente?.stringByAppendingString("/search.text")
        return file!
    }
    
    //MARK:textfiled  搜索
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //存储搜索记录
        self.searchSource.setValue(textField.text!, forKey: textField.text!)
        self.searchSource.writeToFile(self.getFilePath(), atomically: true)
        //设置搜索关键字
        self.keyword = textField.text!
        self.requestData("goods_id", sequence: "asc")
        self.searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.ifSearch = true
        self.view.bringSubviewToFront(self.collectionView)
        self.collectionView.reloadData()
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.ifSearch == true {
            return self.searchSource.allKeys.count
        }else {
            if self.goodsSource.count > 0 {
                return self.goodsSource.count
            }else {
                return self.shopSource.count
            }
        }

    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if self.ifSearch == true {
            let item = collectionView.dequeueReusableCellWithReuseIdentifier("SearchCell", forIndexPath: indexPath) as! SearchRecordCell
            if self.searchSource.allKeys.count > indexPath.row {
                let title = self.searchSource.allKeys[indexPath.row]
                item.setTitleWithString(title as! String)
            }
            return item
        }else {
            if self.goodsSource.count > 0 {
                let item = collectionView.dequeueReusableCellWithReuseIdentifier("GoodsCell", forIndexPath: indexPath) as! SearchGoodsCell
                if self.goodsSource.count > indexPath.row {
                    let model = self.goodsSource[indexPath.row] as! searchGoodsModel
                    item.setValuesWithModel(model)
                }
                return item
            }else {
                let item = collectionView.dequeueReusableCellWithReuseIdentifier("ShopCell", forIndexPath: indexPath) as! SearchShopCell
                if self.shopSource.count > indexPath.row {
                    let model = self.shopSource[indexPath.row] as! searchShopModel
                    item.setValuesWithModel(model)
                }
                return item
            }
        }
    }
    
    //MARK:点击cell
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.searchTextField.endEditing(true)
        if self.ifSearch == true {
            self.keyword = self.searchSource.allKeys[indexPath.row] as! String
            self.searchTextField.placeholder = self.keyword
            self.requestData("goods_id", sequence: "asc")
        }else {
            
        }
    }
    
    //MARK:尺寸
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if self.ifSearch == true {
            let edge = UIEdgeInsetsMake(0, 0, 0, 0)
            return edge
        }else {
            let edge = UIEdgeInsetsMake(6, 6, 6, 6)
            return edge
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        if self.ifSearch == true {
            return 0
        }else {
            return 6
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        if self.ifSearch == true {
            return 0
        }else {
            return 6
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if self.ifSearch == true {
            let size = CGSizeMake(WIDTH, 45)
            return size
        }else {
            if self.goodsSource.count > 0 {
                let size = CGSizeMake((WIDTH - 18) / 2, 280)
                return size
            }else {
                let size = CGSizeMake(WIDTH - 12, 112)
                return size
            }

        }

    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let view = self.collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", forIndexPath: indexPath) as! SearchGoodsHeader
            self.leftButton = view.allButton
            self.middleButton = view.priceButton
            self.rightButton = view.newButton
            self.lineCenter = view.lineCenter
            
            self.leftButton.addTarget(self, action: "allButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.middleButton.addTarget(self, action: "priceButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.rightButton.addTarget(self, action: "newButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            return view
        }else {
            let view = self.collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", forIndexPath: indexPath) as! SearchRecordFooter
            view.ClearHistory.addTarget(self, action: "clearHistoryAction:", forControlEvents: UIControlEvents.TouchUpInside)
            return view
        }

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            if self.goodsSource.count > 0 {
                let size = CGSizeMake(WIDTH, 40)
                return size
            }else {
                let size = CGSizeMake(WIDTH, 0.0001)
                return size
            }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.ifSearch == true {
            let size = CGSizeMake(WIDTH, 90)
            return size
        }else {
            let size = CGSizeMake(WIDTH, 0)
            return size
        }
    }

    
    //综合排序
    func allButtonAction(sender:UIButton) {
        self.changeButtonTitleColor()
        UIView.animateWithDuration(3) { () -> Void in
            self.lineCenter.constant = 0
        }
        
        sender.setTitleColor(JX_HexToRGB().hexFloatColor("fe4732"), forState: UIControlState.Normal)
        self.requestData("goods_id", sequence: "asc")
    }
    //价格
    var priceSequence = true   //价格顺序
    func priceButtonAction(sender:UIButton) {
        self.priceSequence = !self.priceSequence
        self.changeButtonTitleColor()
        UIView.animateWithDuration(3) { () -> Void in
            self.lineCenter.constant = 0 + sender.frame.size.width
        }
        
        sender.setTitleColor(JX_HexToRGB().hexFloatColor("fe4732"), forState: UIControlState.Normal)
        if self.priceSequence == true {
            self.requestData("shop_price", sequence: "asc")
        }else {
            self.requestData("shop_price", sequence: "desc")
        }
    }
    //新品
    func newButtonAction(sender:UIButton) {
        self.changeButtonTitleColor()
        UIView.animateWithDuration(3) { () -> Void in
            self.lineCenter.constant = 0 + sender.frame.size.width * 2
        }
        
        sender.setTitleColor(JX_HexToRGB().hexFloatColor("fe4732"), forState: UIControlState.Normal)
        self.requestData("add_time", sequence: "asc")
    }
    
    func changeButtonTitleColor() {
        self.leftButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.middleButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.rightButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
    
    
    
    //MARK:清除搜索历史
    func clearHistoryAction(sender:UIButton) {
        self.searchSource.removeAllObjects()
        self.searchSource.writeToFile(self.getFilePath(), atomically: true)
        self.collectionView.reloadData()
    }
    
    //MARK:网络请求   关键字，排序顺序
    func requestData(keywork:String,sequence:String) {
        self.ifSearch = false

        let session = AFHTTPSessionManager()
        var url = String()
        var paras = NSDictionary()
        if self.titleButton.titleLabel?.text == "商品" {
            url = SEARCHGOODS
            paras = ["keywords":self.keyword,"sort":keywork, "order":sequence]

        }else {
            url = SEARCHSHOP
            paras = ["data":self.keyword]
        }
        
        session.GET(url, parameters: paras, progress: { (progress:NSProgress) -> Void in
            
            }, success: { (task:NSURLSessionDataTask, objects:AnyObject?) -> Void in
                if url == SEARCHGOODS {
                    //                    print(objects)
                    self.goodsSource.removeAllObjects()
                    self.shopSource.removeAllObjects()
                    let arr = ((objects as! NSDictionary)["data"] as! NSDictionary)["goods_list"] as! NSArray
                    for dic in arr {
                        let model = searchGoodsModel()
                        model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                        self.goodsSource.addObject(model)
                    }
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if self.goodsSource.count == 0 {
                            self.view.bringSubviewToFront(self.backView)
                        }else {
                            self.view.bringSubviewToFront(self.collectionView)
                        }
                    })

                }else {
//                    print(objects)
                    self.shopSource.removeAllObjects()
                    self.goodsSource.removeAllObjects()
                    if (objects as! NSDictionary)["status"] as! Int == 1 {
                        let arr = ((objects as! NSDictionary)["data"] as! NSDictionary)["context"] as! NSArray
                        for dic in arr {
                            let model = searchShopModel()
                            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                            self.shopSource.addObject(model)
                        }
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            if self.shopSource.count == 0 {
                                self.view.bringSubviewToFront(self.backView)
                            }else {
                                self.view.bringSubviewToFront(self.collectionView)
                            }
                        })
                    }else {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.view.bringSubviewToFront(self.backView)
                        })
                    }
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.collectionView.reloadData()
                })
            }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                print(error)
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.searchTextField.endEditing(true)
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
