//
//  CollectionViewAutoLayoutPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/8/22.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

// CollectionView的参数
struct CollectionViewAutoLayoutStyles {
    static let fontSize: CGFloat = 17
    static let weight: UIFont.Weight = .medium
    static let titleOffset: CGFloat = 20
    static let itemInterval: CGFloat = 6
    static let itemHeight: CGFloat = 66
}

class CollectionViewAutoLayoutPage: UIViewController {
    
    // collectionView数据的结构体
    struct Item {
        let title: String
        let bgColor: String
    }
    
    typealias Styles = CollectionViewAutoLayoutStyles
    
    var collectionViewContentHeight: CGFloat = 0 // (可选项)获取collectionView内容高度(用于布局)
    let dataSource: [Item] = [
        Item(title: "0 Swift", bgColor: cBlue_5393FF),
        Item(title: "1 Xcode", bgColor: cPurple_BF62F8),
        Item(title: "2 Java", bgColor: cMagenta_FC5AAE),
        Item(title: "3 PHP", bgColor: cRed_FF635A),
        Item(title: "4 JS", bgColor: cOrange_F9AD18),
        Item(title: "5 React", bgColor: cGreen_25BE3C),
        Item(title: "6 Ruby", bgColor: cBluishGreen_01C7BD),
        Item(title: "7 HTML", bgColor: cBlue_5393FF),
        Item(title: "8 C#", bgColor: cPurple_BF62F8),
        Item(title: "9 C++", bgColor: cPurple_BF62F8),
    ]
    
    var collectionView: UICollectionView!
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        // 创建collectionView用到的Layout
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
                let width = getLabelWidth(text: self.dataSource[i].title , fontSize: Styles.fontSize, weight: Styles.weight)
                titleWidths.append(width)
            }
            return titleWidths
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AutoLayoutCollectionViewCell.self, forCellWithReuseIdentifier: AutoLayoutCollectionViewCell.identifier)
        collectionView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        collectionView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
        
    }
    
}


// MARK: - 代理方法：UICollectionViewDelegate
extension CollectionViewAutoLayoutPage: UICollectionViewDelegate {
    // 设置点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.push(toTarget: CSGeneralSubpage())
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}


// MARK: - 代理方法：UICollectionViewDataSource
extension CollectionViewAutoLayoutPage: UICollectionViewDataSource {
    // 设置数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    // 设置 cell 逻辑
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AutoLayoutCollectionViewCell.identifier, for: indexPath) as? AutoLayoutCollectionViewCell else { return UICollectionViewCell() }
        
        // 把UI逻辑放在自定义的 CollectionViewCell，把数据放在此
        let item = dataSource[indexPath.row]
        cell.configure(with: item.title, color: item.bgColor)

        // (可选)如果用到了高度collectionViewContentHeight，要在这里调用(在前面还没有加载内容时还没有高度)
        return cell
    }
}



// MARK: - 自定义 Cell

class AutoLayoutCollectionViewCell: UICollectionViewCell {
    
    typealias Styles = CollectionViewAutoLayoutStyles
    
    static let identifier = String(describing: AutoLayoutCollectionViewCell.self)
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - func
    private func setupViews() {
        imageView.set(superview: contentView, cornerRadius: 10)
        imageView.setFrame(left: 0, top: 0, width: 0, height: 60)
        
        titleLabel.set(superview: imageView)
        titleLabel.setFontStyle(size: Styles.fontSize, color: cFFF, weight: Styles.weight, alignment: .center)
    }
    
    func configure(with title: String, color: String) {
        titleLabel.text = title
        titleLabel.setFrame(left: 10, centerY: imageView.centerY, width: titleLabel.getLabelWidth(), height: 20)
        
        imageView.image = getImageWithColor(color: color)
        imageView.width = titleLabel.getLabelWidth() + Styles.titleOffset
    }
    
    
}



// MARK: - 自定义Layout
class AutoLayoutCollectionViewLayout: UICollectionViewLayout {
    
    typealias Styles = CollectionViewAutoLayoutStyles
    
    var onHeightUpdate: ((CGFloat) -> Void)?     // 获取collectionView高度的闭包
    var fetchTitleWidthsClosure: (() -> [CGFloat])? // 获取标题宽度的闭包
    var titleWidths: [CGFloat] {
        return fetchTitleWidthsClosure?() ?? []
    }
    var contentHeight: CGFloat = 0 // 视图高度
    var itemCount = 0
    
    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    // MARK: - 初始化
    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }
        itemCount = collectionView.numberOfItems(inSection: 0)
        layoutAttributes.removeAll()
        
        // 设置所有单元格的位置属性
        var lastIndex = IndexPath(item: 0, section: 0)
        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            lastIndex = indexPath
            let attributes = createAutoLayoutAttributes(indexPath: indexPath, titleWidths: titleWidths, titleOffset: Styles.titleOffset, itemInterval: Styles.itemInterval, itemHeight: Styles.itemHeight, collectionViewWidth: collectionView.width)
            layoutAttributes.append(attributes)
        }

        // 更新内容高度
        contentHeight = getAutoLayoutContentHeight(indexPath: lastIndex, titleWidths: titleWidths, titleOffset: Styles.titleOffset, itemInterval: Styles.itemInterval, itemHeight: Styles.itemHeight, collectionViewWidth: collectionView.width)
        onHeightUpdate?(contentHeight)
    }

    // (维持不变)设置内容区域总大小，是不可见区域
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.width ?? 0, height: contentHeight)
    }

    // (维持不变)设为只有在可见区域内的单元格的布局属性会被返回，以减少不必要的计算和绘制，提高性能
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter { $0.frame.intersects(rect) }
    }

    // (维持不变)设置单个单元格的位置属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return indexPath.item < layoutAttributes.count ? layoutAttributes[indexPath.item] : nil
    }
}
