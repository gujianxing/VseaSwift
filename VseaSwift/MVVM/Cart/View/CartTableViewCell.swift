//
//  CartTableViewCell.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/16.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var parametersLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var goodsCount: UILabel!
    
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var reduceImage: UIImageView!
    @IBOutlet weak var addImage: UIImageView!
    
    
    func setValuesWithModel(model:CartGoodsModel) {
        self.picture.sd_setImageWithURL(NSURL(string: model.goods_thumb), placeholderImage: nil)
        self.nameLabel.text = model.goods_name
        self.parametersLabel.text = model.goods_attr
        self.priceLabel.text = model.goods_price
        self.goodsCount.text = model.goods_number
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
