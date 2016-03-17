//
//  CartGoodsModel.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/16.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class CartGoodsModel: NSObject {

    var goods_name = String()   //商品名
    var goods_attr = String()   //商品规格
    var goods_price = String()  //商品价格
    var goods_number = String() //购买数量
    var market_price = String() //市场价格
    var goods_thumb = String()  //商品图片
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
