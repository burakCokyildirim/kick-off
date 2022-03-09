//
//  Collection+Extension.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 5.03.2022.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isEmptyOrNil: Bool {
        self?.isEmpty ?? true
    }

    var required: Wrapped {
        self!
    }
}
