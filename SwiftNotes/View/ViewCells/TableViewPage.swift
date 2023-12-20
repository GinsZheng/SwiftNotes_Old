//
//  TableViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: BaseDataManager<DefaultTableViewItem> {
    init() {
        super.init(initialItems: [
            DefaultTableViewItem(title: "Animation", viewController: AnimationPage()),
            DefaultTableViewItem(title: "Button", viewController: ButtonPage()),
        ])
    }
}


class TableViewPage: UIViewController {
    
    private let tableData = DataManager()
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cF2F3F6)
        
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: DefaultTableViewCell.identifier)
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kVertMargin, right: 0)
        // 数据更新时刷新列表
        tableData.onItemsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    
    // MARK: - @objc func
    
}


// MARK: - TableView 代理方法
extension TableViewPage: UITableViewDelegate, UITableViewDataSource {
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: tableData[indexPath.row].viewController)
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell else { return UITableViewCell() }
        cell.configure(cellType: .titleNext,
                       indexPath: indexPath,
                       dataCount: tableData.count,
                       title: tableData[indexPath.row].title,
                       description: "描述描述描述描述描述描述描述描述描述",
                       leftIconName: "next",
                       isSwitchOn: true
        )
        return cell
    }
}




// MARK: - CellType：UITableViewCell的UI类型
enum CellType {
    case title
    case titleNext
    case titleSwitch
    case titleIconNext
    case titleIconSwitch
    case titleDesc
    case titleDescNext
    case titleDescSwitch
}

extension CellType {
    static func getType(fromTypeId typeId: Int) -> CellType {
        switch typeId {
        case 0:
            return .titleNext
        case 1:
            return .titleSwitch
        default:
            return .titleNext
        }
    }
}


