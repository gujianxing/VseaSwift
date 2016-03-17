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
    
    //设置tabbar
    func setChildViewControllerWithNameAndImage(name:String, image:UIImage, selectImage:UIImage) {
        self.tabBarItem.title = name
        self.tabBarItem.image = image
        self.tabBarItem.selectedImage = selectImage
    }
    
    //调整控制器属性
    func changeHomeProperty() {
        self.navigationBar.translucent = true
        self.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationBar.subviews.first?.alpha = 0
    }

    //显示控制器，设置标题
    func setHiddenWithTranslucentWithBarTintColorWithTitleColorWithAlphaWithTitle(hidden:Bool, translucent:Bool, barTintColor:UIColor, titleColor:UIColor, alpha:CGFloat, title:String) {
        self.navigationBar.hidden = hidden
        self.navigationBar.translucent = translucent
        self.navigationBar.barTintColor = barTintColor
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:titleColor]
        self.navigationBar.subviews.first?.alpha = alpha
        self.childViewControllers.last?.title = title
    }

}