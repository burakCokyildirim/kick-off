//
//  UIStoryboard+Extension.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 5.03.2022.
//

import UIKit

extension UIStoryboard {
    static var Main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    func instantiateViewController<VC: UIViewController>() -> VC {
        guard let viewController = self.instantiateViewController(withIdentifier: VC.className) as? VC
        else { fatalError("could not instantiateViewController with identifier \(VC.className)") }
        return viewController
    }
}
