//
//  ShippingAddressTableViewCell.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/10.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class ShippingAddressTableViewCell: UITableViewCell {

    
    @IBOutlet weak var defaultView: UILabel!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    
    func setValuesWithModel(model:ShippingAddressModel) {
        nameLabel.text = model.consignee
        phoneNumber.text = model.mobile
        adressLabel.text = model.address_name + model.address
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
