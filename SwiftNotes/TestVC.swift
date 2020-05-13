//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import Hero
 
class TestVC: UIViewController, UITextFieldDelegate {

    
    let textField2 = UITextField()
    
    let imgView = UIImageView()
    
    let userDefault = UserDefaults.standard.integer(forKey: "startTime")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        userDefault.set(1584855000, forKey: "startTime")
//        userDefault.set(12345, forKey: "Int")
//        var intValue = userDefault.integer(forKey: "startTime")
//        print(intValue)
        
        UserDefaults.standard.set(1234, forKey: "startTime")
        let intValue = UserDefaults.standard.integer(forKey: "startTime")
        print(intValue)
        
        
        
//        textField2.set(superview: view, placeholder: "请输入", delegate: self)
//        textField2.setStyleOneLineTextField()
//        textField2.setFrame(left: 20, top: 100, right: 20, height: 56)
//        textField2.keyboardType = .numberPad
        
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        textField2.resignFirstResponder()
//        textField2.text = textField2.text?.trimmingCharacters(in: .whitespaces)
//    }
    


    

}



//
//protocol CustomAlertViewDelegate: NSObjectProtocol {
//    func okButtonTapped()
//    func cancelButtonTapped()
//}
//
//
//
//class CustomAlertView: UIViewController {
//
//    public var startTime = 0
//
//    var delegate: CustomAlertViewDelegate?
//
//    let maskView = UIView()
//    let bgView = UIView()
//    let titleLabel = UILabel()
//    let startTimeLabel = UILabel()
//    let addingButton = UIButton()
//    let cancelButton = UIButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        let startTimeText = "开始时间：\(CSFormatter.getDateAndTimeStrDefault(timeStamp: startTime))"
//
//        maskView.set(superview: UIApplication.shared.windows[0], backgroundColor: c04040F_40_mask)
//        maskView.setFrame(allEdges: 0)
//
//        bgView.set(superview: maskView, backgroundColor: cFFF)
//        bgView.setCornerRadius(radius: 8)
//        bgView.setFrame(center: maskView, width: 270, height: 184)
//
//        titleLabel.set(superview: bgView, text: "添加上次学习进度")
//        titleLabel.setStyle20pt222MedCenter()
//        titleLabel.setFrame(centerX: bgView.centerX, top: 20)
//
//        startTimeLabel.set(superview: bgView, text: startTimeText)
//        startTimeLabel.setStyle14pt666Center()
//        startTimeLabel.setFrame(centerX: titleLabel.centerX, top: titleLabel.bottom + 8)
//
//        addingButton.set(superview: bgView, target: self, action: #selector(addProgress))
//        addingButton.setStyleAddItemBarBtn(title: "添加")
//        addingButton.setFrame(left: 20, top: startTimeLabel.bottom + 16, right: 20, height: 48)
//
//        cancelButton.set(superview: bgView, target: self, action: #selector(cancel))
//
//    }
//
//
//    @objc func addProgress() {
////        let toVC = CSGeneralSubpage()
//        if delegate != nil {
//            delegate!.okButtonTapped()
//        }
//        self.dismiss()
//    }
//
//    @objc func cancel() {
//        if delegate != nil {
//            delegate!.cancelButtonTapped()
//        }
//        self.dismiss()
//    }
//
//
//}
//
//
