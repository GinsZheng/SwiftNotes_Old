import Foundation
import UIKit

// snapKit autolayout encapsulation

extension UILabel {
    
    func getLabelWidth(width: CGFloat) -> CGFloat {
        var realWidth: CGFloat = 0
        if width == 0 {
            realWidth = getLabelWidth()
        } else {
            realWidth = width
        }
        return realWidth
    }
    
    func setFrame(left: CGFloat, top: CGFloat, width: CGFloat = 0) {
        self.frame = CGRect(x: left, y: top, width: getLabelWidth(width: width), height: getDefaultLineheight())
    }
    
    func setFrame(left: CGFloat, centerY: CGFloat, width: CGFloat = 0) {
        self.frame.size = CGSize(width: getLabelWidth(width: width), height: getDefaultLineheight())
        self.frame.origin.x = left
        self.centerY = centerY
    }
    
    func setFrame(left: CGFloat, bottom: CGFloat, width: CGFloat = 0) {
        self.frame.size = CGSize(width: getLabelWidth(width: width), height: getDefaultLineheight())
        self.frame.origin.x = left
        self.frame.origin.y = self.superview!.height - self.height - bottom
    }
    
    func setFrame(centerX: CGFloat, top: CGFloat, width: CGFloat = 0) {
        self.frame.size = CGSize(width: getLabelWidth(width: width), height: getDefaultLineheight())
        self.centerX = centerX
        self.frame.origin.y = top
    }
    
    func setFrame(center: UIView, width: CGFloat = 0) {
        self.frame.size = CGSize(width: getLabelWidth(width: width), height: getDefaultLineheight())
        self.frame.origin.x = (center.width - self.width) / 2
        self.frame.origin.y = (center.height - self.height) / 2
    }
    
    func setFrame(centerX: CGFloat, bottom: CGFloat, width: CGFloat = 0) {
        self.frame.size = CGSize(width: getLabelWidth(width: width), height: getDefaultLineheight())
        self.centerX = centerX
        self.frame.origin.y = self.superview!.height - self.height - bottom
    }
    
    func setFrame(right: CGFloat, top: CGFloat, width: CGFloat = 0) {
        self.frame.size = CGSize(width: getLabelWidth(width: width), height: getDefaultLineheight())
        self.frame.origin.x = self.superview!.width - self.width - right
        self.frame.origin.y = top
    }
    
    func setFrame(right: CGFloat, centerY: CGFloat, width: CGFloat = 0) {
        self.frame.size = CGSize(width: getLabelWidth(width: width), height: getDefaultLineheight())
        self.frame.origin.x = self.superview!.width - self.width - right
        self.centerY = centerY
    }
    
    func setFrame(right: CGFloat, bottom: CGFloat, width: CGFloat = 0) {
        self.frame.size = CGSize(width: getLabelWidth(width: width), height: getDefaultLineheight())
        self.frame.origin.x = self.superview!.width - self.width - right
        self.frame.origin.y = self.superview!.height - self.height - bottom
    }
    
    func setFrame(left: CGFloat, top: CGFloat, right: CGFloat) {
        let width = self.superview!.width - left - right
        self.frame = CGRect(x: left, y: top, width: getLabelWidth(width: width), height: getDefaultLineheight())
    }
    
    func setFrame(left: CGFloat, centerY: CGFloat, right: CGFloat) {
        self.frame.size.width = self.superview!.width - left - right
        self.frame.size.height = getDefaultLineheight()
        self.frame.origin.x = left
        self.centerY = centerY
    }

}



