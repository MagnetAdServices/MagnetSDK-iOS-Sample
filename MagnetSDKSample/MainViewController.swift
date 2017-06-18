//
//  ViewController.swift
//  MagnetSDKSample
//
//  Created by Saeed on 11/26/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? UIButton {
            segue.destination.title = button.currentTitle!
        }
    }
}

extension UINavigationController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        if let ctrl = topViewController {
            return ctrl.supportedInterfaceOrientations
        }
        return super.supportedInterfaceOrientations
    }
}

extension UIView {
    func animate() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: { _ in
            UIView.animate(withDuration: 0.05, animations: {
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: { _ in
                UIView.animate(withDuration: 0.05) {
                    self.transform = CGAffineTransform.identity
                }
            })
        })
    }
}

extension UIButton {
    var isEnable: Bool {
        set {
            DispatchQueue.main.async {
                self.isEnabled = newValue
                if newValue { self.animate() }
            }
        }
        get { return self.isEnabled }
    }
}

extension Date {
    var now: String {
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yy H:mm:ss"
        return format.string(from: self)
    }
}
