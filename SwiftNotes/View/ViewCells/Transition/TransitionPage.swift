//
//  TransitionPage.swift
//  HeroTest
//
//  Created by FDM on 2019/10/17.
//  Copyright © 2019 发抖喵. All rights reserved.
//

import UIKit
import Hero
import SnapKit

// 转场1 神奇移动 FromView
class Transition1FromVC: UIViewController {
    
    let grayView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        grayView.set(superview: view, backgroundColor: cCCC)
        grayView.setCornerRadius(radius: 15)
        grayView.setFrame(left: 40, top: 180, width: kScreenWidth - 80, height: 56)
        
        blueView.set(superview: view, backgroundColor: cF0F1F3)
        blueView.setCornerRadius(radius: 10)
        blueView.setFrame(left: 90, top: 270, width: kScreenWidth - 180, height: 260)
        
        // 1. 设置UIView的id，要与第二个页面相同的UIView的id名相同
        grayView.hero.id = "grayView"
        blueView.hero.id = "blueView"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 2. 设置跳转
        let toVC = Transition1ToVC()
        toVC.hero.isEnabled = true
        self.presentFullScreen(toTarget: toVC)
    }
}

// 转场1 神奇移动 toView
class Transition1ToVC: UIViewController {
    
    let grayView = UIView()
    let blueView = UIView()
    let whiteView = UIView() // 新增UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 设置终态的View
        blueView.set(superview: view, backgroundColor: cF0F1F3)
        blueView.setCornerRadius(radius: 0) // 这句可以省略，只需给出始态与终态
        blueView.setFrame(allEdges: 0)
        
        grayView.set(superview: view, backgroundColor: cOrange_F7AD18)
        grayView.setCornerRadius(radius: 15)
        grayView.setFrame(centerX: view.centerX, top: 100, width: 100, height: 100)
        
        // 新增的UIView也为终态
        whiteView.set(superview: view, backgroundColor: cBlue_2C9EFF_40)
        whiteView.setCornerRadius(radius: 15)
        whiteView.setFrame(centerX: view.centerX, top: 400, width: 300, height: 400)
        
        // 3. 设置id，与FromVC对应
        grayView.hero.id = "grayView"
        blueView.hero.id = "blueView"
        
        // 设置新增的whiteView的始态，只需在数组中加入有差异的部分：
        // translate(y:500) - 设置view是从y = 500的位置向y = 300的位置移动，
        // useGlobalCoordinateSpace设置为独立的View(不设置的话效果差)
        whiteView.hero.modifiers = [.translate(y:500), .useGlobalCoordinateSpace]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 4. 设置反向动画
        self.dismiss(animated: true, completion: nil)
    }
}



// 转场3 渐隐渐现
class Transition2FromVC: UIViewController {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        button.set(superview: view, target: self, action: #selector(goNext))
        button.setStyleSolidBtn(title: "反复横跳")
        button.setCornerRadius(radius: 50)
        button.setFrame(left: 50, top: 200, width: 100, height: 100)
        
        button.hero.id = "button"
    }
    
    @objc func goNext() {
        let vc = Transition2ToVC()
        vc.hero.isEnabled = true
        self.presentFullScreen(toTarget: vc)
    }
}

class Transition2ToVC: UIViewController {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        button.set(superview: view, target: self, action: #selector(goBack))
        button.setStyleSolidBtn(title: "反复横跳")
        button.setCornerRadius(radius: 50)
        button.setFrame(right: 50, top: 288, width: 100, height: 100)
        
        button.hero.id = "button"
        
    }
    
    @objc func goBack() {
        self.unpresent()
    }
    
    
}



// 转场3 fromView
// 所有的注释部分是与第一个页面的对比与提示
class ViewController_2A: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let grayView = UIView()
        grayView.frame = CGRect(x: 50, y: 120, width: 50, height: 50)
        grayView.layer.cornerRadius = 25
        grayView.backgroundColor = .lightGray
        self.view.addSubview(grayView)
        
        grayView.hero.id = "grayView"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let toVC = ViewController_2B()
        toVC.hero.isEnabled = true
        toVC.modalPresentationStyle = .fullScreen
        self.present(toVC, animated: true, completion: nil)
    }
}

// 转场2 toView
class ViewController_2B: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let grayView = UIView()
        grayView.frame = CGRect(x: 70, y: 180, width: 300, height: 50)
        grayView.layer.cornerRadius = 15
        grayView.backgroundColor = .lightGray
        self.view.addSubview(grayView)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: CGRect(x: 90, y: 270, width: 260, height: 300), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        /*-------------主要--------------*/
        grayView.hero.id = "grayView"
        collectionView.hero.modifiers = [.cascade]      //层叠应用增加子视图的延迟修饰符(添加子视图动画时会有延迟加载)
        /*------------------------------*/
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .hex(cF0F1F3)
        
        /*-------------主要--------------*/
        cell.hero.modifiers = [.fade,.scale(0.5)]   //在添加cell时为其添加动画[.fade(淡入淡出的效果),.scale(0.5)放大倍数为0.5]
        /*------------------------------*/
        
        return cell
    }
}
