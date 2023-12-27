//import UIKit
//
//private class DataManager: DefaultCellDataManager {
//    init() {
//        super.init(initialItems: [
//            .titleNextVC(title: "Animation", viewController: AnimationPage()),
//            .titleNextVC(title: "Button", viewController: ButtonPage()),
//        ])
//    }
//}
//
//
//class ViewController2: UIViewController {
//    
//    private let tableData = DataManager()
//    
//    let tableView = UITableView()
//    
//    
//    // MARK: - 生命周期方法
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//    
//    
//    // MARK: - func
//    func setupUI() {
//        view.setBackgroundColor(color: cF2F3F6)
//        setupDefaultTableView(tableView)
//        // 数据更新时刷新列表
//        tableData.onItemsUpdated = { [weak self] in
//            self?.tableView.reloadData()
//        }
//    }
//    
//    
//    // MARK: - @objc func
//    
//}
//
//
//// MARK: - TableView 代理方法
//extension ViewController2: UITableViewDelegate, UITableViewDataSource {
//    // 行高
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return kCellHeight
//    }
//    
//    // 点击
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = tableData[indexPath.row]
//        item.handleCellTap(in: self)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//    // 行数
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableData.count
//    }
//    
//    // cell
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
//        cell.prepare(row: indexPath.row, dataCount: tableData.count)
//        let item = tableData[indexPath.row]
//        item.configureCell(cell)
//        return cell
//    }
//}
//
