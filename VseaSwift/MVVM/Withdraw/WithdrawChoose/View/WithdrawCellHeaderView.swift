//
//  WithdrawCellHeaderView.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/12.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class WithdrawCellHeaderView: UIView {

    @IBOutlet weak var title: UILabel!
    
    func chooseMethodOfPayment(targe:AnyObject, action:Selector) {
        let tap = UITapGestureRecognizer(target: targe, action: action)
        self.addGestureRecognizer(tap)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
