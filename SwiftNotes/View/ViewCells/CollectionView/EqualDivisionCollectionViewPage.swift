// ⚠️待完善：瀑布流的逻辑需要重写createEqualDivisionLayoutAttributes函数，处理y值

import UIKit

private class DataManager: BaseDataManager<Models.CollectionImageItem> {
    init() {
        super.init(initialItems: [
            .init(title: "0 Swift", imageName: "iPhone4S"),
            .init(title: "1 Xcode", imageName: "iPhoneSE"),
            .init(title: "2 Java", imageName: "iPhone7"),
            .init(title: "3 PHP", imageName: "iPhone7P"),
            .init(title: "4 JS", imageName: "iPhoneX"),
            .init(title: "5 React", imageName: "iPhone4S"),
            .init(title: "6 Ruby", imageName: "iPhoneSE"),
            .init(title: "7 HTML", imageName: "iPhone7"),
            .init(title: "8 C#", imageName: "iPhone7P"),
            .init(title: "9 C++", imageName: "iPhoneX"),
        ])
    }
}


// 输入参数
private struct CollectionStyles {
    static let eachLineCount: CGFloat = 3
    static let itemHeight: CGFloat = 200
}


class EqualDivisionCollectionViewPage: UIViewController {
    private let collectionData = DataManager()
    
    var collectionView: UICollectionView!
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


// MARK: - CollectionView 代理方法
extension EqualDivisionCollectionViewPage: UICollectionViewDelegate, UICollectionViewDataSource {
    // 点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.push(targetVC: CSGeneralSubpage())
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // 数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    // cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EqualDivisionCollectionViewCell.identifier, for: indexPath) as? EqualDivisionCollectionViewCell else { return UICollectionViewCell() }
        // 把UI逻辑放在自定义的 EqualDivisionCollectionViewCell，把数据放在此
        let item = collectionData[indexPath.row]
        cell.configure(title: item.title, imageName: item.imageName)
        return cell
    }
}


// MARK: - 私有方法
extension EqualDivisionCollectionViewPage {
    private func setupUI() {
        let layout = EqualDivisionCollectionViewLayout()
        layout.fetchAspectRatioClosure = {
            self.collectionData.map {
                getAspectRatio(ofImageNamed: $0.imageName)
            }
        }
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(EqualDivisionCollectionViewCell.self, forCellWithReuseIdentifier: EqualDivisionCollectionViewCell.identifier)
        collectionView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        collectionView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
    }
    
}


// MARK: - 创建一个 EqualDivisionCollectionViewCell，方便复用
class EqualDivisionCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: EqualDivisionCollectionViewCell.self)
    
    let cellWidth = kScreenWidth/CollectionStyles.eachLineCount
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    
    // MARK: - 初始化与生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 公共方法
    func configure(title: String, imageName: String) {
        titleLabel.text = title
        imageView.image = UIImage(named: imageName)
        
        imageView.setFrame(left: 0, top: 0, width: cellWidth, height: imageView.getScaledHeight(forWidth: cellWidth))
        titleLabel.setFrame(left: 0, centerY: imageView.centerY, width: cellWidth, height: 20)
    }
    
    // MARK: - 私有方法
    private func setupUI() {
        imageView.setup(superview: self, cornerRadius: 0)
        
        titleLabel.setup(superview: self)
        titleLabel.self.setStyle17ptFgWhiteMedCenter()
    }
    
}


// MARK: - 创建一个 EqualDivisionCollectionViewLayout，用于设置布局
class EqualDivisionCollectionViewLayout: UICollectionViewLayout {
    var fetchAspectRatioClosure: (() -> [CGFloat])? // 用于获取cell高度
    
    var itemCount = 0
    var itemWidth: CGFloat = 0
    var contentHeight: CGFloat = 0
    var itemHeight: [CGFloat] = []
    
    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    // MARK: - 初始化与生命周期方法
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        
        itemCount = collectionView.numberOfItems(inSection: 0)
        itemWidth = (collectionView.width) / CollectionStyles.eachLineCount
        contentHeight = CGFloat(ceil(Double(itemCount) / CollectionStyles.eachLineCount)) * CollectionStyles.itemHeight

        if let aspectRatio = fetchAspectRatioClosure?() {
            itemHeight = aspectRatio.map { itemWidth / $0 }
            print("itemHeight", itemHeight)
        }
        
        // 设置所有单元格的位置属性
        layoutAttributes.removeAll() // 在布局更新时，确保数组不会保留旧的布局信息而显示错误
        layoutAttributes = (0..<itemCount).compactMap { index in
            let indexPath = IndexPath(item: index, section: 0)
            return layoutAttributesForItem(at: indexPath)
        }
        
    }
    
    // (维持不变)设置内容区域总大小，是不可见区域
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.bounds.width ?? 0, height: contentHeight)
    }
    
    // (维持不变)设为只有在可见区域内的单元格的布局属性会被返回，以减少不必要的计算和绘制，提高性能
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter { $0.frame.intersects(rect) }
    }
    
    // (维持不变)设置单个单元格的位置属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return createEqualDivisionLayoutAttributes(indexPath: indexPath, eachLineCount: CollectionStyles.eachLineCount, itemWidth: itemWidth, itemHeight: itemHeight[indexPath.row])
    }
    
}



// MARK: - 笔记
/*
 override func prepare()
 prepare()在布局准备阶段被调用，用于进行一些初始化工作, 如：
 1. 计算并存储每个单元格的布局属性，以便后续的方法可以使用这些属性。
 2. 计算并设置 collectionViewContentSize 属性，表示整个内容的大小，这会影响滚动范围。
 想比init() ，某些内容在init中还未生成，比如想获取列表数量： collectionView!.numberOfItems(inSection: 0)，因collectionView未生成，所以会崩溃，而在prepare中collectionView就已生成，能正常运行
 */

