//
//  HomeClassView.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/1.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit

class HomeClassView: UICollectionView {
    
    
    
    
    func creatClassView(datasource:UICollectionViewDataSource, delegate:UICollectionViewDelegate,nibName:[String] ,ids:[String])->UICollectionView {
        
        self.scrollEnabled = false
        self.dataSource = datasource
        self.delegate = delegate
        self.backgroundColor = UIColor.whiteColor()
        for id in ids {
            let n:Int = ids.indexOf(id)!
            self.registerNib(UINib(nibName: nibName[n], bundle: nil), forCellWithReuseIdentifier: id)
        }
        
        return self
    }
    

    
    
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }

}
