//
//  Request.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/2/29.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class Request: NSObject {

    class func GetData(timeOut timeOut:NSTimeInterval, url:String, callBack:(response:NSURLResponse, data:AnyObject?, error:NSError?)->Void) {
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = timeOut
        
        let session = NSURLSession(configuration: configuration)
        let task = session.dataTaskWithURL(NSURL(string: url)!) { (data, response, error) -> Void in
            if(data?.length > 0) {
                callBack(response: response!, data: data!, error: error)
            }else {
                print(error)
            }

        }
        
        task.resume()
    }
    
    
    class func PostData(timeOut timeOut:NSTimeInterval, url:String, params:NSDictionary, callBack:(response:NSURLResponse, data:AnyObject?, error:NSError?)->Void) {
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = timeOut
        
        let session = NSURLSession(configuration: configuration)
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if params.allKeys.count > 0 {
            do {
               request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
            }catch {
                
            }
        }else {
            print("缺少params")
        }
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if(data?.length > 0) {
                callBack(response: response!, data: data, error: error)
            }else {
                print(error)
            }
        }
        
        task.resume()
    }
    
    
    
}
