//
//  LineChartPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/18.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import SwiftCharts

class CSLineChartPage: UIViewController {

    fileprivate var chart: Chart? // arc

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let bgView = UIView()
        bgView.set(superview: view, backgroundColor: cFFF)
        bgView.setBorder(color: c000_5, borderWidth: 0.5)
        bgView.setShadow(y: 2, radius: 10)
        bgView.setFrame(left: 20, top: 20, width: kScreenWidth - 40, height: 214)
        bgView.setCornerRadius(radius: 8)
        
        // 单独画y=0的虚线
        let xAxisLine = UIImageView()
        xAxisLine.set(superview: bgView)
        xAxisLine.setFrame(left: 32, top: 175, width: bgView.width - 30 - 12, height: 0.5)
        xAxisLine.setDashedLine(color: cF0F1F3, dash: 4, gap: 4)
        

        let labelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 10), fontColor: .hex(c000_22))
        let labelYSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 10), fontColor: .hex(c999))
        
//        let points = [(1, 0), (2, 24), (3, 31), (4, 50), (5, 82), (6, 82), (7, 100)]
        
        let points = [("10/21", 0), ("10/22", 24), ("10/23", 31), ("10/24", 50), ("10/25", 82), ("10/26", 82), ("10/27", 100)]
        
        let chartPoints: [ChartPoint] = points.enumerated().map {ChartPoint(x: ChartAxisValueInt($0 + 1, labelSettings: labelSettings), y: ChartAxisValueInt($1.1))}
        let xValues = points.enumerated().map { (index, tuples) in
            ChartAxisValueString(tuples.0, order: index+1, labelSettings: labelSettings)
        }
        let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 5, maxSegmentCount: 5, multiple: 20, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelYSettings)}, addPaddingSegmentIfEdge: false)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: .hex(cBlue_5393FF), lineWidth: 2, lineJoin: .round, lineCap: .butt, animDuration: 0, animDelay: 0)
        
        let xModel = ChartAxisModel(axisValues: xValues, lineColor: .hex(cNoColor), axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, lineColor: .hex(cNoColor), axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings.defaultVertical()))
        
        let chartFrame = CGRect(x: 0, y: 0, width: kScreenWidth - 40, height: 214)
        
        // 图表设置
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom

        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)

        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel])
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: .hex(cF0F1F3), linesWidth: 0.5, dotWidth: 4, dotSpacing: 4)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, axis: .y, settings: settings)
        
        
        // circles layer
        let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 6)
            circleView.animDuration = 0.5
            circleView.fillColor = .hex(cBlue_5393FF)
            return circleView
        }
        let lineCirclesLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: circleViewGenerator, displayDelay: 0, delayBetweenItems: 0, mode: .translate, clipViews: false)
        
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLineLayer,
                lineCirclesLayer,
            ]
        )
        
        bgView.addSubview(chart.view)
        self.chart = chart
        
    }
}
