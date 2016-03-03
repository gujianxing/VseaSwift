//
//  NavigationController+Category.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/1.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import Foundation
import UIKit


extension UINavigationController {
    
    //添加视图标题和子控制器
     func setChildViewControllerWithNameAndImage(name:String, image:UIImage) {
        self.tabBarItem.title = name
        self.tabBarItem.image = image
        
    }
    
    //调整控制器属性
    func changeHomeProperty() {
        self.navigationBar.translucent = true
        self.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationBar.subviews.first?.alpha = 0
    }

    

}