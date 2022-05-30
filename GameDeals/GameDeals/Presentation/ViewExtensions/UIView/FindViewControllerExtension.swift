//
//  FindViewControllerExtension.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation
import UIKit

extension UIView {
    func findViewController<T>() -> T? where T: UIViewController {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder as? T
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
