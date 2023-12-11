//
//  CollectionViewEqualDivisionPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/8/22.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

// collectionView数据的结构体
private struct Item {
    let title: String
    let bgColor: String
}

private class DataManager: BaseDataManager<Item> {
    init() {
        super.init(initialItems: [
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
        ])
    }
}

// 输入参数
struct CollectionViewEqualDivisionStyles {
    static let eachLineCount: CGFloat = 3
    static let itemHeight: CGFloat = 400
}

class CollectionViewEqualDivisionPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    
    private let dataSource = DataManager()
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        let layout = EqualDivisionCollectionViewLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(EqualDivisionCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: EqualDivisionCollectionViewCell.self))
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EqualDivisionCollectionViewCell.self), for: indexPath) as? EqualDivisionCollectionViewCell else {
            return UICollectionViewCell()
        }
        // 把UI逻辑放在自定义的 EqualDivisionCollectionViewCell，把数据放在此
        let data = dataSource[indexPath.row]
        cell.titleLabel.setText(text: data.title)
        cell.imageView.setImage(image: getImageWithColor(color: data.bgColor))
        
        return cell
    }
    

}



// MARK: - 创建一个 EqualDivisionCollectionViewCell，方便复用

class EqualDivisionCollectionViewCell: UICollectionViewCell {
    
    let eachLineCount = CollectionViewEqualDivisionStyles.eachLineCount
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - func
    
    func setupUI() {
        imageView.set(superview: self, cornerRadius: 0)
        imageView.setFrame(left: 0, top: 0, width: ceil(kScreenWidth/eachLineCount), height: 500)
        
        titleLabel.set(superview: self)
        titleLabel.setStyle17ptFFFMedCent()
        titleLabel.setFrame(left: 0, centerY: imageView.centerY, width: ceil(kScreenWidth/eachLineCount), height: 20)
    }
}



// MARK: - 创建一个 EqualDivisionCollectionViewLayout，用于设置布局

class EqualDivisionCollectionViewLayout: UICollectionViewLayout {
    
    var eachLineCount = CollectionViewEqualDivisionStyles.eachLineCount
    var itemHeight = CollectionViewEqualDivisionStyles.itemHeight
    
    var itemCount = 0
    var itemWidth: CGFloat = 0
    var contentHeight: CGFloat = 0
    
    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    // 初始化一些参数与布局
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        itemCount = collectionView.numberOfItems(inSection: 0)
        itemWidth = (collectionView.bounds.width) / eachLineCount
        contentHeight = CGFloat(ceil(Double(itemCount) / eachLineCount)) * itemHeight
        
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
        return createEqualDivisionLayoutAttributes(indexPath: indexPath, eachLineCount: eachLineCount, itemWidth: itemWidth, itemHeight: itemHeight)
    }
    
    
}



// MARK: - 笔记
/*
 override func prepare()
 prepare()在布局准备阶段被调用，用于进行一些初始化工作, 如：
 1. 计算并存储每个单元格的布局属性，以便后续的方法可以使用这些属性。
 2. 计算并设置 collectionViewContentSize 属性，表示整个内容的大小，这会影响滚动范围。
 想比init() ，某些内容在init中还未生成，比如想获取列表数量： collectionView!.numberOfItems(inSection: 0)，因collectionView未生成，所以会崩溃，而在prepare中collectionView就已生成，能正常运行
 */
