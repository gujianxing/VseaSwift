//
//  SearchGoodsHeader.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/15.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class SearchGoodsHeader: UICollectionReusableView {

    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var line: UIView!
    
    @IBOutlet weak var lineCenter: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
