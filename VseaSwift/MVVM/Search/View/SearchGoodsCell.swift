//
//  SearchGoodsCell.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/15.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class SearchGoodsCell: UICollectionViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func setValuesWithModel(model:searchGoodsModel) {
        self.picture.sd_setImageWithURL(NSURL(string: model.goods_thumb), placeholderImage: nil)
        self.titleLabel.text = model.name
        self.priceLabel.text = "¥" + model.discount
//        self.countLabel.text = String(model.dis)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