extension UIView {
    func setFrame(left: CGFloat, top: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: width, height: height)
        self.frame.origin.x = left
        self.frame.origin.y = top
    }
    
    func setFrame(left: CGFloat, centerY: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: width, height: height)
        self.frame.origin.x = left
        self.centerY = centerY
    }
    
    func setFrame(left: CGFloat, bottom: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: width, height: height)
        self.frame.origin.x = left
        self.frame.origin.y = self.superview!.height - self.height - bottom
    }
    
    func setFrame(centerX: CGFloat, top: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: width, height: height)
        self.centerX = centerX
        self.frame.origin.y = top
    }
    
    func setFrame(center: UIView, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: width, height: height)
        self.frame.origin.x = (center.width - self.width) / 2
        self.frame.origin.y = (center.height - self.height) / 2
    }
    
    func setFrame(centerX: CGFloat, bottom: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: width, height: height)
        self.centerX = centerX
        self.frame.origin.y = self.superview!.height - self.height - bottom
    }
    
    func setFrame(right: CGFloat, top: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: width, height: height)
        self.frame.origin.x = self.superview!.width - self.width - right
        self.frame.origin.y = top
    }
    
    func setFrame(right: CGFloat, centerY: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: width, height: height)
        self.frame.origin.x = self.superview!.width - self.width - right
        self.centerY = centerY
    }
    
    func setFrame(right: CGFloat, bottom: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: width, height: height)
        self.frame.origin.x = self.superview!.width - self.width - right
        self.frame.origin.y = self.superview!.height - self.height - bottom
    }
    
    
    // 常用其他约束
    func setFrame(left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) {
        self.frame.size.width = self.superview!.width - left - right
        self.frame.size.height = self.superview!.height - top - bottom
        self.frame.origin.x = left
        self.frame.origin.y = top
    }
    
    func setFrame(allEdges: CGFloat) {
        self.frame.size.width = self.superview!.width - allEdges*2
        self.frame.size.height = self.superview!.height - allEdges*2
        self.frame.origin.x = allEdges
        self.frame.origin.y = allEdges
    }
    
    func setFrame(left: CGFloat, top: CGFloat, right: CGFloat, height: CGFloat) {
        self.frame.size.width = self.superview!.width - left - right
        self.frame.size.height = height
        self.frame.origin.x = left
        self.frame.origin.y = top
    }
    
    func setFrame(left: CGFloat, centerY: CGFloat, right: CGFloat, height: CGFloat) {
        self.frame.size.width = self.superview!.width - left - right
        self.frame.size.height = height
        self.frame.origin.x = left
        self.centerY = centerY
    }
    
    func setFrame(left: CGFloat, top: CGFloat, width: CGFloat, bottom: CGFloat) {
        self.frame.origin.x = left
        self.frame.origin.y = top
        self.frame.size.width = width
        self.frame.size.height = self.superview!.height - top - bottom
    }
    
    // 重设
    func resetHeight(height: CGFloat) {
        self.frame.size.height = height
    }
    
    func resetFrame(right: CGFloat) {
        self.frame.origin.x = self.superview!.width - self.width - right
    }
    

}


// 按比例布局
extension UIView {
    func scalingConstraints(left: CGFloat, top: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: s(width), height: s(height))
        self.frame.origin.x = s(left)
        self.frame.origin.y = s(top)
    }

    func scalingConstraints(left: CGFloat, centerY: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: s(width), height: s(height))
        self.frame.origin.x = s(left)
        self.centerY = s(centerY)
    }

    func scalingConstraints(left: CGFloat, bottom: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: s(width), height: s(height))
        self.frame.origin.x = s(left)
        self.frame.origin.y = self.superview!.height - self.height - s(bottom)
    }

    func scalingConstraints(centerX: CGFloat, top: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: s(width), height: s(height))
        self.centerX = s(centerX)
        self.frame.origin.y = s(top)
    }

    func scalingConstraints(center: UIView, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: s(width), height: s(height))
        self.frame.origin.x = (center.width - self.width) / 2
        self.frame.origin.y = (center.height - self.height) / 2
    }

    func scalingConstraints(centerX: CGFloat, bottom: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: s(width), height: s(height))
        self.centerX = s(centerX)
        self.frame.origin.y = self.superview!.height - self.height - s(bottom)
    }

    func scalingConstraints(right: CGFloat, top: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: s(width), height: s(height))
        self.frame.origin.x = self.superview!.width - self.width - s(right)
        self.frame.origin.y = s(top)
    }

    func scalingConstraints(right: CGFloat, centerY: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: s(width), height: s(height))
        self.frame.origin.x = self.superview!.width - self.width - s(right)
        self.centerY = s(centerY)
    }

    func scalingConstraints(right: CGFloat, bottom: CGFloat, width: CGFloat, height:CGFloat) {
        self.frame.size = CGSize(width: s(width), height: s(height))
        self.frame.origin.x = self.superview!.width - self.width - s(right)
        self.frame.origin.y = self.superview!.height - self.height - s(bottom)
    }


    // 常用其他约束
    func scalingConstraints(left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) {
        self.frame.origin.x = s(left)
        self.frame.origin.y = s(top)
        self.frame.size.width = self.superview!.width - s(left) - s(right)
        self.frame.size.height = self.superview!.height - s(top) - s(bottom)
    }

    func scalingConstraints(allEdges: CGFloat) {
        self.frame.origin.x = s(allEdges)
        self.frame.origin.y = s(allEdges)
        self.frame.size.width = self.superview!.width - s(allEdges)*2
        self.frame.size.height = self.superview!.height - s(allEdges)*2
    }

    func scalingConstraints(left: CGFloat, top: CGFloat, right: CGFloat, height: CGFloat) {
        self.frame.origin.x = s(left)
        self.frame.origin.y = s(top)
        self.frame.size.width = self.superview!.width - s(left) - s(right)
        self.frame.size.height = s(height)
    }


}
