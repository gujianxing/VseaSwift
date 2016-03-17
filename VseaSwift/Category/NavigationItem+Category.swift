//
//  NavigationItem+Category.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/12.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import Foundation
import UIKit
extension UINavigationItem {

    func setLeftBarButtonItemWithTitle(title:String, style:UIBarButtonItemStyle, target:NSObject, action:Selector, tintColor:String?) {
        self.leftBarButtonItem = UIBarButtonItem(title: title, style: style, target: target, action: action)
        self.leftBarButtonItem?.tintColor = JX_HexToRGB().hexFloatColor(tintColor)
    }
    
    func setLeftBarButtonItemWithImage(image:String, style:UIBarButtonItemStyle, target:NSObject, action:Selector, tintColor:String?) {
        self.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: image)?.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Done, target: target, action: action)
        self.leftBarButtonItem?.tintColor = JX_HexToRGB().hexFloatColor(tintColor)
    }
    
    func setRightBarButtonItemWithTitle(title:String, style:UIBarButtonItemStyle, target:NSObject, action:Selector, tintColor:String?) {
        self.leftBarButtonItem = UIBarButtonItem(title: title, style: style, target: target, action: action)
        self.leftBarButtonItem?.tintColor = JX_HexToRGB().hexFloatColor(tintColor)
    }
    
    func setRightBarButtonItemWithImage(image:String, style:UIBarButtonItemStyle, target:NSObject, action:Selector, tintColor:String?) {
        self.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: image)?.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Done, target: target, action: action)
        self.leftBarButtonItem?.tintColor = JX_HexToRGB().hexFloatColor(tintColor)
    }
    
    
}