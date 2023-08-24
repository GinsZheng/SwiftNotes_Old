//import UIKit
//
//class ViewController223: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    let list: [(String, UIViewController)] = [
//        ("Animation", CSGeneralSubpage()),
//        ("Button", CSGeneralSubpage()),
//    ]
//    
//    let tableView = UITableView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.register(NewCell.self, forCellReuseIdentifier: "NewCell")
//        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
//        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndTabBarHeight)
//
//    }
//    
//    
//    // MARK: - tableview 代理
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list.count
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return kCellHeight
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.push(toTarget: CSGeneralSubpage())
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath) as! NewCell
//        cell.titleLabel.setText(text: list[indexPath.row].0)
//        
//        return cell
//    }
//    
//    // MARK: - @objc
//    
//}
//
//
//class NewCell: UITableViewCell {
//    
//    let titleLabel = UILabel()
//    let nextIcon = UIImageView()
//    let separator = UIView()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        titleLabel.set(superview: contentView)
//        titleLabel.setStyle17pt222()
//        titleLabel.setFrame(left: 16, centerY: contentView.centerY)
//        
//        nextIcon.set(superview: contentView, imageName: "next")
//        nextIcon.setFrame(right: 16, centerY: contentView.centerY, width: 18, height: 18)
//
//        separator.set(superview: contentView, backgroundColor: cSeparator)
//        separator.setSeparatorFrame(left: 16, right: 16)
//    }
//    
//}
//
