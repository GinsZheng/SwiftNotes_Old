//
//  BarChartPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/18.
//  Copyright © 2020 GinsMac. All rights reserved.
//
//
//import UIKit
//import SwiftCharts
//
//class CSBarChartPage: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        let chartConfig = BarsChartConfig(
//            valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
//        )
//
//        let frame = CGRect(x: 0, y: 70, width: 300, height: 500)
//                
//        let chart = BarsChart(
//            frame: frame,
//            chartConfig: chartConfig,
//            xTitle: "X axis",
//            yTitle: "Y axis",
//            bars: [
//                ("A", 2),
//                ("B", 4.5),
//                ("C", 3),
//                ("D", 5.4),
//                ("E", 6.8),
//                ("F", 0.5)
//            ],
//            color: UIColor.red,
//            barWidth: 20
//        )
//
//        self.view.addSubview(chart.view)
//    }
//    
//    
//}
//
