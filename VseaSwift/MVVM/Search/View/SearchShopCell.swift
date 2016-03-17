//
//  SearchShopCell.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/15.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class SearchShopCell: UICollectionViewCell {

    @IBOutlet weak var logoPicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func setValuesWithModel(model:searchShopModel) {
        self.logoPicture.sd_setImageWithURL(NSURL(string: model.company_logo), placeholderImage: nil)
        self.nameLabel.text = model.shopname
        self.countLabel.text = String(model.attention)
        self.backgroundColor = UIColor.whiteColor()

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
