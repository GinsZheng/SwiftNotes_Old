//
//  SQLInstance.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import SQLite

class SQLInstance: UIViewController {
    
    let db = SQLiteManager().getDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
    }
}

