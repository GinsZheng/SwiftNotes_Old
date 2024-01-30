import UIKit

private class DataManager: BaseDataManager<Models.CollectionItem> {
    init() {
        super.init(initialItems: [
            .init(title: "0 Swift", bgColor: cBlue_5393FF),
            .init(title: "1 Xcode", bgColor: cPurple_BF62F8),
            .init(title: "2 Java", bgColor: cMagenta_FC5AAE),
            .init(title: "3 PHP", bgColor: cRed_FF635A),
            .init(title: "4 JS", bgColor: cOrange_F9AD18),
            .init(title: "5 React", bgColor: cGreen_25BE3C),
            .init(title: "6 Ruby", bgColor: cBluishGreen_01C7BD),
            .init(title: "7 HTML", bgColor: cBlue_5393FF),
            .init(title: "8 C#", bgColor: cPurple_BF62F8),
            .init(title: "9 C++", bgColor: cPurple_BF62F8),
        ])
    }
}


// 输入参数
private struct CollectionStyles {
    static let eachLineCount: CGFloat = 3
    static let itemHeight: CGFloat = 200
    static let itemLineSpacing: CGFloat = 0 // 行间距 (默认的item行距不为0)
    static let interitemSpacing: CGFloat = 0 // item左右间距 (默认的item左右间距不为0)
    static let sectionInset: UIEdgeInsets = .init(top: 6, left: 0, bottom: 6, right: 0) // section的内边距，默认为0
}


// MARK: - 视图控制器
class EqualSizeCollectionViewPage: UIViewController {
    private let collectionData = DataManager()
    
    var collectionView: UICollectionView!
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


// MARK: - CollectionView 代理方法
extension EqualSizeCollectionViewPage: UICollectionViewDelegate, UICollectionViewDataSource {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EqualSizeCollectionViewCell.identifier, for: indexPath) as? EqualSizeCollectionViewCell else { return UICollectionViewCell() }
        let item = collectionData[indexPath.row]
        cell.configure(title: item.title, bgColor: item.bgColor)
        return cell
    }
    
}


// MARK: - 私有方法
extension EqualSizeCollectionViewPage {
    private func setupUI() {
        let layout = createLayout() // 定义collectionViewLayout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(EqualSizeCollectionViewCell.self, forCellWithReuseIdentifier: EqualSizeCollectionViewCell.identifier)
        collectionView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        collectionView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: floor(kScreenWidth / CollectionStyles.eachLineCount), height: CollectionStyles.itemHeight)
        layout.minimumLineSpacing = CollectionStyles.itemLineSpacing // 行间距 (注意，默认的item行距不为0)
        layout.minimumInteritemSpacing = CollectionStyles.interitemSpacing // item左右间距 (注意，默认的item左右间距不为0)
        layout.sectionInset = CollectionStyles.sectionInset // section的内边距，默认为0🐾
        return layout
    }
    
}


// MARK: - 自定义cell：EqualSizeCollectionViewCell
class EqualSizeCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: EqualSizeCollectionViewCell.self)
    
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
    func setupUI() {
        imageView.setup(superview: self, cornerRadius: 0)
        imageView.setFrame(left: 0, top: 0, width: ceil(kScreenWidth/CollectionStyles.eachLineCount), height: CollectionStyles.itemHeight)
        
        titleLabel.setup(superview: self)
        titleLabel.setStyle17ptFgWhiteMedCenter()
        titleLabel.setFrame(left: 0, centerY: imageView.centerY, width: ceil(kScreenWidth/CollectionStyles.eachLineCount))
    }
    
    func configure(title: String, bgColor: String) {
        titleLabel.text = title
        imageView.image = getImageWithColor(color: bgColor)
    }
    
}



/*
 sectionInset内边距的作用：
 在整个模块的范围内，把collectionView向内缩一段距离。使用内边距与直接把collectionView的布局缩小有重要区别：
 举例来说：假设我的collectionView需要上下增加10pt高度来让视觉更好看(常见的UI做法)，那么两种做法：
 方法A：把CollectionView的frame缩小，即top = 6pt(距离导航栏6pt)，不设sectionInset
 方法B：把CollectionView的frame充满空间，即top = 0pt(距离导航栏0pt)，sectionInset的top设为6pt
 这两种方法的区别在于滚动时的边界。向上滑动时：
 方法A中，CollectionView的上边界为距导航栏底部最终为6pt，因为这就是CollectionView的边界
 方法B中：CollectionView的上边界为距导航栏底部逐渐从6pt变为0pt
 在我的TimingTask的底部栏中，就需要用方法B才能实现好的效果(做到视觉边界与响应区域重合)
 */
