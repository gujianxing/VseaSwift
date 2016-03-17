//
//  TabBarVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/2/29.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController,UITabBarControllerDelegate {

    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.hidden = true
//        if self.selectedIndex == 3 {
//            
//        }else {
//            self.selectedIndex = 0
//        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let homeVC = HomeVC()
        self.addChildViewControllerWithNameAndImage(homeVC, name: "首页", image: UIImage(named: "Home")!, selectImage: UIImage(named: "Home_select")!)
        
        let cartVC = CartVC(nibName: "CartVC", bundle: nil)
        self.addChildViewControllerWithNameAndImage(cartVC, name: "购物车", image: UIImage(named: "Cart")!, selectImage: UIImage(named: "Cart_select")!)
        
        let hometownVC = HometownVC(nibName: "HometownVC", bundle: nil)
        self.addChildViewControllerWithNameAndImage(hometownVC, name: "乡情馆", image: UIImage(named: "Hometown")!, selectImage: UIImage(named: "Hometown_select")!)
        
//        let mineVC = MineVC(nibName: "MineVC", bundle: nil)
        let mineVC = MineVC()
        self.addChildViewControllerWithNameAndImage(mineVC, name: "我的", image: UIImage(named: "Mine")!, selectImage: UIImage(named: "Mine_select")!)
        
        
        
//        let detVC = GoodsDetailVC()
//        self.addChildViewControllerWithNameAndImage(detVC, name: "详情", image: UIImage(named: "d")!)
    }
    
    
    func addChildViewControllerWithNameAndImage(vc:UIViewController, name:String, image:UIImage, selectImage:UIImage) {
        let nav = UINavigationController(rootViewController: vc)
        nav.setChildViewControllerWithNameAndImage(name, image: image, selectImage: selectImage)
        self.addChildViewController(nav)
    }

    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print(self.selectedIndex)
        if self.selectedIndex == 2 {
            let loginVC = LoginVC(nibName: "LoginVC", bundle: nil)
            self.navigationController?.pushViewController(loginVC, animated: true)
//            let nav = UINavigationController(rootViewController: loginVC)
//            nav.modalTransitionStyle = .CoverVertical
//            self.navigationController?.presentViewController(nav, animated: true, completion: nil)
        }else {
            
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

}
