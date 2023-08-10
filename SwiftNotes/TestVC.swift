import UIKit

class TestVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cEEEFF1)
        
        let groupBg = UIView()
        groupBg.set(superview: view, backgroundColor: cFFF)
        groupBg.setFrame(left: 0, top: 100, width: kScreenWidth, height: 48)

        let buttonList = CSHorizonalScrollingButtonList(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 48))
        buttonList.set(superview: groupBg)
        buttonList.scrollView.OptimizeEdgePanGesture(of: self)
    }
    
    // MARK: - @objc
    @objc func pushToTest() {
        self.push(toTarget: CSGeneralSubpage())
    }
    
    
}


class CSHorizonalScrollingButtonList: UIView {

    let scrollView = UIScrollView()
    var buttons: [UIButton] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScrollView()
        createButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupScrollView()
        createButtons()
    }
    
    func setupScrollView() {
        scrollView.frame = bounds
        scrollView.contentSize = CGSize(width: 3000, height: 48)
        addSubview(scrollView)
    }

    func createButtons() {
        let buttonTitles = ["默认", "今天", "Button 3", "Button 4", "Button 5",
                            "Button 6", "Button 7", "Button 8", "Button 9", "Button 10",
                            "Button 11", "Button 12", "Button 13", "Button 14", "Button 15"]
        
        var frameRight: CGFloat = 0
        
        for (i, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .custom)
            button.set(superview: scrollView)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.hex(c666), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
            button.setBackgroundColor(color: cF0F1F3)
            button.setCornerRadius(radius: 14)
            var labelWidth = button.titleLabel?.getLabelWidth() ?? 0
            if i == 0 {
                button.setFrame(left: 10, centerY: scrollView.centerY, width: labelWidth + 24, height: 28)
            } else {
                button.setFrame(left: frameRight, centerY: scrollView.centerY, width: labelWidth + 24, height: 28)
            }
            
            frameRight = button.right + 6
            
            buttons.append(button)
        }
    }
}
