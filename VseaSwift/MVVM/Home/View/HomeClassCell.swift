//
//  HomeClassCell.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/1.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class HomeClassCell: UICollectionViewCell {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    
    func setValuesWithClassModel(model:HomeClassModel) {
        self.picture.sd_setImageWithURL(NSURL(string: model.imgUrl!), placeholderImage: nil)
        self.picture.contentMode = UIViewContentMode.ScaleAspectFill
        self.title.text = model.name
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    

}
