//
//  CollectionViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/12/9.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CollectionViewPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView!
    
    //课程名称和图片，每一门课程用字典来表示
    let dateSource = [
        ["name":"Swift","pic":cBlue_2C9EFF],
        ["name":"Xcode","pic":cPurple_BF62F8],
        ["name":"Java","pic":cMagenta_FC5AAE],
        ["name":"PHP","pic":cRed_FF635A],
        ["name":"JS","pic":cOrange_F9AD18],
        ["name":"React","pic":cGreen_25BE3C],
        ["name":"Ruby","pic":cBluishGreen_01C7BD],
        ["name":"HTML","pic":cBlue_2C9EFF],
        ["name":"C#","pic":cPurple_BF62F8]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 设置UI
        setupUI()
    }

    /// 设置UI
    func setupUI() {
        let layout = CollectionViewLayout()
        let frame = CGRect(x:0, y:0, width: kScreenWidth, height:kWithoutNavBarHeight)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .hex(cF0F1F3)
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let data = dateSource[indexPath.row]
        cell.imageView.image = getImageWithColor(color: data["pic"] ?? "");
        cell.titleLabel.text = data["name"] ?? ""
        return cell
    }
}


class CollectionViewCell: UICollectionViewCell {
    var titleLabel: UILabel!
    var imageView: UIImageView!
    var line: UIView!
    
    let countEachLine: CGFloat = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView.set(superview: self)
        imageView.frame = CGRect(x: 0, y: 0, width: ceil(kScreenWidth/countEachLine), height: ceil(kScreenWidth/countEachLine))
        imageView.contentMode = .scaleAspectFit
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: ceil(kScreenWidth/countEachLine), height: 20))
        titleLabel.set(superview: self)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .hex(cFFF)
        titleLabel.backgroundColor = .hex(c000_20)
        
        line = UIView()
        line.set(superview: self)
        line.backgroundColor = .hex(cFFF)
        line.setFrame(right: 0, top: 40, width: kSeparatorHeight, height: 40)
        
        // 有时可以不需要
        self.layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CollectionViewLayout: UICollectionViewLayout {

    let countEachLine: CGFloat = 3
    
    // 内容区域总大小，不是可见区域
    override var collectionViewContentSize: CGSize {
        // 宽度就是屏幕宽度
        let width = collectionView!.width
        // 一行三个，一个大的两个小的，得到总高度
        let height = kWithoutNavBarHeight
        return CGSize(width: width, height: height)
    }
    
    // 所有单元格位置属性
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 创建属性数组
        var attributesArray = [UICollectionViewLayoutAttributes]()
        // 获取单元格个数
        let itemCount = self.collectionView!.numberOfItems(inSection: 0)
        // 循环创建单元格的属性
        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            let layoutAttributes = self.layoutAttributesForItem(at: indexPath)
            attributesArray.append(layoutAttributes!)
        }
        return attributesArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        // 获取当前的布局属性
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        let itemWidth = kScreenWidth / countEachLine
        
        let lineNumber = CGFloat(indexPath.item / Int(countEachLine))
        let lineY = lineNumber*itemWidth
        
        attribute.frame = CGRect(x: kScreenWidth/countEachLine*CGFloat((indexPath.item % Int(countEachLine))), y: lineY, width: kScreenWidth/countEachLine, height: kScreenWidth/countEachLine)
        
        return attribute
        
    }
    
}

