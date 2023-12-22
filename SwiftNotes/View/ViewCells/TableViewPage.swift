//
//  TableViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: BaseDataManager<DefaultTableItem> {
    init() {
        super.init(initialItems: [
            DefaultTableItem(title: "Animation", viewController: AnimationPage()),
            DefaultTableItem(title: "Button", viewController: ButtonPage()),
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
        
        tableView.register(DefaultCell.self, forCellReuseIdentifier: DefaultCell.identifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        cell.configure(cellType: .titleRightIcon,
                       indexPath: indexPath,
                       dataCount: tableData.count,
                       title: tableData[indexPath.row].title
        )
        return cell
    }
}


// MARK: - CellType：默认的表格视图UI类型
enum CellType: Int {
    case title = 11                      // 只有标题 (右侧说明非开关的cell都有。11指数据传来的typeId)
    case titleRightIcon = 12             // 标题 + 右图标
    case titleSwitch = 13                // 标题 + 开关
    case titleLeftIconRightIcon = 14     // 标题 + 左图标(标题前) + 右图标
    case titleLeftIconSwitch = 15        // 标题 + 左图标(标题前) + 开关
    case titleDesc = 21                  // 双行：标题 + 说明
    case titleDescRightIcon = 22         // 双行：标题 + 说明 + 右图标
    case titleDescSwitch = 23            // 双行：标题 + 说明 + 开关
}

extension CellType {
    static func getType(fromTypeId typeId: Int) -> CellType {
        return CellType(rawValue: typeId) ?? .titleRightIcon
    }
}


// MARK: - 自定义的默认 tableViewCell
class DefaultCell: UITableViewCell {
    
    static let identifier = String(describing: DefaultCell.self)
    
    var onSwitchTapped: (() -> Void)?
    
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
        self.setFrame()
        self.setBackgroundColor(color: cNoColor)
        self.selectionStyle = .none
        
        bgView.setup(superview: contentView, backgroundColor: cFFF)
        bgView.setFrame(left: kEdgeMargin, top: 0, right: kEdgeMargin, height: contentView.height)
        
        highlightView.setup(superview: bgView, backgroundColor: c000_10)
        highlightView.setFrame(allEdges: 0)
        highlightView.isHidden = true
        
        separator.setup(superview: bgView, backgroundColor: cSeparator)
        
        titleLabel.setup(superview: bgView)
        titleLabel.setStyle17pt222Med()
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
    func configure(cellType: CellType, indexPath: IndexPath, dataCount: Int, title: String, description: String = "", descriptionLine: Int = 1, leftIconName: String = "", rightIconName: String = kIconNext, isSwitchOn: Bool = false) {
        setupGeneralUI(cellType: cellType, indexPath: indexPath, dataCount: dataCount, title: title)
        setupSpecificUI(cellType: cellType, indexPath: indexPath, dataCount: dataCount, description: description, descriptionLine: descriptionLine, leftIconName: leftIconName, rightIconName: rightIconName, isSwitchOn: isSwitchOn)
    }
    
    // MARK: - @objc func
    @objc func switchTapped() {
        onSwitchTapped?()
    }
}


// DefaultCell 的 configure函数中具体的UI设置函数
extension DefaultCell {
    func setupGeneralUI(cellType: CellType, indexPath: IndexPath, dataCount: Int, title: String) {
        // 只对于双行的Cell重设高度(同时要修改代理函数heightForRowAt中的高度)
        if cellType == .titleDesc || cellType == .titleDescRightIcon || cellType == .titleDescSwitch {
            self.height = k2LineCellHeight
            bgView.height = k2LineCellHeight
            highlightView.height = k2LineCellHeight
        }
        
        // 设置所有cell共有的UI
        bgView.setCellCornerRadius(radius: kRadius, index: indexPath.row, dataCount: dataCount)
        titleLabel.setText(text: title)
    }
    
    func setupSpecificUI(cellType: CellType, indexPath: IndexPath, dataCount: Int, description: String, descriptionLine: Int, leftIconName: String, rightIconName: String, isSwitchOn: Bool) {
        // 根据不同cellType设置不同UI
        switch cellType {
        case .title:
            setupTitle(indexPath: indexPath, dataCount: dataCount, description: description, descriptionLine: descriptionLine)
        case .titleRightIcon:
            setupTitleRightIcon(indexPath: indexPath, dataCount: dataCount, description: description, descriptionLine: descriptionLine, rightIconName: rightIconName)
        case .titleSwitch:
            setupTitleSwitch(indexPath: indexPath, dataCount: dataCount, isSwitchOn: isSwitchOn)
        case .titleLeftIconRightIcon:
            setupTitleLeftIconRightIcon(indexPath: indexPath, dataCount: dataCount, description: description, descriptionLine: descriptionLine, leftIconName: leftIconName, rightIconName: rightIconName)
        case .titleLeftIconSwitch:
            setupTitleLeftIconSwitch(indexPath: indexPath, dataCount: dataCount, leftIconName: leftIconName, isSwitchOn: isSwitchOn)
        case .titleDesc:
            setupTitleDesc(indexPath: indexPath, dataCount: dataCount, description: description, descriptionLine: descriptionLine)
        case .titleDescRightIcon:
            setupTitleRightIcon(indexPath: indexPath, dataCount: dataCount, description: description, descriptionLine: descriptionLine, rightIconName: rightIconName)
        case .titleDescSwitch:
            setupTitleDescSwitch(indexPath: indexPath, dataCount: dataCount, description: description, descriptionLine: descriptionLine, isSwitchOn: isSwitchOn)
        }
    }
    
    func setupTitle(indexPath: IndexPath, dataCount: Int, description: String, descriptionLine: Int) {
        let titleLabelMaxWidth = bgView.width - kCellPadding*2
        titleLabel.setFrame(left: kCellPadding, centerY: bgView.centerY, width: titleLabel.getLabelWidth(withMaxWidth: titleLabelMaxWidth), height: kCellHeight)
        
        // 描述文本宽度 = cell白色背景宽度 - 标题右侧坐标(= 标题左侧留白 + 标题宽度) - 标题与描述间隔 - 描述右侧留白
        let descriptionLabelWidth = bgView.width - titleLabel.right - kCellInterval - kCellPadding
        descriptionLabel.setup(superview: bgView, text: description, numberOfLines: descriptionLine)
        descriptionLabel.setStyle14pt999Right()
        descriptionLabel.setFrame(right: kCellPadding, centerY: bgView.centerY, width: descriptionLabelWidth, height: kCellHeight)
        if descriptionLabel.width < 14 { descriptionLabel.isHidden = true } // 如果描述文本宽度不够一个字(14pt)，就隐藏
        
        separator.setSeparatorFrame(left: titleLabel.left, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
    }
    
    func setupTitleRightIcon(indexPath: IndexPath, dataCount: Int, description: String, descriptionLine: Int, rightIconName: String) {
        rightIcon.setup(superview: bgView, imageName: rightIconName)
        rightIcon.setFrame(right: kCellPadding, centerY: bgView.centerY)
        
        let titleLabelMaxWidth = bgView.width - kCellPadding*2 - kCellInterval - rightIcon.width
        titleLabel.setFrame(left: kCellPadding, centerY: bgView.centerY, width: titleLabel.getLabelWidth(withMaxWidth: titleLabelMaxWidth), height: kCellHeight)
        
        // 描述文本宽度 = cell白色背景宽度 - 标题右侧坐标(=标题左侧留白+标题宽) - 标题与描述间隔 - 描述与右侧图标间隔 - 右侧图标宽 - 图标右侧留白
        let descriptionLabelWidth = bgView.width - titleLabel.right - kCellInterval - kCellInterval - rightIcon.width - kCellPadding
        descriptionLabel.setup(superview: bgView, text: description, numberOfLines: descriptionLine)
        descriptionLabel.setStyle14pt999Right()
        descriptionLabel.setFrame(right: kCellPadding + rightIcon.width + kCellInterval, centerY: bgView.centerY, width: descriptionLabelWidth, height: kCellHeight)
        if descriptionLabel.width < 14 { descriptionLabel.isHidden = true } // 如果描述文本宽度不够一个字(14pt)，就隐藏
        
        separator.setSeparatorFrame(left: titleLabel.left, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
    }
    
    func setupTitleSwitch(indexPath: IndexPath, dataCount: Int, isSwitchOn: Bool) {
        switchControl.setup(superview: bgView, setOn: isSwitchOn, target: self, action: #selector(switchTapped))
        switchControl.setFrame(right: kCellPadding, centerY: bgView.centerY)
        
        let titleLabelMaxWidth = bgView.width - kCellPadding*2 - kSwitchWidth - kCellInterval
        titleLabel.setFrame(left: kCellPadding, centerY: bgView.centerY, width: titleLabel.getLabelWidth(withMaxWidth: titleLabelMaxWidth), height: kCellHeight)
        
        separator.setSeparatorFrame(left: titleLabel.left, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
    }
    
    func setupTitleLeftIconRightIcon(indexPath: IndexPath, dataCount: Int, description: String, descriptionLine: Int, leftIconName: String, rightIconName: String) {
        leftIcon.setup(superview: bgView, imageName: leftIconName)
        leftIcon.setFrame(left: kCellPadding, centerY: bgView.centerY)
        
        rightIcon.setup(superview: bgView, imageName: rightIconName)
        rightIcon.setFrame(right: kCellPadding, centerY: bgView.centerY)
        
        let titleLabelMaxWidth = bgView.width - leftIcon.right - kCellInterval - kCellInterval - rightIcon.width - kCellPadding
        titleLabel.setFrame(left: leftIcon.right + kCellInterval, centerY: bgView.centerY, width: titleLabel.getLabelWidth(withMaxWidth: titleLabelMaxWidth), height: kCellHeight)
        
        // 描述文本宽度 = cell白色背景宽度 - 标题右侧坐标(=标题左侧留白+标题宽) - 标题与描述间隔 - 描述与右侧图标间隔 - 右侧图标宽 - 图标右侧留白
        let descriptionLabelWidth = bgView.width - titleLabel.right - kCellInterval - kCellInterval - rightIcon.width - kCellPadding
        descriptionLabel.setup(superview: bgView, text: description, numberOfLines: descriptionLine)
        descriptionLabel.setStyle14pt999Right()
        descriptionLabel.setFrame(right: kCellPadding + rightIcon.width + kCellInterval, centerY: bgView.centerY, width: descriptionLabelWidth, height: kCellHeight)
        if descriptionLabel.width < 14 { descriptionLabel.isHidden = true } // 如果描述文本宽度不够一个字(14pt)，就隐藏
        
        separator.setSeparatorFrame(left: titleLabel.left, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
    }
    
    func setupTitleLeftIconSwitch(indexPath: IndexPath, dataCount: Int, leftIconName: String, isSwitchOn: Bool) {
        leftIcon.setup(superview: bgView, imageName: leftIconName)
        leftIcon.setFrame(left: kCellPadding, centerY: bgView.centerY)
        
        switchControl.setup(superview: bgView, setOn: isSwitchOn, target: self, action: #selector(switchTapped))
        switchControl.setFrame(right: kCellPadding, centerY: bgView.centerY)
        
        let titleLabelMaxWidth = bgView.width - leftIcon.right - kCellInterval - kCellPadding - kSwitchWidth - kCellInterval
        titleLabel.setFrame(left: leftIcon.right + kCellInterval, centerY: bgView.centerY, width: titleLabel.getLabelWidth(withMaxWidth: titleLabelMaxWidth), height: kCellHeight)
        
        separator.setSeparatorFrame(left: titleLabel.left, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
    }
    
    func setupTitleDesc(indexPath: IndexPath, dataCount: Int, description: String, descriptionLine: Int) {
        let labelWidth = bgView.width - kCellPadding*2 // 同时用于titleLabel和descriptionLabel
        titleLabel.setFrame(left: kCellPadding, top: kCell2LineTitleTopMargin, width: labelWidth)
        
        descriptionLabel.setup(superview: bgView, text: description)
        descriptionLabel.setStyle12pt999()
        descriptionLabel.setFrame(left: kCellPadding, top: titleLabel.bottom + kCell2LineDescTopMargin, width: labelWidth)
        
        separator.setSeparatorFrame(left: titleLabel.left, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
    }
    
    func setupTitleDescRightIcon(indexPath: IndexPath, dataCount: Int, description: String, descriptionLine: Int, rightIconName: String) {
        rightIcon.setup(superview: bgView, imageName: rightIconName)
        rightIcon.setFrame(right: kCellPadding, centerY: bgView.centerY)
        
        let labelWidth = bgView.width - kCellPadding*2 - rightIcon.width - kCellInterval
        titleLabel.setFrame(left: kCellPadding, top: kCell2LineTitleTopMargin, width: labelWidth)
        
        descriptionLabel.setup(superview: bgView, text: description)
        descriptionLabel.setStyle12pt999()
        descriptionLabel.setFrame(left: kCellPadding, top: titleLabel.bottom + kCell2LineDescTopMargin, width: labelWidth)
        
        separator.setSeparatorFrame(left: titleLabel.left, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
    }
    
    func setupTitleDescSwitch(indexPath: IndexPath, dataCount: Int, description: String, descriptionLine: Int, isSwitchOn: Bool) {
        switchControl.setup(superview: bgView, setOn: isSwitchOn, target: self, action: #selector(switchTapped))
        switchControl.setFrame(right: kCellPadding, centerY: bgView.centerY)
        
        let labelWidth = bgView.width - kCellPadding*2 - switchControl.width - kCellInterval
        titleLabel.setFrame(left: kCellPadding, top: kCell2LineTitleTopMargin, width: labelWidth)
        
        descriptionLabel.setup(superview: bgView, text: description)
        descriptionLabel.setStyle12pt999()
        descriptionLabel.setFrame(left: kCellPadding, top: titleLabel.bottom + kCell2LineDescTopMargin, width: labelWidth)
        
        separator.setSeparatorFrame(left: titleLabel.left, right: kCellPadding, index: indexPath.row, dataCount: dataCount)
    }

}



/*
 DefaultCell 类中，为什么要各控件的内容分开写入 setupUI() 和 layoutSubviews() 和 configure()
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
 为什么用：guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
 而不是直接 let cell = AutoLayoutCollectionViewCell() ？
 因为前者的做法更优：
 1. 单元格重用：这是处理大量数据的集合视图的关键性能优化。当您滚动集合视图时，离开屏幕的单元格会被放入重用池。
 2. 自动布局和尺寸处理
 3. 与集合视图的集成：确保单元格正确响应数据更改和视图更新
 */

/*
 实验过将switch cellType {} 中的内容封装成独立于自定义Cell类的函数，发现：
 1. 如果把控件的初始化放入函数中，会出现滚动到列表下一页后，出现titleLabel等元素重复创建导致文本重叠，不可行
 2. 而如果不把初始化放入函数，那么方法相对麻烦，不如不用：1. 使用协议 2. 使用视图标签
 */
