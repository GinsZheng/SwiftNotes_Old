//
//  CSTimerPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/2.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSTimerPage: UIViewController {

    var counter = 0.0
    
    let timerLabel = UILabel()

    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTimer()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.backgroundColor = .white
        
        timerLabel.setup(superview: view)
        timerLabel.setStyle24pt222MedCenter()
        timerLabel.setFrame(left: 20, top: 20, right: 20, height: 100)
    }

    func setupTimer() {
        CSTimer.share.scheduledDispatchTimer(withName: "myTimer", timeInterval: 1, queue: .main, repeats: true) {
            // 每一时间间隔(此处为每1秒)执行一次闭包内的代码，直至销毁
            self.counter += 1
            self.timerLabel.text = String(self.counter)
            print(self.counter)
            
            // 停止计时
            if self.counter >= 10 {
                CSTimer.share.destoryTimer(withName: "myTimer")
            }
        }
    }
}

