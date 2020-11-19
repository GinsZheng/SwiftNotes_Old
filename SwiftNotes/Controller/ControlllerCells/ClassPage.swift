//
//  CSClassPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/30.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSClassPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        _ = getView(superview: view)
    }
    
    // 多态：可以返回目标类的子类
    func getView(superview: UIView) -> UIView {
        let img = UIImageView()
        img.set(superview: superview, imageName: "mine_face")
        img.setStyleImageView(cornerRadius: 8)
        img.setFrame(left: 20, top: 100, width: 100, height: 100)
        return img
    }

}


// 类的继承、类中类
class CSClassInheritance: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let myDish = PackageDishDecorator(dish: SaltDishDecorator(dish: Dish(name: "松鼠桂鱼", price: 15)))
        print(myDish.description)
    }
    
    
    class Dish {
        var name: String
        var price: Int
        
        init(name: String, price: Int) {
            self.name = name
            self.price = price
        }
        
        var description: String {
            get {
                return "\(name): \(price)元"
            }
        }
    }
    
    class SaltDishDecorator: Dish {
        
        init(dish: Dish) {
            super.init(name: "加盐 \(dish.name)", price: dish.price + 1)
        }
    }
    
    class PackageDishDecorator: Dish {
        
        init(dish: Dish) {
            super.init(name: "打包\(dish.name)", price: dish.price + 2)
        }
    }
}

