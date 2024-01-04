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
        
        let text = "在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在"
        
        let height = getLabelHeight(labelWidth: 200, text: text, fontSize: 20, weight: .medium, numberOfLines: 2, lineHeightMultiple: 1.4)
        
        let label = UILabel()
        label.setText(text: text, numberOfLines: 0, lineHeightMultiple: 1.4)
        label.setup(superview: view, text: text, numberOfLines: 0)
        label.setStyle20pt222Med()
        label.setFrame(left: 0, top: 100, width: 200, height: label.getLabelHeight(withWidth: 200))
        label.setBackgroundColor(color: cRed_FF635A)
        print("label", label.height)
        
        let textView = UITextView()
        textView.setup(superview: view, text: text, maxLines: 0, lineHeightMultiple: 1.4)
        textView.setStyle20pt222Med()
        textView.setFrame(left: 0, top: 300, width: 200, height: textView.getTextHeight(withWidth: 200))
        print("textView", textView.height)
    }
    
        
    // MARK: - @objc func
    
    
}

