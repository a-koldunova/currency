import UIKit

extension UIView {
    
    func setViewShadow() {
        self.layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.bounds = self.bounds
        layer.position = self.center
    }
}
