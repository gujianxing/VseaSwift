//
//  AddDataRequest.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/14.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class AddDataRequest: NSObject {

    class func uploadPhoto(data:NSData, params:NSDictionary?, allRespond:(detail:AnyObject)->Void) {
        let manager = AFHTTPSessionManager()
        manager.POST(UPlOADPHOTO, parameters: nil, constructingBodyWithBlock: { (datas:AFMultipartFormData) -> Void in
            datas.appendPartWithFileData(data, name: "headePicture", fileName: "headePicture.png", mimeType: "image/png")
            }, progress: { (progress:NSProgress) -> Void in
                print(progress)
            }, success: { (task:NSURLSessionDataTask, detail:AnyObject?) -> Void in
                allRespond(detail: detail!)
            }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                print(error)
        }
        
    }
    
    class func POSTRequest(params:NSDictionary, allRespond:(detail:AnyObject?)->Void){
        let manager = AFHTTPSessionManager()
        manager.POST(REGISTER, parameters: params, progress: { (progress:NSProgress) -> Void in
            
            }, success: { (task:NSURLSessionDataTask, objects:AnyObject?) -> Void in
                allRespond(detail: objects)
            }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                
        }
    }
    
    

    
}
