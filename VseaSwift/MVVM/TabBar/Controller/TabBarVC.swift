//
//  TabBarVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/2/29.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = HomeVC()
        self.addChildViewControllerWithNameAndImage(homeVC, name: "主页", image: UIImage(named: "d")!)
        
        let det = GoodsDetailVC()
        self.addChildViewControllerWithNameAndImage(det, name: "详情", image: UIImage(named: "d")!)
    }
    
    
    
    func addChildViewControllerWithNameAndImage(vc:UIViewController, name:String, image:UIImage) {
        let nav = UINavigationController(rootViewController: vc)
        nav.setChildViewControllerWithNameAndImage(name, image: image)
        
        self.addChildViewController(nav)
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
