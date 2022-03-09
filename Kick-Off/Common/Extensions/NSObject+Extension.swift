//
//  NSObject+Extension.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 5.03.2022.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last ?? ""
    }

    class var className: String {
        return String(describing: self).components(separatedBy: ".").last ?? ""
    }
}
