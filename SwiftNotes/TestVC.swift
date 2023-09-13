import UIKit

class ViewController: UIViewController {
    
    
    
    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.setBackgroundColor(color: cFFF)

        let timestamp = 1672678923 // 用您的时间戳替换这个示例 (2023-01-3 01:02:03)

        // 创建一个Date对象，从时间戳中获取日期和时间
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))

        // 创建一个DateFormatter对象
        let dateFormatter = DateFormatter()
        
        // 设置本地化语言和地区
        //        dateFormatter.locale = Locale.current
        dateFormatter.locale = Locale(identifier: "ja-JP")

        // 设置日期和时间样式（这里使用默认的样式，根据用户的首选语言和地区进行格式化）
//        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .long
        // 注：dateStyle 与 timeStyle 如果不写，将为空，即可以只写dateStyle以只输出日期

        // 使用DateFormatter来格式化日期和时间
        let formattedDate = dateFormatter.string(from: date)

//        print("格式化的日期和时间：\(formattedDate)")
        print("\(formattedDate)")
        
        
        let label = UILabel()
        label.set(superview: view, text: formattedDate)
        label.setStyle17pt222Med()
        label.setFrame(left: 20, top: 100)
        
    }
    /*
     地区：
     zh-HK 华 - 香港的 SAR
     zh-MO 华 - 澳门的 SAR
     zh-CN 华 - 中国
     zh-CHS 华 - 简体 24小时制
     zh-SG 华 -新加坡
     zh-TW 华 -台湾
     zh-CHT 华 - 繁体
     
     en 英国
     en-GB 英国 - 英国
     en-US 英国 - 美国
     */

    
    // MARK: - 代理方法
    
    
    
    
    // MARK: - @objc func
    
    
    
    
}


