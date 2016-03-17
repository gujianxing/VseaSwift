//
//  ShippingAddressModel.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/16.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class ShippingAddressModel: NSObject {
    
    var consignee = String() //姓名
    var mobile = String() //手机号
    var tel = String() //手机号
    var address_name = String()  //地址
    var address = String() //详细地址
    var is_default = String()  //是否为默认地址,1为默认
    var address_id = String() //删除订单id
    
    var province = String() //省编码
    var city = String()     //市编码
    var district = String() //县编码

    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
