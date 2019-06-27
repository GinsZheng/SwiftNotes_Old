//
//  ImageViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ImageViewPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let image = UIImageView()
        view.addSubview(image)
        image.makeConstraintsToLeftTopRight(left: 20, top: 100, right: -20, height: 300)
        image.image = UIImage(named: "iPhoneX")
        
        image.addBorder(color: orange, borderWidth: 1)
        image.contentMode = .scaleAspectFill
        
    }
    
    
}

