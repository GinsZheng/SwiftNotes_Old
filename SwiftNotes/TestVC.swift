
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)

        let imageView = UIImageView()
        imageView.set(superview: view, imageName: "iPhone7", cornerRadius: 10)
        imageView.setFrame(left: 20, top: 100, width: 100, height: 100)

        let a = ceil(10 / 3)
        print(a)
    }


}



