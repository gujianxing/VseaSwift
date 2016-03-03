//
//  HomeGoodsDetailCell.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/1.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class HomeGoodsDetailCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var titlehead: UILabel!
    @IBOutlet weak var titlefoot: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var shopPrice: UILabel!
    @IBOutlet weak var line: UIView!
    
    
    override func setValuesWithIndexPath(indexPath: NSIndexPath, arrModelResult: NSMutableArray) {
        if indexPath.row % 5 == 1 {
            self.line.backgroundColor = JX_HexToRGB().hexFloatColor("f8bb27")
            self.storeName.textColor = JX_HexToRGB().hexFloatColor("f8bb27")
        }else if indexPath.row % 5 == 2 {
            self.line.backgroundColor = JX_HexToRGB().hexFloatColor("f97923")
            self.storeName.textColor = JX_HexToRGB().hexFloatColor("f97923")
        }else if indexPath.row % 5 == 3 {
            self.line.backgroundColor = JX_HexToRGB().hexFloatColor("7ad082")
            self.storeName.textColor = JX_HexToRGB().hexFloatColor("7ad082")
        }else if indexPath.row % 5 == 4 {
            self.line.backgroundColor = JX_HexToRGB().hexFloatColor("07b9e0")
            self.storeName.textColor = JX_HexToRGB().hexFloatColor("07b9e0")
        }else if indexPath.row % 5 == 0 {
            self.line.backgroundColor = JX_HexToRGB().hexFloatColor("f9ba2a")
            self.storeName.textColor = JX_HexToRGB().hexFloatColor("f9ba2a")
        }
        
        if arrModelResult.count > indexPath.row - 1 {
            let model = arrModelResult[indexPath.row - 1] as! HomeGoodsDetailModel
            self.picture.sd_setImageWithURL(NSURL(string: model.goods_thumb!), placeholderImage: nil)
            self.picture.contentMode = UIViewContentMode.ScaleAspectFill
            self.storeName.text = model.shopname
            self.titlehead.text = model.goods_name
            self.titlefoot.text = model.goods_name
            self.subtitle.text = model.goods_brief
            self.price.text = model.shop_price
            self.shopPrice.text = model.market_price
        }
        
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
