//
//  HomeGoodsDetailViewModel.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/2.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class HomeGoodsDetailViewModel: NSObject {
    
    
    func getDataSourceFromeViweModel(datasource:(source:NSMutableArray)->Void) {
        HomeRequest().requestDatas(timeOut: 20, url: "http://192.168.1.47/api/v2/goods/get_newGoodsList") { (objects) -> Void in
            let arrModel = NSMutableArray()
            let result = objects as! NSDictionary
            let arrGoods:NSArray = result["data"] as! NSArray
            for dic in arrGoods {
                let model = HomeGoodsDetailModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                arrModel.addObject(model)
            }
            
            datasource(source: arrModel)
        }
        
    }
    

}
