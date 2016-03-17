//
//  RegisterRequest.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/14.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class RegisterRequest: NSObject {

    class func GETRequest(phoneNumber:String, allRespond:(objects:AnyObject)->Void) {
        let str = SMS_CODE + "phone=" + phoneNumber + "&ignoreVCode=1"
        Request.GetData(timeOut: 10, url: str) { (response, data, error) -> Void in
            do {
                let detail = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableLeaves)
                print(detail)
                allRespond(objects: detail)
            }catch {
                
            }
        }
    }
}
