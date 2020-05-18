//
//  LineChartPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/18.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import SwiftCharts
//
//class CSLineChartPage: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//
//        let chartConfig = ChartConfigXY(
//            xAxisConfig: ChartAxisConfig(from: 2, to: 14, by: 2),
//            yAxisConfig: ChartAxisConfig(from: 0, to: 14, by: 2)
//        )
//
//        let frame = CGRect(x: 0, y: 70, width: 300, height: 500)
//
//        let chart = LineChart(
//            frame: frame,
//            chartConfig: chartConfig,
//            xTitle: "X axis",
//            yTitle: "Y axis",
//            lines: [
//                (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.red),
//                (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blue)
//            ]
//        )
//
//
//
//        self.view.addSubview(chart.view)
//    }
//
//
//}



class CSLineChartPage: UIViewController {

    fileprivate var chart: Chart? // arc

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let labelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 10), fontColor: .hex(cCCC))
        
        let chartPoints: [ChartPoint] = [(1, 3), (2, 4), (4, 1), (5, 6), (6, 4), (7, 9), (8, 0), (10, 4), (12, 2)].map{ChartPoint(x: ChartAxisValueInt($0.0, labelSettings: labelSettings), y: ChartAxisValueInt($0.1))}
        
        
        let axisPoints: [ChartPoint] = [(1, 20), (2, 40), (3, 60), (4, 80), (5, 100)].map{ChartPoint(x: ChartAxisValueInt($0.0, labelSettings: labelSettings), y: ChartAxisValueInt($0.1))}
        
        let xValues = axisPoints.map{$0.x}
        let yValues = axisPoints.map{$0.y}
//        let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 5, maxSegmentCount: 5, multiple: 20, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: .hex(cBlue_2C9EFF), animDuration: 1, animDelay: 0)
        
        let notificationViewWidth: CGFloat = Env.iPad ? 30 : 20
        let notificationViewHeight: CGFloat = Env.iPad ? 30 : 20
        
        let notificationGenerator = {[weak self] (chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let (chartPoint, screenLoc) = (chartPointModel.chartPoint, chartPointModel.screenLoc)
            
            if chartPoint.y.scalar <= 1 {

                let chartPointView = HandlingView(frame: CGRect(x: screenLoc.x + 5, y: screenLoc.y - notificationViewHeight - 5, width: notificationViewWidth, height: notificationViewHeight))
                let label = UILabel(frame: chartPointView.bounds)
                label.layer.cornerRadius = Env.iPad ? 15 : 10
                label.clipsToBounds = true
                label.backgroundColor = UIColor.red
                label.textColor = UIColor.white
                label.textAlignment = NSTextAlignment.center
                label.font = UIFont.boldSystemFont(ofSize: Env.iPad ? 22 : 18)
                label.text = "!"
                chartPointView.addSubview(label)
                label.transform = CGAffineTransform(scaleX: 0, y: 0)
                
                chartPointView.movedToSuperViewHandler = {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIView.AnimationOptions(), animations: {
                        label.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }, completion: nil)
                }
                
                chartPointView.touchHandler = {
                    
                    let title = "Lorem"
                    let message = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua."
                    let ok = "Ok"
                    
                        if #available(iOS 8.0, *) {
                            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: ok, style: UIAlertAction.Style.default, handler: nil))
                            self!.present(alert, animated: true, completion: nil)

                        } else {
                            let alert = UIAlertView()
                            alert.title = title
                            alert.message = message
                            alert.addButton(withTitle: ok)
                            alert.show()
                        }
                }
                
                return chartPointView
            }
            return nil
        }
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings))
        
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings.defaultVertical()))
        let chartFrame = ExamplesDefaults.chartFrame(CGRect(x: 0, y: 0, width: kScreenWidth, height: 500))
        
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom

        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)

        let chartPointsNotificationsLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: notificationGenerator, displayDelay: 1, mode: .custom)
        // To preserve the offset of the notification views from the chart point they represent, during transforms, we need to pass mode: .custom along with this custom transformer.
        chartPointsNotificationsLayer.customTransformer = {(model, view, layer) -> Void in
            let screenLoc = layer.modelLocToScreenLoc(x: model.chartPoint.x.scalar, y: model.chartPoint.y.scalar)
            view.frame.origin = CGPoint(x: screenLoc.x + 5, y: screenLoc.y - notificationViewHeight - 5)
        }
        
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel])
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLineLayer,
                chartPointsNotificationsLayer]
        )
        
        view.addSubview(chart.view)
        self.chart = chart
    }
}
