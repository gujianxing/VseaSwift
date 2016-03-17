//
//  HomeAdvertisementCell.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/1.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class HomeAdvertisementCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    
    
    override func setValuesWithIndexPath(indexPath:NSIndexPath,dicModelResult modelResult:NSMutableDictionary) {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        if indexPath.section == 2 {
            let arr = modelResult["brandList"]
            if let value = arr {
                if value.count > indexPath.row - 1 {
                    let model = (value as! NSArray)[indexPath.row - 1] as! HomeDivisionModel
                    self.picture.sd_setImageWithURL(NSURL(string: model.ad_code!), placeholderImage: nil)
                }
            }else {
                
            }
        }else {
            let arr = modelResult["actList"]
            if let value = arr {
                if value.count > indexPath.row - 1 {
                    let model = (value as! NSArray)[indexPath.row - 1] as! HomeDivisionModel
                    self.picture.sd_setImageWithURL(NSURL(string: model.ad_code!), placeholderImage: nil)
                }
            }else {
                
            }
        }
        
        self.picture.contentMode = UIViewContentMode.ScaleAspectFill
        
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
