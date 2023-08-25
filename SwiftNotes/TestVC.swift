//
//import UIKit
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.setBackgroundColor(color: cFFF)
//
//        let imageView = UIImageView()
//        imageView.set(superview: view, imageName: "iPhone7", cornerRadius: 10)
//        imageView.setFrame(left: 20, top: 100, width: 100, height: 100)
//
//        let a = ceil(10 / 3)
//        print(a)
//    }
//
//}
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    
    let dateSource = [
        ["title":"Swift","bgColor":cBlue_5393FF],
        ["title":"Xcode","bgColor":cPurple_BF62F8],
        ["title":"Java","bgColor":cMagenta_FC5AAE],
        ["title":"PHP","bgColor":cRed_FF635A],
        ["title":"JS","bgColor":cOrange_F9AD18],
        ["title":"React","bgColor":cGreen_25BE3C],
        ["title":"Ruby","bgColor":cBluishGreen_01C7BD],
        ["title":"HTML","bgColor":cBlue_5393FF],
        ["title":"C#","bgColor":cPurple_BF62F8],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x:0, y:0, width: kScreenWidth, height:kWithoutNavBarHeight)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: EgCollectionViewLayout())
        collectionView.register(EgCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: EgCollectionViewCell.self))
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EgCollectionViewCell.self), for: indexPath) as! EgCollectionViewCell
        // 把UI逻辑放在自定义的 CollectionViewCell，把数据放在此
        let data = dateSource[indexPath.row]
        cell.titleLabel.setText(text: data["title"] ?? "")
        cell.imageView.setImage(image: getImageWithColor(color: data["bgColor"] ?? ""))
        
        return cell
    }
    

}

