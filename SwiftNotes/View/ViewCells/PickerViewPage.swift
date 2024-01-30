import UIKit

class PickerViewPage: UIViewController {
    let pickerData = ["今天", "昨天", "前天"]
    
    let pickerView = UIPickerView()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}


// MARK: - 代理方法：PickerView
extension PickerViewPage: UIPickerViewDelegate, UIPickerViewDataSource {
    // 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // 标题
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // 行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return kPickerViewRowHeight
    }
    
}


// MARK: - 私有方法
extension PickerViewPage {
    private func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        pickerView.setup(superview: view, delegate: self, dataSource: self)
        pickerView.setFrame(left: kEdgeMargin, top: 100, right: kEdgeMargin, height: kPickerViewHeight)
    }

}
