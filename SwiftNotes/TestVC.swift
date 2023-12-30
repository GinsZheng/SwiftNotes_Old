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
        
//        let hey = getLabelHeight(text: "在在在在在在在在在在在在在在在在在在", numberOfLines: 2, fontSize: 20, weight: .medium, lineHeight: 1.4)
        let hey = getLabelHeight(forText: text, fontSize: 20, weight: .medium, lineHeightMultiple: 1.4, labelWidth: 200)
        print("getLabelHeight", hey)
        
        let label = UILabel()
        label.setup(superview: view, text: text, numberOfLines: 0)
        label.setStyle20pt222Med()
        label.setFrame(left: 0, top: 100, width: 200, height: label.getLabelHeight(withWidth: 200))
        print("label", label.height)
        
        let textView = UITextView()
        textView.setup(superview: view, text: text, maxLines: 0)
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

func getLabelHeight(forText text: String, fontSize: CGFloat, weight: UIFont.Weight, lineHeightMultiple: CGFloat, labelWidth: CGFloat) -> CGFloat {
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
    return ceil(rect.size.height)
}
