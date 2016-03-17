//
//  HomeVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/2/29.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,categoryDelegate,divisionDelegate {
    lazy var MainView:HomeMainView = {
        var view = HomeMainView(frame: CGRectMake(0, 182, WIDTH, HEIGHT - 182))
        return view
    }()
    lazy var dataSource:NSMutableDictionary = {
        var source = NSMutableDictionary()
        return source
    }()
    lazy var goodsSource:NSMutableArray = {
        var source = NSMutableArray()
        return source
    }()
    var searchName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        self.changeNavigationController()

        //weak修饰
        HomeClassViewModel().getDatasourceFromeViewModel { (source) -> Void in
            self.dataSource = source
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //headerview需要datasource的数据
                self.creatMainView()
            })
        }
        
        HomeGoodsDetailViewModel().getDataSourceFromeViweModel { (source) -> Void in
            self.goodsSource = source
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.MainView.reloadData()
            })
        }
        

    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {

    }
    
    func actionSheetCancel(actionSheet: UIActionSheet) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("finish")
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("finish...")
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("qu")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        self.tabBarController?.tabBar.hidden = false
        self.navigationController?.setHiddenWithTranslucentWithBarTintColorWithTitleColorWithAlphaWithTitle(false, translucent: true, barTintColor: UIColor.whiteColor(), titleColor: UIColor.clearColor(), alpha: 0, title: "首页")
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
        self.navigationController?.setHiddenWithTranslucentWithBarTintColorWithTitleColorWithAlphaWithTitle(false, translucent: false, barTintColor: UIColor.whiteColor(), titleColor: UIColor.clearColor(), alpha: 1.0, title: "首页")
    }
    
    func changeNavigationController() {
        navigationController?.changeHomeProperty()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search_white")?.imageWithRenderingMode(.AlwaysOriginal), style: .Done, target: self, action: "searchAction")
        self.searchName = "Search_white"
    }
    func searchAction() {
        print(123)
        let vc = SearchVC(nibName: "SearchVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func creatMainView() {
        self.MainView = HomeMainView(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: .Plain)
        self.view.addSubview(self.MainView.creatMainView(self, delegate: self, nibName: ["HomeClassTabCell","HomeDivisionCell","HomeTitleCell","HomeAdvertisementCell","HomeGoodsDetailCell"], ids: ["class","division","title","advertisement","detail"],modelResult: self.dataSource))
    }
    
    
    
    //MARK:TABLEVIEW
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.MainView.returnNunmberOfRows(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.MainView.returnCellForIndexPath(indexPath, identifiers: [["class"],["division"],["title","advertisement"],["title","advertisement"],["title","detail"]]) as! UITableViewCell
        if indexPath.section == 4 {
            cell.setValuesWithIndexPath(indexPath, arrModelResult: self.goodsSource)
        }else {
            cell.setValuesWithIndexPath(indexPath, dicModelResult: self.dataSource)
            if indexPath.section == 0 {
                let acell = cell as! HomeClassTabCell
                acell.delegate = self
            }else if indexPath.section == 1 {
                let acell = cell as! HomeDivisionCell
                acell.delegate = self
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height = self.MainView.returnHeightForRow(indexPath)
        return height
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 
        let vc = ResetPasswordVC(nibName: "ResetPasswordVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:categoryDelegate
    func selectCategoryListItem(indexPath: NSIndexPath) {
        print("分类\(indexPath.row)")
        
        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK:divisionDelegate
    func selectItem(tap: UITapGestureRecognizer) {
        print("分区\(tap.view?.tag)")
        let vc = AddDataVC(nibName: "AddDataVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
 
    //MARK:scrollerView
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y <= 70.0) {
            if self.searchName == "Search" {
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "Search_white")?.imageWithRenderingMode(.AlwaysOriginal)
                UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
            }
            self.searchName = "Search_white"
        }else{
            if self.searchName == "Search_white" {
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "Search")?.imageWithRenderingMode(.AlwaysOriginal)
                UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
                self.searchName = "Search"
            }
        }
        
        if (scrollView.contentOffset.y >= 0 ) {
            if (scrollView.contentOffset.y / 64.0 <= 1.0) {
                self.navigationController?.navigationBar.subviews.first?.alpha = scrollView.contentOffset.y / 64
            }else{
                self.navigationController?.navigationBar.subviews.first?.alpha = 1.0
            }
        }else {
            self.navigationController?.navigationBar.subviews.first?.alpha = 0.0
        }
        
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

    //MARK:UM
    

    //
    //        //分享
    //        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "55ff995867e58e4fd20003e1", shareText: "哈哈", shareImage: UIImage(named: "d"), shareToSnsNames: [UMShareToTencent,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQzone,UMShareToQQ], delegate: self)
    
//    //分享成功回调
//    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
//        
//        if(response.responseCode == UMSResponseCodeSuccess) {
//            print("yes")
//        }
//    }
    
}
