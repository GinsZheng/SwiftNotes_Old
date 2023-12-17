//
//  CustomPopupWindow.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/5.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSCustomPopupWindowPage: UIViewController {
    
    let btn = UIButton()
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.backgroundColor = .white
        
        btn.setup(superview: view, target: self, action: #selector(popup))
        btn.setStyleSolid17ptFgWhiteThemeButton(title: "添加")
        btn.setFrame(left: 20, top: 100, right: 20, height: 48)
    }
    
    
    // MARK: - @objc func

    @objc func popup() {
        // 把前一VC的截图作为底图，并设置过场动画
        let toVC = CSCustomPopupWindow()
        toVC.bgImage = getImageOfScreenshot(uiView: UIApplication.shared.windows[0])
        toVC.hero.isEnabled = true
        toVC.modalPresentationStyle = .fullScreen
        self.present(toTarget: toVC)
    }
}



class CSCustomPopupWindow: UIViewController {
    // 用于接收传来的背景截图
    public var bgImage = UIImage()
    
    let bgImageView = UIImageView()
    let maskView = UIView()
    let bgView = UIView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let addingButton = UIButton()
    let cancelButton = UIButton()

    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.backgroundColor = .white
        
        bgImageView.setup(superview: view, image: bgImage)
        bgImageView.setFrame(left: 0, top: 0, width: bgImage.size.width, height: bgImage.size.height)
        
        maskView.setup(superview: view, backgroundColor: c000309_40_mask)
        maskView.setFrame(allEdges: 0)

        bgView.setup(superview: maskView, backgroundColor: cFFF)
        bgView.setCornerRadius(radius: kRadius)
        bgView.setFrame(center: maskView, width: 270, height: 184)

        titleLabel.setup(superview: bgView, text: "添加上次")
        titleLabel.setStyle20pt222MedCenter()
        titleLabel.setFrame(centerX: bgView.centerX - bgView.x, top: 20)

        messageLabel.setup(superview: bgView, text: "说明内容")
        messageLabel.setStyle14pt666Center()
        messageLabel.setFrame(centerX: titleLabel.centerX, top: titleLabel.bottom + 8)
        
        addingButton.setup(superview: bgView, target: self, action: #selector(confirm))
        addingButton.setStyleSolid17ptFgWhiteThemeButton(title: "添加")
        addingButton.setFrame(left: 20, top: messageLabel.bottom + 16, right: 20, height: 48)
        
        cancelButton.setup(superview: bgView, target: self, action: #selector(cancel))
        cancelButton.setStyleWord14pt999Button(title: "放弃")
        cancelButton.setFrame(centerX: bgView.centerX - bgView.x, top: addingButton.bottom + 12, width: 44, height: 20)
        cancelButton.extendTouchArea()
        
        //动画
        maskView.hero.modifiers = [.opacity(0), .duration(0.15), .delay(0), .useGlobalCoordinateSpace]
    }
    
    
    // MARK: - @objc func

    @objc func confirm() {
        self.dismiss()
        self.presentingViewController?.present(toTarget: CSGeneralSubpage())
    }
    
    @objc func cancel() {
        self.dismiss()
    }
    
    
    
}
