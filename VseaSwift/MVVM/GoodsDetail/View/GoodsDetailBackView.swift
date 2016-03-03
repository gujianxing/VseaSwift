//
//  GoodsDetailBackView.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/2.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class GoodsDetailBackView: UIScrollView,UITableViewDelegate, UITableViewDataSource {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.creatDetailView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatDetailView() {
        let detailView = UITableView(frame: CGRectMake(0, 0, WIDTH, HEIGHT), style: .Plain)
        self.addSubview(detailView)
        detailView.dataSource = self
        detailView.delegate = self
        detailView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        detailView.registerNib(UINib(nibName: "GoodsDetailNameCell", bundle: nil), forCellReuseIdentifier: "name")
        detailView.registerNib(UINib(nibName: "GoodsDetailParameterCell", bundle: nil), forCellReuseIdentifier: "parameter")
        detailView.registerNib(UINib(nibName: "GoodsDetailFooterCell", bundle: nil), forCellReuseIdentifier: "footer")
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 3
        }else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("name") as! GoodsDetailNameCell
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("parameter") as! GoodsDetailParameterCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("footer") as! GoodsDetailFooterCell
            return cell
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 218;
        }else if (indexPath.section == 1) {
            return 32;
        }else {
            return 65 + 69;
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
