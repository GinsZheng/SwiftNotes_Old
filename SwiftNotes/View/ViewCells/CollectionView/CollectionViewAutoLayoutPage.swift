//
//  CollectionViewAutoLayoutPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/8/22.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class CollectionViewAutoLayoutPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AutoLayoutCollectionViewLayoutDelegate, AutoLayoutCollectionViewCellDelegate {
    
    // 输出参数
    let titleOffset: CGFloat = 20
    let itemInterval: CGFloat = 6
    let itemHeight: CGFloat = 66
    
    var collectionView: UICollectionView!
    
    let dateSource = [
        ["title":"0 Swift","bgColor":cBlue_5393FF],
        ["title":"1 Xcode","bgColor":cPurple_BF62F8],
        ["title":"2 Java","bgColor":cMagenta_FC5AAE],
        ["title":"3 PHP","bgColor":cRed_FF635A],
        ["title":"4 JS","bgColor":cOrange_F9AD18],
        ["title":"5 Reac","bgColor":cGreen_25BE3C],
        ["title":"6 Ruby","bgColor":cBluishGreen_01C7BD],
        ["title":"7 HTML","bgColor":cBlue_5393FF],
        ["title":"8 C# ","bgColor":cPurple_BF62F8],
        ["title":"9 C++","bgColor":cPurple_BF62F8],
    ]
    
    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kWithoutNavBarHeight)
        let layout = AutoLayoutCollectionViewLayout(titleOffset: titleOffset, itemInterval: itemInterval, itemHeight: itemHeight)
        layout.delegate = self
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(AutoLayoutCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AutoLayoutCollectionViewCell.self))
        collectionView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        
    }
    
    
    // MARK: - CollectionView 代理方法
    
    // 设置数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateSource.count
    }
    
    // 设置点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.push(toTarget: CSGeneralSubpage())
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // 设置 cell 逻辑
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AutoLayoutCollectionViewCell.self), for: indexPath) as! AutoLayoutCollectionViewCell
        cell.delegate = self
        // 把UI逻辑放在自定义的 CollectionViewCell，把数据放在此
        let data = dateSource[indexPath.row]
        cell.setData(title: data["title"] ?? "", color: data["bgColor"] ?? "")
        
        return cell
    }
    
    
    // MARK: - AutoLayoutCollectionViewLayoutDelegate 代理方法
    
    func fetchTitleWidths() -> [CGFloat] {
        var titleWidths: [CGFloat] = []
        for i in 0..<dateSource.count {
            // ⚠️这里fontSize和weight要和下面的AutoLayoutCollectionViewCell中的保持一致
            let width = getLabelWidth(text: dateSource[i]["title"] ?? "", fontSize: 17, weight: .medium)
            titleWidths.append(width)
        }
        
        return titleWidths
    }
    
    
    // MARK: - AutoLayoutCollectionViewCellDelegate 代理方法
    func fetchTitleOffset() -> CGFloat {
        return titleOffset
    }
    
}



// MARK: - 自定义 Cell

class AutoLayoutCollectionViewCell: UICollectionViewCell {
    
    // 输出参数(用于代理传递信息)
    let fontsize: CGFloat = 17
    let weight: UIFont.Weight = .medium
    
    weak var delegate: AutoLayoutCollectionViewCellDelegate?
    
    var titleOffset: CGFloat {
        return delegate?.fetchTitleOffset() ?? 0
    }
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
        titleLabel.setFontStyle(size: fontsize, color: cFFF, weight: weight, alignment: .center)
        titleLabel.setFrame(left: 10, centerY: imageView.centerY, width: titleLabel.getLabelWidth(), height: 20)
    }
    
    func resetImageWidth() {
        imageView.width = titleLabel.getLabelWidth() + titleOffset
    }
    
}



// MARK: - 自定义Layout

class AutoLayoutCollectionViewLayout: UICollectionViewLayout {
    
    weak var delegate: AutoLayoutCollectionViewLayoutDelegate?
    
    var titleOffset: CGFloat = 0
    var itemInterval: CGFloat = 0
    var itemHeight: CGFloat = 0
    
    var contentHeight: CGFloat = 0 // 视图高度
    var itemCount = 0
    var titleWidths: [CGFloat] {
        return delegate?.fetchTitleWidths() ?? []
    }
    
    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    /// 初始化参数：
    /// - titleOffset：标题两边的偏移之和
    /// - itemInterval：两个单元格之前的间隔
    /// - itemHeight：单元格高度
    init(titleOffset: CGFloat, itemInterval: CGFloat, itemHeight: CGFloat) {
        super.init()
        
        self.titleOffset = titleOffset
        self.itemInterval = itemInterval
        self.itemHeight = itemHeight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        contentHeight = getAutoLayoutContentHeight(indexPath: indexPath, titleWidths: titleWidths, titleOffset: titleOffset, itemInterval: itemInterval, itemHeight: itemHeight, collectionViewWidth: collectionView?.bounds.width ?? 0)
        
        kCollectionViewContentHeight = contentHeight
        
        let attributes = createAutoLayoutAttributes(indexPath: indexPath, titleWidths: titleWidths, titleOffset: titleOffset, itemInterval: itemInterval, itemHeight: itemHeight, collectionViewWidth: collectionView?.bounds.width ?? 0)
        return attributes
    }
    
}



