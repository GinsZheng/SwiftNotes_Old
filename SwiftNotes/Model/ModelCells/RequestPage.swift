//
//  CSRequestPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/13.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class CSRequestPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var slidesTitle = [String]()
    var slidesType = [String]()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let url = "https://httpbin.org/json"
        AF.request(url).responseJSON { (response) in
            if let value = response.result.value {
                let jsonData3 = JSON(value)
                let model3 = CSSwiftyModel3(jsonData: jsonData3)
                self.slidesTitle = model3.slidesTitle
                self.slidesType = model3.slidesType
                print("CSSwiftyModel3 slidesTitle \(model3.slidesTitle)")
                
                self.tableView.set(superview: self.view, delegate: self, dataSource: self)
                self.tableView.setFrame(left: 0, top: 0, right: 0, height: self.getSafeAreaHeight())
                self.tableView.contentSize = CGSize(width: kScreenWidth, height: kCellHeight * CGFloat(self.slidesTitle.count))
            }
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(leftInset: 20, rightInset: 0)
        cell.selectionStyle = .none // 无按下效果
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: slidesTitle[indexPath.row])
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.set(superview: cell, imageName: "discovery_next")
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slidesTitle.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: CSGeneralSubpage())
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
