//
//  NumberFormatterPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/8/3.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class NumberFormatterPage: UIViewController {
    
    let floatFormat = UILabel()
    let stringFormat = UILabel()
    let intFormat = UILabel()
    let multicpleFormat = UILabel()
    
    let str = "Gins"
    let float = 3.1415926
    let int = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
// ———————— String(format)格式化
        
        floatFormat.set(superview: view)
        floatFormat.makeConstraints(left: 20, top: 100, width: 300, height: 44)
        floatFormat.text = String(format: "%.2f", float)
        // %：指其后跟随的参数数值。多个 % 对应多个参数，与Python一样。
        // f：指浮点数的格式化，.2f 指保留2位小数
        // %.2f： %与f要组合在一起才是格式化
        // pi：参数，可有多个，参数是数值型

        stringFormat.set(superview: view)
        stringFormat.makeConstraints(left: 20, top: 140, width: 300, height: 44)
        stringFormat.text = String(format: "%@ Zheng", str)
        // @：指字符串的格式化
        
        intFormat.set(superview: view)
        intFormat.makeConstraints(left: 20, top: 180, width: 300, height: 44)
        intFormat.text = String(format: "%02d 个", int)
        print(String(format: "%5d 个", int))
        // d：指整数的格式化
        // %02d：指数果int不足2位，那以0在前面补位-> “06 个”
        // %5d：指如果整数int不足5位，那以空格在前面补位 -> “    6 个”
        
        multicpleFormat.set(superview: view)
        multicpleFormat.makeConstraints(left: 20, top: 220, width: 300, height: 44)
        multicpleFormat.text = String(format: "%.2f, %@'s reciting", float, str)
        // 多个参数逗号隔开
        
        
        
// ———————— NumberFormatter简单格式化
        
        //原始数字（需要先转成NSNumber类型）
        let number = NSNumber(value: 1234.5678)
        
        //四舍五入的整数
        let none = NumberFormatter.localizedString(from: number, number: .none)
        //小数形式（以国际化格式输出 保留三位小数,第四位小数四舍五入）
        let decimal = NumberFormatter.localizedString(from: number, number: .decimal)
        //百分数形式
        let percent = NumberFormatter.localizedString(from: number, number: .percent)
        //科学计数
        let scientific = NumberFormatter.localizedString(from: number, number: .scientific)
        //朗读形式（英文表示）
        let spellOut = NumberFormatter.localizedString(from: number, number: .spellOut)
        //序数形式
        let ordinal = NumberFormatter.localizedString(from: number, number: .ordinal)
        //货币形式（以货币通用格式输出 保留2位小数,第三位小数四舍五入,在前面添加货币符号）
        let currency = NumberFormatter.localizedString(from: number, number: .currency)
        //货币形式
        let currencyISOCode = NumberFormatter.localizedString(from: number,
                                                              number: .currencyISOCode)
        //货币形式
        let currencyPlural = NumberFormatter.localizedString(from: number,
                                                             number: .currencyPlural)
        //会计计数
        let currencyAccounting = NumberFormatter.localizedString(from: number,
                                                                 number: .currencyAccounting)
        
        //打印结果
        print("原始值 = \(number)")
        print("none = \(none)")
        print("decimal = \(decimal)")
        print("percent = \(percent)")
        print("scientific = \(scientific)")
        print("spellOut = \(spellOut)")
        print("ordinal = \(ordinal)")
        print("currency = \(currency)")
        print("currencyISOCode = \(currencyISOCode)")
        print("currencyPlural = \(currencyPlural)")
        print("currencyAccounting = \(currencyAccounting)")
        
        
    }
        
// ———————— NumberFormatter复杂格式化
    func formatNumber(value: String) -> String {
        
        let numberFormatter = NumberFormatter()
        let valueOfDouble = (value as NSString).doubleValue // 把String转换为Double
        
        
        
        if (valueOfDouble >= -pow(10, -100) && valueOfDouble <= pow(10, -100)) || (valueOfDouble <= -pow(10, 100) || valueOfDouble >= pow(10, 100)) {
            numberFormatter.numberStyle = .scientific
            numberFormatter.maximumSignificantDigits = 5
        } else {
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 8
        }
        
        let formatValue = numberFormatter.string(from: NSNumber(value: valueOfDouble))!.lowercased()
        
        return formatValue
    }
    
}
