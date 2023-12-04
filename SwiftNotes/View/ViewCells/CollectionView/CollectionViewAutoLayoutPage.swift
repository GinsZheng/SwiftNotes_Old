//
//  CollectionViewAutoLayoutPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/8/22.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

// 输入CollectionView的参数
struct CollectionViewAutoLayoutStyles {
    static let fontSize: CGFloat = 17
    static let weight: UIFont.Weight = .medium
    static let titleOffset: CGFloat = 20
    static let itemInterval: CGFloat = 6
    static let itemHeight: CGFloat = 66
}

class CollectionViewAutoLayoutPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let fontSize = CollectionViewAutoLayoutStyles.fontSize
    let weight = CollectionViewAutoLayoutStyles.weight
    
    var collectionViewContentHeight: CGFloat = 0 // (可选项)获取collectionView内容高度(用于布局)
    let dataSource: [(title: String, bgColor: String)] = [
        (title: "0 Swift", bgColor: cBlue_5393FF),
        (title: "1 Xcode", bgColor: cPurple_BF62F8),
        (title: "2 Java", bgColor: cMagenta_FC5AAE),
        (title: "3 PHP", bgColor: cRed_FF635A),
        (title: "4 JS", bgColor: cOrange_F9AD18),
        (title: "5 React", bgColor: cGreen_25BE3C),
        (title: "6 Ruby", bgColor: cBluishGreen_01C7BD),
        (title: "7 HTML", bgColor: cBlue_5393FF),
        (title: "8 C#", bgColor: cPurple_BF62F8),
        (title: "9 C++", bgColor: cPurple_BF62F8),
    ]
    
    var collectionView: UICollectionView!

    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        let layout = AutoLayoutCollectionViewLayout()
        // 设置闭包：更新collectionView内容高度
        layout.onHeightUpdate = { [weak self] newHeight in
            self?.collectionViewContentHeight = newHeight
        }
        // 设置闭包：计算标题宽度
        layout.fetchTitleWidthsClosure = { [weak self] in
            guard let self = self else { return [] }
            var titleWidths: [CGFloat] = []
            for i in 0..<self.dataSource.count {
                let width = getLabelWidth(text: self.dataSource[i].title , fontSize: fontSize, weight: weight)
                titleWidths.append(width)
            }
            return titleWidths
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AutoLayoutCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AutoLayoutCollectionViewCell.self))
        collectionView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        collectionView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
        
    }
    
    
    // MARK: - CollectionView 代理方法
    
    // 设置数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    // 设置点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.push(toTarget: CSGeneralSubpage())
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // 设置 cell 逻辑
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AutoLayoutCollectionViewCell.self), for: indexPath) as? AutoLayoutCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // 把UI逻辑放在自定义的 CollectionViewCell，把数据放在此
        let data = dataSource[indexPath.row]
        cell.setData(title: data.title, color: data.bgColor)
        
        print("ContentHeight", collectionViewContentHeight) // (可选)如果用到了高度，要在这里调用(在前面还没有加载内容时还没有高度)
        return cell
    }
    
}



// MARK: - 自定义 Cell

class AutoLayoutCollectionViewCell: UICollectionViewCell {
    
    let fontSize = CollectionViewAutoLayoutStyles.fontSize
    let weight = CollectionViewAutoLayoutStyles.weight
    let titleOffset = CollectionViewAutoLayoutStyles.titleOffset
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    
    
    // MARK: - func
    
    func setData(title: String, color: String) {
        setImageView(color: color)
        setTitle(text: title)
        resetImageWidth()
    }
    
    func setImageView(color: String) {
        imageView.set(superview: contentView, image: getImageWithColor(color: color), cornerRadius: 10)
        imageView.setFrame(left: 0, top: 0, width: 0, height: 60)
    }
    
    func setTitle(text: String) {
        titleLabel.set(superview: imageView, text: text)
        titleLabel.setFontStyle(size: fontSize, color: cFFF, weight: weight, alignment: .center)
        titleLabel.setFrame(left: 10, centerY: imageView.centerY, width: titleLabel.getLabelWidth(), height: 20)
    }
    
    func resetImageWidth() {
        imageView.width = titleLabel.getLabelWidth() + titleOffset
    }
    
}



// MARK: - 自定义Layout

class AutoLayoutCollectionViewLayout: UICollectionViewLayout {
    
    let titleOffset = CollectionViewAutoLayoutStyles.titleOffset
    let itemInterval: CGFloat = CollectionViewAutoLayoutStyles.itemInterval
    let itemHeight: CGFloat = CollectionViewAutoLayoutStyles.itemHeight
    
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
        contentHeight = getAutoLayoutContentHeight(indexPath: indexPath, titleWidths: titleWidths, titleOffset: CollectionViewAutoLayoutStyles.titleOffset, itemInterval: CollectionViewAutoLayoutStyles.itemInterval, itemHeight: CollectionViewAutoLayoutStyles.itemHeight, collectionViewWidth: collectionView?.bounds.width ?? 0)
        
        if indexPath.row == itemCount - 1 { // 对于最后一个元素
            onHeightUpdate?(contentHeight) // 调用闭包：设置高度
        }
        
        let attributes = createAutoLayoutAttributes(indexPath: indexPath, titleWidths: titleWidths, titleOffset: CollectionViewAutoLayoutStyles.titleOffset, itemInterval: CollectionViewAutoLayoutStyles.itemInterval, itemHeight: CollectionViewAutoLayoutStyles.itemHeight, collectionViewWidth: collectionView?.bounds.width ?? 0)
        return attributes
    }
    
}


