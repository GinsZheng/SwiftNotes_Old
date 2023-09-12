//import UIKit
//
//class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
//
//    let hours = Array(0...23)
//    let minutes = Array(0...59)
//    let seconds = Array(0...59)
//
//    lazy var durationPicker: UIPickerView = {
//        let pickerView = UIPickerView()
//        pickerView.translatesAutoresizingMaskIntoConstraints = false
//        pickerView.dataSource = self
//        pickerView.delegate = self
//        return pickerView
//    }()
//
//    lazy var selectedDurationLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        return label
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.setBackgroundColor(color: cFFF)
//        setupUI()
//    }
//
//    func setupUI() {
//        view.addSubview(durationPicker)
//        view.addSubview(selectedDurationLabel)
//
//        NSLayoutConstraint.activate([
//            durationPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            durationPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//
//            selectedDurationLabel.topAnchor.constraint(equalTo: durationPicker.bottomAnchor, constant: 20),
//            selectedDurationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//    }
//
//    // UIPickerViewDataSource methods
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 2 // 三个组件：小时、分钟、秒
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        switch component {
//        case 0:
//            return minutes.count
//        case 1:
//            return seconds.count
////        case 2:
////            return seconds.count
//        default:
//            return 0
//        }
//    }
//
//    // UIPickerViewDelegate method
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        switch component {
//        case 0:
//            return "\(minutes[row]) 分钟"
//        case 1:
//            return "\(seconds[row]) 秒"
////        case 2:
////            return "\(seconds[row]) 秒"
//        default:
//            return nil
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let selectedHour = hours[pickerView.selectedRow(inComponent: 0)]
//        let selectedMinute = minutes[pickerView.selectedRow(inComponent: 1)]
//        let selectedSecond = seconds[pickerView.selectedRow(inComponent: 2)]
//
//        let durationString = "\(selectedHour) 小时 \(selectedMinute) 分钟 \(selectedSecond) 秒"
//        selectedDurationLabel.text = durationString
//    }
//
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 21) // 设置字体大小
//        label.textAlignment = .center
//        label.adjustsFontSizeToFitWidth = true
//        label.text = pickerView.delegate?.pickerView?(pickerView, titleForRow: row, forComponent: component) // 获取原始文本
//        return label
//    }
//
//}
//
//
//// 待修改的PickerView
////
////import UIKit
////
////class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
////
////    let hours = Array(0...23)
////    let minutes = Array(0...59)
////    let seconds = Array(0...59)
////
////    lazy var durationPicker: UIPickerView = {
////        let pickerView = UIPickerView()
////        pickerView.translatesAutoresizingMaskIntoConstraints = false
////        pickerView.dataSource = self
////        pickerView.delegate = self
////        return pickerView
////    }()
////
////    lazy var selectedDurationLabel: UILabel = {
////        let label = UILabel()
////        label.translatesAutoresizingMaskIntoConstraints = false
////        label.textAlignment = .center
////        return label
////    }()
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        view.setBackgroundColor(color: cFFF)
////        setupUI()
////    }
////
////    func setupUI() {
////        view.addSubview(durationPicker)
////        view.addSubview(selectedDurationLabel)
////
////        NSLayoutConstraint.activate([
////            durationPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
////            durationPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
////
////            selectedDurationLabel.topAnchor.constraint(equalTo: durationPicker.bottomAnchor, constant: 20),
////            selectedDurationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
////        ])
////    }
////
////    // UIPickerViewDataSource methods
////    func numberOfComponents(in pickerView: UIPickerView) -> Int {
////        return 3 // 三个组件：小时、分钟、秒
////    }
////
////    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
////        switch component {
////        case 0:
////            return hours.count
////        case 1:
////            return minutes.count
////        case 2:
////            return seconds.count
////        default:
////            return 0
////        }
////    }
////
////    // UIPickerViewDelegate method
////    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
////        switch component {
////        case 0:
////            return "\(hours[row]) 小时"
////        case 1:
////            return "\(minutes[row]) 分钟"
////        case 2:
////            return "\(seconds[row]) 秒"
////        default:
////            return nil
////        }
////    }
////
////    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
////        let selectedHour = hours[pickerView.selectedRow(inComponent: 0)]
////        let selectedMinute = minutes[pickerView.selectedRow(inComponent: 1)]
////        let selectedSecond = seconds[pickerView.selectedRow(inComponent: 2)]
////
////        let durationString = "\(selectedHour) 小时 \(selectedMinute) 分钟 \(selectedSecond) 秒"
////        selectedDurationLabel.text = durationString
////    }
////
////    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
////        let label = UILabel()
////        label.font = UIFont.systemFont(ofSize: 18, weight: .medium) // 设置字体大小
////        label.textAlignment = .center
////        label.text = pickerView.delegate?.pickerView?(pickerView, titleForRow: row, forComponent: component) // 获取原始文本
////        return label
////    }
////
////}
////
////
//

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
        
        
    }
    
    
    // MARK: - 代理方法
    
    
    
    
    // MARK: - @objc func
    
    
    
    
}


