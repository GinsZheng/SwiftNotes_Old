//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

//import UIKit
//
//class TestVC: UIViewController {
//
//    let label = UILabel()
//
//    let imgView = UIImageView()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        label.set(superview: view, text: "Test")
//        label.setStyle24pt222Med()
//        label.setFrame(left: 20, top: 0)
//
//        imgView.set(superview: view, imageName: "iPhoneX")
//        imgView.setFrame(left: 0, top: 40, width: 200, height: 300)
//
//
//    }
//
//}
//


import UIKit
 
class TestVC: UIViewController {

    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

//        let imgView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 20))
//        self.view.addSubview(imgView)
        
        
//        label.setFrame(left: 20, top: 10)
//        self.push(toTarget: CSLineChartPage())
//
        let x = [1,2,3,4,4,5,5,5,5,55,]
        let result = getPartsOfArray(x, startIndex: 3, endIndex: 7)
        print(result)
        
        for i in 0...0 {
            print("i \(i)")
        }
    }
}


//var mainPoints: [(String, Int)] = []
//for i in allDatePoints.count - selectedDays - 1...allDatePoints.count - 1 {
//    let xValueInterval = selectedDays / 6
//
//    if i % xValueInterval == 0 {
//        let x = CSFormatter.getDateStrMD(timeStamp: allDatePoints[i].0)
//        axisPoints.append((x, 1))
//    } else {
//        let x = ""
//        axisPoints.append((x, 1))
//    }
//    mainPoints.append(("", allDatePoints[i].1))
//}
