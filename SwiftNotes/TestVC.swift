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
        
        let height = getLabelHeight(text: text, fontSize: 20, weight: .medium, lineHeightMultiple: 1.4, labelWidth: 200, numberOfLines: 0)
        print("getLabelHeight", height)
        
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



//func getLabelHeight(text: String, numberOfLines: Int, fontSize: CGFloat, weight: UIFont.Weight, lineHeight: CGFloat) -> CGFloat {
//    let singleLineHeight = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: weight)]).height
//    let adjustedLineHeight = singleLineHeight * lineHeight
//    let totalHeight = adjustedLineHeight * CGFloat(numberOfLines)
//    return totalHeight
//}


func getLabelHeight(text: String, fontSize: CGFloat, weight: UIFont.Weight, lineHeightMultiple: CGFloat, labelWidth: CGFloat, numberOfLines: Int) -> CGFloat {
    let font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = lineHeightMultiple

    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .paragraphStyle: paragraphStyle
    ]

    let attributedText = NSAttributedString(string: text, attributes: attributes)
    let size = CGSize(width: labelWidth, height: .greatestFiniteMagnitude)

    let rect = attributedText.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
    let calculatedHeight = ceil(rect.size.height)

    if numberOfLines == 0 {
        return calculatedHeight
    } else {
        let singleLineHeight = "任意文本".size(withAttributes: [.font: font]).height
        let adjustedLineHeight = singleLineHeight * lineHeightMultiple
        let maxLinesHeight = adjustedLineHeight * CGFloat(numberOfLines)
        return min(calculatedHeight, maxLinesHeight)
    }
}
