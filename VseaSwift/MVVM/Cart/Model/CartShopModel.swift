//
//  CartShopModel.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/16.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class CartShopModel: NSObject {

    var shop_id = String()      //店铺id
    var shopname = String()     //店铺名
    var cart_shop_price = String()    //店铺商品总价
    var cart_shop_goods_list = NSMutableArray()  //商品列表
    
    var goods_model = CartGoodsModel()
    var goods_list = NSMutableArray()
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {

    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "cart_shop_goods_list" {
            let arr = value as! NSArray
            for dic in arr {
                let model = CartGoodsModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                self.goods_list.addObject(model)
            }
        }
    }
    
}
