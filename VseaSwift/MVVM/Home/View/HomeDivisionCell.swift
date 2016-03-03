//
//  HomeDivisionCell.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/1.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

protocol divisionDelegate {
    func selectItem(tap:UITapGestureRecognizer)
}
class HomeDivisionCell: UITableViewCell {
    
    var delegate:divisionDelegate?
    
    @IBOutlet weak var topPicture: UIImageView!
    @IBOutlet weak var leftPicture: UIImageView!
    @IBOutlet weak var rightTopPicture: UIImageView!
    @IBOutlet weak var rightBottomPicture: UIImageView!
    
    
    override func setValuesWithIndexPath(indexPath:NSIndexPath,dicModelResult modelResult:NSMutableDictionary) {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        let arr = modelResult["specList"]
        if let value = arr {
            for image in self.subviews[0].subviews {
                let index = self.subviews[0].subviews.indexOf(image)
                let model = value[index!] as! HomeDivisionModel
                (image as! UIImageView).sd_setImageWithURL(NSURL(string: model.ad_code!), placeholderImage: nil)
                let tap = UITapGestureRecognizer(target: self, action: "tapAction:")
                image.addGestureRecognizer(tap)
                image.contentMode = UIViewContentMode.ScaleAspectFill
            }
        }else {
            
        }

    }
    
    func tapAction(sender:UITapGestureRecognizer) {
        self.delegate?.selectItem(sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
