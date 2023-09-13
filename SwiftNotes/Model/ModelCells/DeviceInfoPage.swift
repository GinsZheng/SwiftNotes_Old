//
//  CSDeviceInfoPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2022/8/25.
//  Copyright © 2022 GinsMac. All rights reserved.
//

import UIKit

class CSDeviceInfoPage: UIViewController {
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // MARK: - 设备信息
        
        let deviceName = UIDevice.current.name // 设备名称，如Gins
        print("deviceName", deviceName)
        
        let modelName = UIDevice.modelName  // 获取设备型号(iPhone 11，iPhone 13 Pro Max)
        print("modelName", modelName)
        
        let systemVersion = UIDevice.current.systemVersion // 如 15.2
        print("systemVersion", systemVersion)
        
        let identifierForVendor = UIDevice.current.identifierForVendor // 虚拟id
        print("identifierForVendor", identifierForVendor ?? "uuid无法获取")
        
        let model = UIDevice.current.model // e.g. iPhone, iPad
        print("model", model)

        
        // MARK: - APP信息
//        let infoDictionary = Bundle.main.infoDictionary // 所有信息
//        print("infoDictionary", infoDictionary)
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""  // e.g. 1.1
        let bundleName = Bundle.main.infoDictionary?["CFBundleVersion"] ?? "" // e.g. 10

        print("appVersion", appVersion, "\n",
            "bundleName", bundleName, "\n"
        )
        
    }
    
    
}


