import Foundation
import UIKit
extension UIColor {
    class func hex(_ color: String) -> UIColor{
        var cstr = color.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString

        if cstr.hasPrefix("0X") {
            cstr = cstr.substring(from: 2) as NSString
        }
        if cstr.hasPrefix("#") {
            cstr = cstr.substring(from: 1) as NSString
        }
        if cstr.length != 3 && cstr.length != 6 && cstr.length != 8{
            return UIColor.clear;
        }
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        var a: UInt32 = 0x0
        var range = NSRange.init()
        
        if cstr.length == 3 {
            range.length = 1
            //r
            range.location = 0
            let rStr1 = cstr.substring(with: range)
            //g
            range.location = 1
            let gStr1 = cstr.substring(with: range)
            //b
            range.location = 2
            let bStr1 = cstr.substring(with: range)
            Scanner.init(string: rStr1).scanHexInt32(&r)
            Scanner.init(string: gStr1).scanHexInt32(&g)
            Scanner.init(string: bStr1).scanHexInt32(&b)
            return UIColor(red: CGFloat(r * 16 + r) / 255.0, green: CGFloat(g * 16 + g) / 255.0, blue: CGFloat(b * 16 + b) / 255.0, alpha: CGFloat(1))
        } else if cstr.length == 6 {
            range.length = 2
            //r
            range.location = 0
            let rStr = cstr.substring(with: range)
            //g
            range.location = 2
            let gStr = cstr.substring(with: range)
            //b
            range.location = 4
            let bStr = cstr.substring(with: range)
            Scanner.init(string: rStr).scanHexInt32(&r)
            Scanner.init(string: gStr).scanHexInt32(&g)
            Scanner.init(string: bStr).scanHexInt32(&b)
            return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
        } else {
            range.length = 2
            //a
            range.location = 0
            let aStr = cstr.substring(with: range)
            //r
            range.location = 2
            let rStr = cstr.substring(with: range)
            //g
            range.location = 4
            let gStr = cstr.substring(with: range)
            //b
            range.location = 6
            let bStr = cstr.substring(with: range)

            Scanner.init(string: aStr).scanHexInt32(&a)
            Scanner.init(string: rStr).scanHexInt32(&r)
            Scanner.init(string: gStr).scanHexInt32(&g)
            Scanner.init(string: bStr).scanHexInt32(&b)
            return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
        }
        
        
    }
}
