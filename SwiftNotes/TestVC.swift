import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let list: [(String, UIViewController)] = [
        ("Animation", CSGeneralSubpage()),
        ("Button", CSGeneralSubpage()),
    ]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: "DefaultTableViewCell")
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)

    }
    
    
    // MARK: - tableview 代理

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: CSGeneralSubpage())
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell", for: indexPath) as! DefaultTableViewCell
        cell.titleLabel.setText(text: list[indexPath.row].0)
        
        return cell
    }
    
    // MARK: - @objc
    
}


