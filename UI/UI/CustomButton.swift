import UIKit

public class CustomButton: UIButton {
    override public func awakeFromNib() {
        super.awakeFromNib()

        self.setTitleColor(UIColor.blue, for: .normal)
        self.setTitleColor(UIColor.red, for: .disabled)
    }
}
