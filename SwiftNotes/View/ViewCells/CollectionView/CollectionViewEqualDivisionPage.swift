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
    
    let dateSource = [
        ["title":"Swift","bgColor":cBlue_5393FF],
        ["title":"Xcode","bgColor":cPurple_BF62F8],
        ["title":"Java","bgColor":cMagenta_FC5AAE],
        ["title":"PHP","bgColor":cRed_FF635A],
        ["title":"JS","bgColor":cOrange_F9AD18],
        ["title":"React","bgColor":cGreen_25BE3C],
        ["title":"Ruby","bgColor":cBluishGreen_01C7BD],
        ["title":"HTML","bgColor":cBlue_5393FF],
        ["title":"C#","bgColor":cPurple_BF62F8],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x:0, y:0, width: kScreenWidth, height:kWithoutNavBarHeight)
        // 这里必须要在初始化时加上frame(不明原因)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: EgCollectionViewLayout())
        // forCellWithReuseIdentifier: 值宜设为Class EgCollectionViewCell 的名字，省事
        collectionView.register(EgCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: EgCollectionViewCell.self))
        collectionView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        
    }
    
    
    // MARK: - CollectionView 代理
    
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
        // 创建一个 EgCollectionViewCell 实例 (类似于tableViewCell)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EgCollectionViewCell.self), for: indexPath) as! EgCollectionViewCell
        // 把UI逻辑放在自定义的 EgCollectionViewCell，把数据放在此
        let data = dateSource[indexPath.row]
        cell.titleLabel.setText(text: data["title"] ?? "")
        cell.imageView.setImage(image: getImageWithColor(color: data["bgColor"] ?? ""))
        
        return cell
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
