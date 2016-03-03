//
//  HomeMainView.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/2.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class HomeMainView: UITableView {

    
    
    func creatMainView(datasource:UITableViewDataSource, delegate:UITableViewDelegate, nibName:[String], ids:[String],modelResult:NSDictionary)->UITableView {
        self.dataSource = datasource
        self.delegate = delegate
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        for id in ids {
            let n:Int = ids.indexOf(id)!
            self.registerNib(UINib(nibName: nibName[n], bundle: nil), forCellReuseIdentifier: id)
        }
        
        let headerView = UIImageView(frame: CGRectMake(0, 0, WIDTH, 164 * WIDTH / 375))  //headerview高度
        let arr = modelResult["adsList"] as! NSArray
        if arr.count > 0 {
            let model = arr[0] as! HomeDivisionModel
            headerView.sd_setImageWithURL(NSURL(string: model.ad_code!), placeholderImage: nil)
            self.tableHeaderView = headerView
        }
        
        return self
    }
    
    func returnNunmberOfRows(section:Int)->Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 1
        }else if section == 2 || section == 3 {
            return 5
        }else {
            return 10   //默认加载10个，上啦加载更多
        }
    }
    
    func returnCellForIndexPath(index:NSIndexPath, identifiers:[NSArray])->AnyObject {
        var identifier = String()

        if index.row > 1 {
             identifier = identifiers[index.section][1] as! String
        }else {
             identifier = identifiers[index.section][index.row] as! String
        }
        
        if index.section == 0 {
            let cell:HomeClassTabCell = self.dequeueReusableCellWithIdentifier(identifier) as! HomeClassTabCell
            return cell
        }else if index.section == 1 {
            let cell:HomeDivisionCell = self.dequeueReusableCellWithIdentifier(identifier) as! HomeDivisionCell
            return cell
        }else if index.section == 2 || index.section == 3 {
            if index.row == 0 {
                let cell:HomeTitleCell = self.dequeueReusableCellWithIdentifier(identifier) as! HomeTitleCell
                return cell
            }else {
                let cell:HomeAdvertisementCell = self.dequeueReusableCellWithIdentifier(identifier) as! HomeAdvertisementCell
                return cell
            }
        }else {
            if index.row == 0 {
                let cell:HomeTitleCell = self.dequeueReusableCellWithIdentifier(identifier) as! HomeTitleCell
                return cell
            }else {
                let cell:HomeGoodsDetailCell = self.dequeueReusableCellWithIdentifier(identifier) as! HomeGoodsDetailCell
                return cell
            }
        }
        
    }
    
    func returnHeightForRow(indexPath:NSIndexPath)->CGFloat {
        if (indexPath.section == 0) {
            return 170
        }else if indexPath.section == 1 {
            return 418  * WIDTH / 375;
        }else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                return 33 * WIDTH / 375;
            }else {
                return 140 * WIDTH / 375;
            }
        }else if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                return 42 * WIDTH / 375;
            }else {
                return 140 * WIDTH / 375;
            }
        }else if (indexPath.section == 4) {
            if (indexPath.row == 0) {
                return 42 * WIDTH / 375;
            }else {
                return 133;  //
            }
        }else {
            return 170 * WIDTH / 375;
        }
    }
    
    

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }


}
