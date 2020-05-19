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
        bgView.setShadow(y: 2, radius: 10)
        bgView.setFrame(left: 20, top: 20, width: kScreenWidth - 40, height: 214)
        bgView.setCornerRadius(radius: 8)
        

        let labelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 10), fontColor: .hex(cCCC))
        let labelYSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 10), fontColor: .hex(c999))
        
        let chartPoints: [ChartPoint] = [(1, 0), (2, 24), (3, 31), (4, 80), (5, 100)].map{ChartPoint(x: ChartAxisValueInt($0.0, labelSettings: labelSettings), y: ChartAxisValueInt($0.1))}
        
        
        let axisPoints: [ChartPoint] = [(1, 20), (2, 40), (3, 60), (4, 80), (5, 100)].map{ChartPoint(x: ChartAxisValueInt($0.0, labelSettings: labelSettings), y: ChartAxisValueInt($0.1))}
        
        let xValues = axisPoints.map{$0.x}
        let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 5, maxSegmentCount: 5, multiple: 20, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelYSettings)}, addPaddingSegmentIfEdge: false)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: .hex(cBlue_2C9EFF), lineWidth: 2, lineCap: .butt, animDuration: 0, animDelay: 0)
        
        let xModel = ChartAxisModel(axisValues: xValues, lineColor: .hex(cNoColor), axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings))
        
        let yModel = ChartAxisModel(axisValues: yValues, lineColor: .hex(cNoColor), axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings.defaultVertical()))
        let chartFrame = CGRect(x: 0, y: 0, width: kScreenWidth - 40, height: 214)
        
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom

        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)

        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel])
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: .hex(cF0F1F3), linesWidth: 0.5, dotWidth: 4, dotSpacing: 4)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, axis: .y, settings: settings)
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLineLayer
            ]
        )
        
        bgView.addSubview(chart.view)
//        chart.view.backgroundColor = .hex(c000_10)
        self.chart = chart
        
        
        // 单独画y=0的虚线
        let xAxisLine = UIImageView()
        xAxisLine.set(superview: bgView)
        xAxisLine.setFrame(left: 32, top: 175, width: bgView.width - 30 - 12, height: 0.5)
        xAxisLine.setDashedLine(color: cF0F1F3, dash: 4, gap: 4)
        
    }
}
