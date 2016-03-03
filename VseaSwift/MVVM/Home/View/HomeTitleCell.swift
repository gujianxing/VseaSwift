//
//  HomeTitleCell.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/1.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class HomeTitleCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setValuesWithIndexPath(indexPath:NSIndexPath,dicModelResult modelResult:NSMutableDictionary) {
        self.selectionStyle = UITableViewCellSelectionStyle.None
 
        if indexPath.section == 2 {
            let brandTitle = modelResult["brandTitle"]
            if let value = brandTitle {
                let title = value as! String
                self.title.text = title
            }else {
                
            }
        }else if indexPath.section == 3 {
            let actTitle = modelResult["actTitle"]
            if let value = actTitle {
                let title = value as! String
                self.title.text = title
            }else {
                
            }
        }else {
            self.title.text = "商品上新"
        }
        
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
