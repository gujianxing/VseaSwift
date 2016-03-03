//
//  HomeClassTabCell.swift
//  VseaSwift
//
//  Created by 谷建兴 on 16/3/2.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

import UIKit
//分类按钮
protocol categoryDelegate {
    func selectCategoryListItem(indexPath:NSIndexPath)
}

class HomeClassTabCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate {
    
    var delegate:categoryDelegate?
    
    lazy var classView:HomeClassView = {
        var view = HomeClassView()
        return view
    }()
    lazy var dataSource:NSMutableArray = {
        var source:NSMutableArray = NSMutableArray()
        return source
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.classView = HomeClassView(frame: CGRectMake(0, 0, WIDTH, 170), collectionViewLayout: UICollectionViewFlowLayout())
        self.addSubview(self.classView.creatClassView(self, delegate: self, nibName: ["HomeClassCell"], ids: ["cell"]))
    }
    
    
    //MARK:COLLECTIONView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:HomeClassCell = self.classView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! HomeClassCell
        let model = self.dataSource[indexPath.row] as! HomeClassModel
        cell.setValuesWithClassModel(model)
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(48, 48 + 9 + 14)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let edge = UIEdgeInsetsMake(15, 30, 0, 30)
        return edge
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return (WIDTH - 4 * 48 - 2 * 30) / 3
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.selectCategoryListItem(indexPath)
    }

    
    
    
    
    
    
    override func setValuesWithIndexPath(indexPath: NSIndexPath, dicModelResult modelResult: NSMutableDictionary) {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        let arr = modelResult["categoryList"]
        if let value = arr {
            self.dataSource = value as! NSMutableArray
            self.classView.reloadData()
        }else {
            
        }
    }
    
    
    
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
