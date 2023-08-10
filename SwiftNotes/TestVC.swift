import UIKit

class TestVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        let imageView = UIImageView()
        imageView.set(superview: view, imageName: "translucentImage")
        imageView.setFrame(left: 20, top: 100, width: 36, height: 36)
        
        

        
    }
    
}
