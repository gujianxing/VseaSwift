//
//  SearchRecordCell.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/17.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class SearchRecordCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func setTitleWithString(title:String) {
        self.titleLabel.text = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
