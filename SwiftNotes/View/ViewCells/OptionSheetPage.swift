//
//  OptionSheetPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/17.
//  Copyright © 2024 GinsMac. All rights reserved.
//

import UIKit

private class OptionDataManager: DefaultSectionDataManager {
    init() {
        super.init(initialItems: [
            DefaultSection(
                cells: [
                    .titleNextVC(title: "标题1", viewController: ButtonPage()),
                    .titleNextVC(title: "标题2", viewController: AnimationPage()),
                ]
            ),
            DefaultSection(
                cells: [
                    .titleNextVC(title: "标题3", viewController: CSGeneralSubpage()),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    
                ]
            ),
        ])
    }
}


class OptionSheetPage: UIViewController {
    private let optionData = OptionDataManager()
    
    private let bgView = UIView()
    private let button = UIButton(type: .custom)
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


// MARK: - 私有方法
extension OptionSheetPage {
    private func setupUI() {
        view.setBackgroundColor(color: cBgGray)

        bgView.setup(superview: view, backgroundColor: cFgWhite)
        bgView.setFrame(left: 30, top: 300, right: 30, height: 200)

        button.setup(superview: bgView, target: self, action: #selector(handleAction))
        button.setStyleSolid17ptFgWhiteThemeButton(title: "点击出现小选项表")
        button.setFrame(left: 10, top: 30, right: 10, height: kButtonHeight)
        
    }
    
}


// MARK: - @objc方法
extension OptionSheetPage {
    @objc func handleAction() {
        let optionSheet = OptionSheet(optionData: self.optionData, senderFrameInWindow: self.button.getFrameInWindow())
        optionSheet.onTap = { [weak self] indexPath in
            guard let self = self else { return }
            let item = self.optionData.cellData(for: indexPath)
            item.pushViewControllerOnTap(from: self)
        }
        self.present(targetVC: optionSheet)
    }

}
