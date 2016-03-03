//
//  HomeClassViewModel.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/2.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

/*
viewModel即视图模型，对视图展示数据进行处理，一般流程是，接受vc的事件命令请求及处理相关数据，完事之后将标准展示数据处理好交给vc展示到view上，此谓视图模型。将视图模型分离出来，与视图类做法类似，留出操作接口，协议及代理，这样一来，对于数据层又可以重用，只要vc符合相关的协议，那么在不同的vc中就可以用同一个viewModel了。封装性和重用性得以体现，而且便于测试。

    每个view对应一个viewModel,而不是每个cell对应一个viewModel

*/



class HomeClassViewModel: NSObject {
    
    
    func getDatasourceFromeViewModel(datasource:(source:NSMutableDictionary)->Void) {
        let requeset = HomeRequest()
        requeset.requestDatas(timeOut: 20, url: "http://192.168.1.47/api/v2/ad/get_adList") { (objects) -> Void in
            let result = objects as! NSDictionary
//            print(result)
            let modelResult = NSMutableDictionary()
            
            //轮播图adsList
            let adsList:NSMutableArray = NSMutableArray()
            let arradsList = result["data"]!["adsList"] as! NSArray
            for dic in arradsList {
                let model = HomeDivisionModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                adsList.addObject(model)
            }
            modelResult.setValue(adsList, forKey: "adsList")
            
            //分类categoryList
            let categoryList:NSMutableArray = NSMutableArray()
            let arrcategoryList = result["data"]!["categoryList"] as! NSArray
            for dic in arrcategoryList {
                let model = HomeClassModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                categoryList.addObject(model)
            }
            modelResult.setValue(categoryList, forKey: "categoryList")

            //专区specList
            let specList:NSMutableArray = NSMutableArray()
            let arrspecList = result["data"]!["specList"] as! NSArray
            for dic in arrspecList {
                let model = HomeDivisionModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                specList.addObject(model)
            }
            modelResult.setValue(specList, forKey: "specList")

            //品牌brandList
            let brandList:NSMutableArray = NSMutableArray()
            let arrbrandList = result["data"]!["brandData"]!!["brandList"] as! NSArray
            for dic in arrbrandList {
                let model = HomeDivisionModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                brandList.addObject(model)
            }
            modelResult.setValue(brandList, forKey: "brandList")

            //活动actList
            let actList:NSMutableArray = NSMutableArray()
            let arractList = result["data"]!["actData"]!!["actList"] as! NSArray
            for dic in arractList {
                let model = HomeDivisionModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                actList.addObject(model)
            }
            modelResult.setValue(actList, forKey: "actList")
            
            //品牌馆标题
            modelResult.setValue(result["data"]!["brandData"]!!["brandTitle"], forKey: "brandTitle")
            //活动标题
            modelResult.setValue(result["data"]!["actData"]!!["actTitle"], forKey: "actTitle")

            
            datasource(source: modelResult)
            
        }
        
    }
    
    
    
    
    
}