// MARK: - 自定义的默认 tableViewCell
class DefaultTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: DefaultTableViewCell.self)
    
    private let bgView = UIView()
    private let highlightView = UIView()
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let leftIcon = UIImageView()
    private let rightIcon = UIImageView()
    private let switchControl = UISwitch()
    private let separator = UIView()
    
    
    // MARK: - 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - func
    // 设置控件非布局内容 (严谨说是一次性设置的内容，这通常都是非布局内容)
    private func setupUI() {
        self.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        self.setBackgroundColor(color: cNoColor)
        self.selectionStyle = .none
        
        print("contentView", self.height)
        bgView.setup(superview: contentView, backgroundColor: cFFF)
        bgView.setFrame(left: kEdgeMargin, top: 0, right: kEdgeMargin, height: contentView.height)
        
        highlightView.setup(superview: bgView, backgroundColor: c000_10)
        highlightView.setFrame(allEdges: 0)
        highlightView.isHidden = true
    }
    
    // 设置高亮
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        highlightView.isHidden = !highlighted
    }
    
    // 设置选中
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        highlightView.isHidden = !selected
    }
    
    // 配置数据
    func configure(cellType: CellType, indexPath: IndexPath, dataCount: Int, title: String, description: String = "", descriptionLine: Int = 1, leftIconName: String = "", isSwitchOn: Bool = false) {
        bgView.setCellCornerRadius(radius: kRadius, index: indexPath.row, dataCount: dataCount)
        
        titleLabel.setup(superview: bgView, text: title)
        titleLabel.setStyle17pt222()
        
        var cellType1: CellType = .titleIconSwitch
        switch cellType1 {
            // MARK: - title
        case .title:
            let titleLabelMaxWidth = bgView.width - kCellPadding*2
            titleLabel.setFrame(left: kCellPadding, centerY: bgView.centerY, width: titleLabel.getLabelWidth(withMaxWidth: titleLabelMaxWidth), height: kCellHeight)
            
            // 描述文本宽度 = cell白色背景宽度 - 标题右侧坐标(= 标题左侧留白 + 标题宽度) - 标题与描述间隔 - 描述右侧留白
            let descriptionLabelWidth = bgView.width - titleLabel.right - kCellInterval - kCellPadding
            descriptionLabel.setup(superview: bgView, text: description, numberOfLines: descriptionLine)
            descriptionLabel.setStyle14pt999Right()
            descriptionLabel.setFrame(right: kCellPadding, centerY: bgView.centerY, width: descriptionLabelWidth, height: kCellHeight)
            if descriptionLabel.width < 14 { descriptionLabel.isHidden = true } // 如果描述文本宽度不够一个字(14pt)，就隐藏
            
            separator.setup(superview: bgView, backgroundColor: cSeparator)
            separator.setSeparatorFrame(left: kCellPadding, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
            
            // MARK: - titleNext
        case .titleNext:
            let titleLabelMaxWidth = bgView.width - kCellPadding*2 - kCellIconWidth
            titleLabel.setFrame(left: kCellPadding, centerY: bgView.centerY, width: titleLabel.getLabelWidth(withMaxWidth: titleLabelMaxWidth), height: kCellHeight)
            
            rightIcon.setup(superview: bgView, imageName: "next")
            rightIcon.setFrame(right: kCellPadding, centerY: bgView.centerY, width: kCellIconWidth, height: kCellIconHeight)
            
            // 描述文本宽度 = cell白色背景宽度 - 标题右侧坐标(=标题左侧留白+标题宽) - 标题与描述间隔 + 箭头图标宽 + 图标右侧留白)
            // 注：箭头图标与本身包含了留白，所以描述与箭头之间无需设间隔
            let descriptionLabelWidth = bgView.width - titleLabel.right - kCellInterval - kCellPadding - kCellIconWidth
            descriptionLabel.setup(superview: bgView, text: description, numberOfLines: descriptionLine)
            descriptionLabel.setStyle14pt999Right()
            descriptionLabel.setFrame(right: kCellPadding + kCellIconWidth, centerY: bgView.centerY, width: descriptionLabelWidth, height: kCellHeight)
            if descriptionLabel.width < 14 { descriptionLabel.isHidden = true } // 如果描述文本宽度不够一个字(14pt)，就隐藏
            
            separator.setup(superview: bgView, backgroundColor: cSeparator)
            separator.setSeparatorFrame(left: kCellPadding, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
            
            // MARK: - titleSwitch
        case .titleSwitch:
            let titleLabelMaxWidth = bgView.width - kCellPadding*2 - kSwitchWidth - kCellInterval
            titleLabel.setFrame(left: kCellPadding, centerY: bgView.centerY, width: titleLabel.getLabelWidth(withMaxWidth: titleLabelMaxWidth), height: kCellHeight)
            
            separator.setup(superview: bgView, backgroundColor: cSeparator)
            separator.setSeparatorFrame(left: kCellPadding, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
            
            switchControl.setup(superview: bgView, setOn: isSwitchOn, target: self, action: #selector(switchTapped))
            switchControl.setFrame(right: kCellPadding, centerY: bgView.centerY)
            
            // MARK: - titleIconNext
        case .titleIconNext:
            leftIcon.setup(superview: bgView, imageName: leftIconName)
            leftIcon.setFrame(left: kCellPadding, centerY: bgView.centerY, width: kCellIconWidth, height: kCellIconHeight)
            
            let titleLabelMaxWidth = bgView.width - leftIcon.right - kCellInterval - kCellPadding - kCellIconWidth - kCellInterval
            titleLabel.setFrame(left: leftIcon.right + kCellInterval, centerY: bgView.centerY, width: titleLabel.getLabelWidth(withMaxWidth: titleLabelMaxWidth), height: kCellHeight)
            
            rightIcon.setup(superview: bgView, imageName: "next")
            rightIcon.setFrame(right: kCellPadding, centerY: bgView.centerY, width: kCellIconWidth, height: kCellIconHeight)
            
            // 描述文本宽度 = cell白色背景宽度 - 标题右侧坐标(=标题左侧留白+标题宽) - 标题与描述间隔 + 箭头图标宽 + 图标右侧留白)
            // 注：箭头图标与本身包含了留白，所以描述与箭头之间无需设间隔
            let descriptionLabelWidth = bgView.width - titleLabel.right - kCellInterval - kCellPadding - kCellIconWidth
            descriptionLabel.setup(superview: bgView, text: description, numberOfLines: descriptionLine)
            descriptionLabel.setStyle14pt999Right()
            descriptionLabel.setFrame(right: kCellPadding + kCellIconWidth, centerY: bgView.centerY, width: descriptionLabelWidth, height: kCellHeight)
            if descriptionLabel.width < 14 { descriptionLabel.isHidden = true } // 如果描述文本宽度不够一个字(14pt)，就隐藏
            
            separator.setup(superview: bgView, backgroundColor: cSeparator)
            separator.setSeparatorFrame(left: leftIcon.right + kCellInterval, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
            
            // MARK: - titleIconSwitch
        case .titleIconSwitch:
            leftIcon.setup(superview: bgView, imageName: leftIconName)
            leftIcon.setFrame(left: kCellPadding, centerY: bgView.centerY, width: kCellIconWidth, height: kCellIconHeight)
            
            let titleLabelMaxWidth = bgView.width - leftIcon.right - kCellInterval - kCellPadding - kSwitchWidth - kCellInterval
            titleLabel.setFrame(left: leftIcon.right + kCellInterval, centerY: bgView.centerY, width: titleLabel.getLabelWidth(withMaxWidth: titleLabelMaxWidth), height: kCellHeight)
            
            switchControl.setup(superview: bgView, setOn: isSwitchOn, target: self, action: #selector(switchTapped))
            switchControl.setFrame(right: kCellPadding, centerY: bgView.centerY)
            
            separator.setup(superview: bgView, backgroundColor: cSeparator)
            separator.setSeparatorFrame(left: leftIcon.right + kCellPadding, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
            
        case .titleDesc:
            // ❓怎么处理高度不一致的问题(方法一：在这里重新设置bgView的frame)
            let titleLabelMaxWidth = bgView.width - kCellPadding*2
            titleLabel.setFrame(left: kCellPadding, centerY: bgView.centerY, width: titleLabel.getLabelWidth(withMaxWidth: titleLabelMaxWidth), height: kCellHeight)
            
            // 描述文本宽度 = cell白色背景宽度 - 标题右侧坐标(= 标题左侧留白 + 标题宽度) - 标题与描述间隔 - 描述右侧留白
            let descriptionLabelWidth = bgView.width - titleLabel.right - kCellInterval - kCellPadding
            descriptionLabel.setup(superview: bgView, text: description, numberOfLines: descriptionLine)
            descriptionLabel.setStyle14pt999Right()
            descriptionLabel.setFrame(right: kCellPadding, centerY: bgView.centerY, width: descriptionLabelWidth, height: kCellHeight)
            if descriptionLabel.width < 14 { descriptionLabel.isHidden = true } // 如果描述文本宽度不够一个字(14pt)，就隐藏
            
            separator.setup(superview: bgView, backgroundColor: cSeparator)
            separator.setSeparatorFrame(left: kCellPadding, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
            
            
            
            //
            //
            //        case .titleDescNext:
            //
            //        case .titleDescSwitch:
            
        default:
            print("错误")
        }
        
        
    }
    
    //    case title
    //    case titleNext
    //    case titleSwitch
    //    case titleIconNext
    //    case titleIconSwitch
    //    case titleDesc
    //    case titleDescNext
    //    case titleDescSwitch
    // 右侧图标不是next(可以把next作为默认值)
    
    
    // MARK: - @objc func
    @objc func switchTapped() {
        print("hey")
    }
    
}





/*
 DefaultTableViewCell 类中，为什么要各控件的内容分开写入 setupUI() 和 layoutSubviews() 和 configure()
 因为每一个代码的调用机制不一样：
 setupUI(主要是非布局内容)只会在初始化时调用一次
 layoutSubviews()(主要是布局内容)会在布局有变化时调用一次 (时机有：视图大小改变时、添加或移除子视图时、改变约束时)
 configure()则是每次数据有更新是调用一次。configure很多时候是专用于处理数据的，但如果遇到需要依据数据来调整布局时，就应当把布局写入configure
 注：用configure布局的实例见CollectionViewAutoLayoutPage
 为了优化性能，应当尽量把代码放在setupUI，其次是layoutSubviews与configure(具体业务要求)
 */

/*
 TableViewCell内容超出Frame：
 TableViewCell内容超出Frame时，以投影超出为例，可以完整显示，不会被裁切，
 但在滑动列表后，会出现投影被裁切的情况，些时把背景颜色设置为透明即可解决
 (可能)扩展而言：只要不设置 maskToBounds 属性，所有的视图都可以超出控件边界
 */

/*
 复杂情形示例：
 同时满足 A：需要在子页面(通过代理)更新父页面的列表 B：列表的高度根据文字多少计算而来
 思路：1. 为了满足B，高度需要创建一个数组如cellHeightArray，在func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) 函数中完成计算与添加值到数组cellHeightArray中。然后把cellHeightArray的值作为func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)中的返回的cell高度值
 2. 为了满足A，需要创建一个代理，代理中由于不知道cellHeightArray在更新后的值，所以要让cellHeightArray = Array(repeating: 0, count: dateArray.count)，先填个正确长度的值，然后让cellHeightArray在<cellForRowAt>中赋值，要写成cellHeightArray[indexPath.row] = cellHeight 而不是用append方法，来完成替换
 3. 详见蜗牛进度中的⌜进度列表⌟页面
 
 */


/*
 TableViewCell中可交互控件失效处理方法：
 // 以UISwitch为例，把UISwitch控件添加到cell.contentView上而不是添加到cell上
 let cell = CellComponent()
 cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: 0)
 cell.setBackgroundColor(color: cNoColor)
 cell.selectionStyle = .none
 
 let switchView = UISwitch()
 switchView.setup(superview: cell.contentView)
 switchView.setFrame(right: 20, centerY: cardBg.centerY, width: switchView.width, height: switchView.height)
 switchView.onTintColor = UIColor.hex(cBlue_5393FF)
 switchView.setOn(true, animated: false)
 */

/*
 此函数：func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 主要是用来设置数据，而不是设置UI，所以应当把UI放到另一个自定义的UITableViewCell类中
 */
/*
 ⚠️如果是做成卡片等视觉区域与与响应区域不重叠时，一定要把视觉区域置于响应区域中间，否则会出现响应区域偏差
 */

/*
 willDisplay方法：collectionView(_:willDisplay:forItemAt:)
 这个方法在集合视图（UICollectionView）即将展示一个单元格（cell）到屏幕上时被调用，作用包括：
 1. 最后一刻的修改：允许你在单元格显示之前进行最后一刻的修改。例如，可以根据需要动态改变单元格的外观或布局。
 2. 预加载内容：如果你需要根据单元格的内容进行一些预加载操作（如数据预加载或图像异步加载），这个方法提供了一个合适的地方来启动这些操作
 3. 跟踪单元格的展示：可以用于跟踪哪些单元格即将显示在用户界面上
 4. 性能优化：由于这个方法在单元格展示前调用，你可以利用它来减少单元格初始化时的计算量，从而提高滚动的流畅度
 eg：需要在最后一个单元格渲染完成后，再执行一些操作时，如果写在cellForItemAt中，则每个单元格都要执行相应的逻辑
 但
 */

/*
 为什么用：guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell else { return UITableViewCell() }
 而不是直接 let cell = AutoLayoutCollectionViewCell() ？
 因为前者的做法更优：
 1. 单元格重用：这是处理大量数据的集合视图的关键性能优化。当您滚动集合视图时，离开屏幕的单元格会被放入重用池。
 2. 自动布局和尺寸处理
 3. 与集合视图的集成：确保单元格正确响应数据更改和视图更新
 */
