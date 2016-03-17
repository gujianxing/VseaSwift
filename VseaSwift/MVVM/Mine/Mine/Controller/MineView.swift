//
//  MineView.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/16.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit
protocol MineViewDelegate {
    func pushMineDetailVC()
    func pushFundsManagerVC()
    func pushShippingAddressVC()
}
class MineView: UIView {

    var delegate:MineViewDelegate?
    
    @IBOutlet weak var headPicture: UIImageView!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var depositsLabel: UILabel!
    
    
    @IBAction func pushMineDetail(sender: UITapGestureRecognizer) {
        self.delegate?.pushMineDetailVC()
    }
    @IBAction func pushFundsManager(sender: UITapGestureRecognizer) {
        self.delegate?.pushFundsManagerVC()
    }
    @IBAction func pushShippingAddress(sender: UITapGestureRecognizer) {
        self.delegate?.pushShippingAddressVC()
    }
    
    
//    @IBOutlet weak var headPicture: UIImageView!
//    @IBOutlet weak var phoneNumber: UILabel!
//    @IBOutlet weak var depositsLabel: UILabel!

    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
