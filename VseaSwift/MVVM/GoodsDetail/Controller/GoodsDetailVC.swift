//
//  GoodsDetailVC.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/2.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class GoodsDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.creatBackView()

    }

    
    func creatBackView() {
        let back = GoodsDetailBackView(frame: CGRectMake(0, 0, WIDTH, HEIGHT))
        self.view.addSubview(back)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
