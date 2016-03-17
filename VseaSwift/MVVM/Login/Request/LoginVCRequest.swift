//
//  LoginVCRequest.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/14.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class LoginVCRequest: NSObject {
    class func GetRequest(name:String ,password:String, AllRespond:(details:AnyObject?)->Void) {
        let str = LOGIN+"user="+name+"&password="+password+"&remember=1"
        Request.GetData(timeOut: 10, url: str) { (response, data, error) -> Void in
//            let strs = NSString(data: data as! NSData, encoding: NSUTF8StringEncoding)
//            print(strs)
            do {
                let object = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: .MutableLeaves)
                AllRespond(details: object)
            }catch {
                print(response)
                print(error)
            }

        }
    }
}
