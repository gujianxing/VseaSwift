//
//  HomeRequest.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/2/29.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class HomeRequest: NSObject {

    
    
    func requestDatas(timeOut timeOut:NSTimeInterval, url:String, callBack:(objects:NSObject)->Void) {
        Request.GetData(timeOut: timeOut, url: url) { (response, data, error) -> Void in
            do {
                let object = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: .MutableLeaves)
                callBack(objects: object as! NSObject)
            }catch {
                
            }
            
        }
        
    }
    
    
    
}
