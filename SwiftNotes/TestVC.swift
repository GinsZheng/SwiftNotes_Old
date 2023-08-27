import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    
    let dateSource = [
        ["title":"0 Swift","bgColor":cBlue_5393FF],
        ["title":"1 Xcode","bgColor":cPurple_BF62F8],
        ["title":"2 Java","bgColor":cMagenta_FC5AAE],
        ["title":"3 PHP","bgColor":cRed_FF635A],
        ["title":"4 JS","bgColor":cOrange_F9AD18],
        ["title":"5 Reac","bgColor":cGreen_25BE3C],
        ["title":"6 Ruby","bgColor":cBluishGreen_01C7BD],
        ["title":"7 HTML","bgColor":cBlue_5393FF],
        ["title":"8 C# ","bgColor":cPurple_BF62F8],
        ["title":"9 C++","bgColor":cPurple_BF62F8],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 获取每个Label的宽度并保存在全局变量中，方便在layout中调用
        kAutoLayoutTitleWidths = []
        for i in 0..<dateSource.count {
            let width = getLabelWidth(text: dateSource[i]["title"] ?? "", fontSize: 17, weight: .medium)
            kAutoLayoutTitleWidths.append(width)
        }
        
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kWithoutNavBarHeight)
        let layout = heheLayout(titleOffset: 20, itemInterval: 6, itemHeight: 66)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(hahaCell.self, forCellWithReuseIdentifier: String(describing: hahaCell.self))
        collectionView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        
    }
    
    
    // MARK: - CollectionView 代理
    
    // 设置数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateSource.count
    }
    
    // 设置点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.push(toTarget: CSGeneralSubpage())
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // 设置 cell 逻辑
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: hahaCell.self), for: indexPath) as! hahaCell
        // 把UI逻辑放在自定义的 CollectionViewCell，把数据放在此
        let data = dateSource[indexPath.row]
        cell.setData(title: data["title"] ?? "", color: data["bgColor"] ?? "")
        
        return cell
    }
    
    
}


// MARK: - 自定义 Cell

class hahaCell: UICollectionViewCell {
    
    // 输入参数
    let titleOffset: CGFloat = 20  // ⚠️这里的值要与布局中的titleOffset一致
    
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - func
    
    func setData(title: String, color: String) {
        setImageView(color: color)
        setTitle(text: title)
        resetImageWidth()
    }
    
    func setImageView(color: String) {
        imageView.set(superview: contentView, image: getImageWithColor(color: color), cornerRadius: 10)
        imageView.setFrame(left: 0, top: 0, width: 0, height: 60)
    }
    
    func setTitle(text: String) {
        titleLabel.set(superview: imageView, text: text)
        titleLabel.setStyle17ptFFFMedCent()
        titleLabel.setFrame(left: 10, centerY: imageView.centerY, width: titleLabel.getLabelWidth(), height: 20)
    }
    
    func resetImageWidth() {
        imageView.width = titleLabel.getLabelWidth() + titleOffset
    }
    
}



// MARK: - 自定义Layout

class heheLayout: UICollectionViewLayout {
    
    // 初始化参数
    var titleOffset: CGFloat = 0
    var itemInterval: CGFloat = 0
    var itemHeight: CGFloat = 0
    
    var contentHeight: CGFloat = 0
    var itemCount = 0
    var titleWidths: [CGFloat] = kAutoLayoutTitleWidths

    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    init(titleOffset: CGFloat, itemInterval: CGFloat, itemHeight: CGFloat) {
        super.init()
    
        self.titleOffset = titleOffset
        self.itemInterval = itemInterval
        self.itemHeight = itemHeight
    }
            
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化一些参数与布局
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        itemCount = collectionView.numberOfItems(inSection: 0)
        
        // 设置所有单元格的位置属性
        layoutAttributes.removeAll()
        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            if let attributes = layoutAttributesForItem(at: indexPath) {
                layoutAttributes.append(attributes)
            }
        }
    }
    
    // 设置内容区域总大小，是不可见区域
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.bounds.width ?? 0, height: contentHeight)
    }
    
    // 设为只有在可见区域内的单元格的布局属性会被返回，以减少不必要的计算和绘制，提高性能
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter { $0.frame.intersects(rect) }
    }
    
    // 设置单个单元格的位置属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        contentHeight = getAutoLayoutContentHeight(indexPath: indexPath, titleWidths: titleWidths, titleOffset: titleOffset, itemInterval: itemInterval, itemHeight: itemHeight, collectionViewWidth: collectionView?.bounds.width ?? 0)
        
        let attributes = createAutoLayoutAttributes(indexPath: indexPath, titleWidths: titleWidths, titleOffset: titleOffset, itemInterval: itemInterval, itemHeight: itemHeight, collectionViewWidth: collectionView?.bounds.width ?? 0)
        return attributes
    }
    
}

