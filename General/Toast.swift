//
//  CSToast.swift
//  CSToastSwiftExample
//
//  Created by xiaohui on 16/8/12.
//  Copyright © 2016年 CoderZhuXH. All rights reserved.


import UIKit

/**
 *  Toast到顶端/底端默认距离
 */
private let toastSpace:CGFloat = 100.0
/**
 *  Toast背景颜色
 */
private let ToastBackgroundColor = UIColor.hex(c000_75)

//在window上显示
extension CSToast {
    //MARK:-中间显示
    
    /**
     中间显示
     
     - parameter text: 文字
     */
    public static func showCenterWithText(_ text:String) {
        let toast = CSToast(text: text)
        toast.showIn(UIWindow.window())
    }
    
    
    // MARK:-上方显示
    
    /**
     上方显示
     
     - parameter text: 文字
     */
    public static func showTopWithText(_ text:String) {
        let toast = CSToast(text: text)
        toast.showIn(UIWindow.window(), topOffset: toastSpace)
    }
    
    
    // MARK:-下方显示
    
    /**
     下方显示
     
     - parameter text: 文字
     */
    public static func showBottomWithText(_ text:String) {
        let toast: CSToast = CSToast(text: text)
        toast.showIn(UIWindow.window(), bottomOffset: toastSpace)
    }
    
}

//在view上显示
extension UIView {
    // MARK:- 中间显示
    
    /// 中间显示
    ///
    /// - Parameter text: 文字
    public func showCSToastCenterWithText(_ text:String){
        
        let toast: CSToast = CSToast(text: text)
        toast.showIn(self)
        
    }
    
    
    // MARK:-上方显示
    
    /// 上方显示
    ///
    /// - Parameter text: 文字
    public func showCSToastTopWithText(_ text:String){
        
        let toast: CSToast = CSToast(text: text)
        toast.showIn(self, topOffset: toastSpace)
    }
    
    
    //MARK:-下方显示
    
    /// 下方显示
    ///
    /// - Parameter text: 文字
    public func showCSToastBottomWithText(_ text:String){
        let toast: CSToast = CSToast(text: text)
        toast.showIn(self, bottomOffset: toastSpace)
    }
    
}

extension UIWindow {
    fileprivate class func window() -> UIWindow {
        let window = UIApplication.shared.windows[0]
        if(!window.isHidden){
            return window;
        }
        return (UIApplication.shared.delegate?.window!)!
        
    }
}

open class CSToast:NSObject {
    
    var contentView: UIView
    var duration: CGFloat
    
    init(text: String) {
        
        contentView = UIView()
        
        let textLabel = UILabel()
        textLabel.set(superview: contentView, text: text)
        textLabel.setLineHeight()
        textLabel.setFontStyle(size: 16, color: cFFF, alignment: .center)
        textLabel.numberOfLines = 2
        textLabel.size = CGSize(width: textLabel.getLabelWidth(withMaxWidth: 196), height: textLabel.getTextHeight(withWidth: 196))
        print(textLabel.getTextHeight(withWidth: 196))
        
        contentView.setFrame(left: 0, top: 0, width: textLabel.width + 40, height: textLabel.height + 26)
        contentView.backgroundColor = .hex(c000_75)
        contentView.setCornerRadius(radius: 8)
        
        textLabel.centerX = contentView.centerX
        textLabel.centerY = contentView.centerY - 2
        
        if textLabel.getTextHeight(withWidth: 196) > 30 {
            duration = 3.3
        } else {
            duration = 1.8
        }
        
        super.init()
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func dismissToast() {
        contentView.removeFromSuperview()
    }
    
    
    fileprivate func showAnimation() {
        
        UIView.animate(withDuration: 0.15, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            self.contentView.alpha = 1.0
            
        }) { (completion) in
            
        }
    }
    
    fileprivate func hideAnimation() {
        
        UIView.animate(withDuration: 0.15, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            
            self.contentView.alpha = 0.0
            
        }) { (completion) in
            
        }
        
    }
    
    fileprivate func showIn(_ view: UIView) {
        
        contentView.center = view.center
        view.addSubview(contentView)
        self.showAnimation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(UInt64(duration) * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            
            self.hideAnimation()
            
        }
    }
    
    fileprivate func showIn(_ view: UIView, topOffset top: CGFloat) {
        
        contentView.center = CGPoint(x: view.center.x, y: top+contentView.frame.size.height/2)
        view.addSubview(contentView)
        self.showAnimation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(UInt64(duration) * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            
            self.hideAnimation()
        }
    }
    
    fileprivate func showIn(_ view: UIView, bottomOffset bottom: CGFloat) {
        
        contentView.center = CGPoint(x: view.center.x, y: view.frame.size.height-(bottom+contentView.frame.size.height/2))
        view.addSubview(contentView)
        self.showAnimation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(UInt64(duration) * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            
            self.hideAnimation()
        }
    }
    
}

