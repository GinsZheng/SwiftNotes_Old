//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    let itemTable = CSItemTable()
    let progressTable = CSProgressTable()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        print(getDurationStrHHMMSS(secounds: 1000))
    }

}

