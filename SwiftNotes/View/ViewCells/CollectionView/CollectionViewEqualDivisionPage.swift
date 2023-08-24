//
//  CollectionViewEqualDivisionPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/8/22.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class CollectionViewEqualDivisionPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView!
    
    //课程名称和图片，每一门课程用字典来表示
    let dateSource = [
        ["name":"Swift","bgColor":cBlue_5393FF],
        ["name":"Xcode","bgColor":cPurple_BF62F8],
        ["name":"Java","bgColor":cMagenta_FC5AAE],
        ["name":"PHP","bgColor":cRed_FF635A],
        ["name":"JS","bgColor":cOrange_F9AD18],
        ["name":"React","bgColor":cGreen_25BE3C],
        ["name":"Ruby","bgColor":cBluishGreen_01C7BD],
        ["name":"HTML","bgColor":cBlue_5393FF],
        ["name":"C#","bgColor":cPurple_BF62F8],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加collectionView
        let layout = CollectionViewLayout()
        let frame = CGRect(x:0, y:0, width: kScreenWidth, height:kWithoutNavBarHeight)
        // 这里必需要在初始化时加上frame
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.set(superview: view)
        // forCellWithReuseIdentifier: 值宜设为Class CollectionViewCell 的名字
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .hex(cBgGray)
        
    }

    
    // MARK: - CollectionView 代理
    
    // 设置列表数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateSource.count
    }

    // 设置 cell UI与逻辑
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 创建一个 CollectionViewCell 实例 (类似于tableViewCell)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        // 把UI逻辑放在自定义的 CollectionViewCell，把数据放在此
        let data = dateSource[indexPath.row]
        cell.imageView.image = getImageWithColor(color: data["bgColor"] ?? "");
        cell.titleLabel.text = data["name"] ?? ""
        return cell
    }
}


// MARK: - 创建一个 CollectionViewCell，方便复用(tableView其实也应如此)

class CollectionViewCell: UICollectionViewCell {
    
    let countEachLine: CGFloat = 3
    
    let titleLabel = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.set(superview: self)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.setFrame(left: 0, top: 0, width: ceil(kScreenWidth/countEachLine), height: 60)
        
        titleLabel.set(superview: self)
        titleLabel.setStyle17ptFFFMedCent()
        titleLabel.setFrame(left: 0, centerY: imageView.centerY, width: ceil(kScreenWidth/countEachLine), height: 20)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 创建一个 CollectionViewLayout，用于设置布局

class CollectionViewLayout: UICollectionViewLayout {
    
    // 内容区域总大小，不是可见区域
    override var collectionViewContentSize: CGSize {
        let width = collectionView!.width
        let height = kWithoutNavBarHeight
        return CGSize(width: width, height: height)
    }
    
    // 设置所有单元格位置属性
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 创建属性数组，即每一个单元格的UI属性
        var attributes = [UICollectionViewLayoutAttributes]()
        // 获取单元格个数
        let itemCount = self.collectionView!.numberOfItems(inSection: 0)
        // 循环创建单元格的属性
        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            // 调用属性设置
            let layoutAttributes = self.layoutAttributesForItem(at: indexPath)
            attributes.append(layoutAttributes!)
        }
        return attributes
    }
    
    // 设置单个单元格的位置属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        // ❓此处可抽象成通用内容，以下布局为等分式布局，应当来说，只要修改逻辑就能实现不等分布局
        
        // 获取当前的布局属性
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        // MARK: - 如果是等分：
        
        // 设置一行几个
        let countEachLine: CGFloat = 3

        // 设置每个单元格宽高
        let itemWidth: CGFloat = kScreenWidth / countEachLine
        let itemHeight: CGFloat = 60
        
        // 从代码逻辑根据indexPath去设置每个单元格的Frame:
        // 设置每个单元格的x值(= 单元格宽度 * 每行第几个)
        let x = itemWidth * CGFloat(indexPath.item % Int(countEachLine))
        // 设置每个单元格所处行数 (值为 0、1、2…)，用于设置y值
        let lineNumber = CGFloat(indexPath.item / Int(countEachLine))
        // 设置每个单元格的y值(= 单元格高度 * 行数)
        let y = itemHeight * lineNumber
        
        // 设置frame
        attribute.frame = CGRect(x: x, y: y, width: itemWidth, height: itemHeight)
        
        return attribute
        
    }
    
}
