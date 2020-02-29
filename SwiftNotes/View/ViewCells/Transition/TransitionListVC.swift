//
//  TransitionPage.swift
//  HeroTest
//
//  Created by FDM on 2019/10/17.
//  Copyright © 2019 发抖喵. All rights reserved.

/**首页，不需要看*/

import UIKit
import Hero

class TransitionPage: UIViewController {
    
    let titleArray = [
        "简单实例1",
        "简单实例2",
        "简单实例3"
    ]
    
    let viewControllerArray = [
        Transition1FromVC(),
        Transition2FromVC(),
        ViewController_2A()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: kScreenWidth - 40, height: 56)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.set(superview: view)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

extension TransitionPage: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.setBackgroundColor(color: cFFF)
        cell.layer.cornerRadius = 10
        cell.setShadow(y: 2, radius: 12)
        
        let titleLabel = UILabel()
        titleLabel.set(superview: cell.contentView, text: titleArray[indexPath.item])
        titleLabel.setStyle17pt222()
        titleLabel.setFrame(left: 15, centerY: cell.contentView.centerY)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.viewControllerArray[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

