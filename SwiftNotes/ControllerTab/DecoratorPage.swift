//
//  Decorator.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/7/31.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class DecoratorPage: UIViewController {
    
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

