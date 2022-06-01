import Foundation
import UIKit
import SFSafeSymbols

extension UIButton {
    static func createIconButton(backgroundIcon: SFSymbol = .cCircle, icon: SFSymbol = .cCircle, backgroundColor: UIColor = .gray, color: UIColor = .white, borderRadius: CGFloat = 20, iconSize: CGFloat = 12, target: Any?, action: Selector?) -> UIButton {
        let button = UIButton.systemButton(with: backgroundIcon, target: target, action: action)
        button.setImage(
            UIImage(
                systemSymbol: icon,
                withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: iconSize))
            ),
            for: .normal)
        button.backgroundColor = backgroundColor
        button.tintColor = color
        button.layer.cornerRadius = borderRadius
        return button
    }
}
