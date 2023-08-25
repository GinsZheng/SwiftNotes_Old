//
//  CollectionViewCell.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/8/25.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

// MARK: - 创建一个 EgCollectionViewCell，方便复用

class EgCollectionViewCell: UICollectionViewCell {
    
    let eachLineCount: CGFloat = 3
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.set(superview: self, cornerRadius: 0)
        imageView.setFrame(left: 0, top: 0, width: ceil(kScreenWidth/eachLineCount), height: 500)
        
        titleLabel.set(superview: self)
        titleLabel.setStyle17ptFFFMedCent()
        titleLabel.setFrame(left: 0, centerY: imageView.centerY, width: ceil(kScreenWidth/eachLineCount), height: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - 创建一个 EgCollectionViewLayout，用于设置布局

class EgCollectionViewLayout: UICollectionViewLayout {
    
    var itemCount = 0
    var eachLineCount = 0
    var itemWidth: CGFloat = 0
    var itemHeight: CGFloat = 0
    var contentHeight: CGFloat = 0
    
    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    // 初始化一些参数与布局
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        // MARK: - 输入以下参数
        eachLineCount = 3
        itemHeight = 500
        
        itemCount = collectionView.numberOfItems(inSection: 0)
        itemWidth = (collectionView.bounds.width) / CGFloat(eachLineCount)
        contentHeight = CGFloat(ceil(Double(itemCount) / Double(eachLineCount))) * itemHeight
        
        // 设置所有单元格的位置属性
        layoutAttributes.removeAll()
        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            if let attributes = layoutAttributesForItem(at: indexPath) {
                layoutAttributes.append(attributes)
            }
        }
    }
    
    // 设置内容区域总大小，是不可见区域
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.bounds.width ?? 0, height: contentHeight)
    }
    
    // 设为只有在可见区域内的单元格的布局属性会被返回，以减少不必要的计算和绘制，提高性能
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter { $0.frame.intersects(rect) }
    }
    
    // 设置单个单元格的位置属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return createEqualDivisionLayoutAttributes(indexPath: indexPath, eachLineCount: CGFloat(eachLineCount), itemWidth: itemWidth, itemHeight: itemHeight)
    }
    
    
}

