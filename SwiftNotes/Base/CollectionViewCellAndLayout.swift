//
//  CollectionViewCell.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/12.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

// MARK: - 自定义 Cell

class GroupCollectionViewCell: UICollectionViewCell {
    
    let fontSize = CollectionViewGroupStyles.fontSize
    let weight = CollectionViewGroupStyles.weight
    let titleOffset = CollectionViewGroupStyles.titleOffset
    
    let scrollView = UIScrollView()
    let button = UIButton(type: .custom)
    
    // MARK: - func
    
    func setData(title: String) {
        setButton(title: title)
        resetWidth()
    }
    
    func setButton(title: String) {
        button.set(superview: contentView, target: target, action: #selector(pushToTest))
        button.setStyleSolid14pt666LightGrayRoundedButton(title: title)
        button.setFrame(left: 0, top: 10, width: 10, height: 28)
    }
    
    func resetWidth() {
        button.width = (button.titleLabel?.getLabelWidth() ?? 10) + titleOffset
    }
    
    
    // MARK: - @objc func
    @objc func pushToTest() {
        print("done")
    }
    
}



// MARK: - 自定义Layout

class GroupCollectionViewLayout: UICollectionViewLayout {
    
    let titleOffset = CollectionViewGroupStyles.titleOffset
    let itemInterval: CGFloat = CollectionViewGroupStyles.itemInterval
    let itemHeight: CGFloat = CollectionViewGroupStyles.itemHeight
    
    var onHeightUpdate: ((CGFloat) -> Void)?     // 获取高度的闭包
    var fetchTitleWidthsClosure: (() -> [CGFloat])? // 获取标题宽度的闭包
    var titleWidths: [CGFloat] {
        return fetchTitleWidthsClosure?() ?? []
    }
    var contentHeight: CGFloat = 0 // 视图高度
    var itemCount = 0
    
    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    // 初始化一些参数与布局
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        itemCount = collectionView.numberOfItems(inSection: 0)
        
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
        contentHeight = getAutoLayoutContentHeight(indexPath: indexPath, titleWidths: titleWidths, titleOffset: CollectionViewGroupStyles.titleOffset, itemInterval: CollectionViewGroupStyles.itemInterval, itemHeight: CollectionViewGroupStyles.itemHeight, collectionViewWidth: collectionView?.bounds.width ?? 0)
        
        if indexPath.row == itemCount - 1 { // 对于最后一个元素
            onHeightUpdate?(contentHeight) // 调用闭包：设置高度
        }
        
        let attributes = createAutoLayoutAttributes(indexPath: indexPath, titleWidths: titleWidths, titleOffset: CollectionViewGroupStyles.titleOffset, itemInterval: CollectionViewGroupStyles.itemInterval, itemHeight: CollectionViewGroupStyles.itemHeight, collectionViewWidth: collectionView?.bounds.width ?? 0)
        return attributes
    }
    
}


