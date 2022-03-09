//
//  MockedData.swift
//  Kick-OffTests
//
//  Created by Burak Çokyıldırım on 9.03.2022.
//

import Foundation
@testable import Kick_Off

class MockedData {

    static func login<T: Decodable>(of type: T.Type) -> T? {
        guard let jsonUrl = Bundle(for: MockedData.self).url(forResource: "login_stub", withExtension: "json"),
            let jsonData = try? Data(contentsOf: jsonUrl),
            let model = try? JSONDecoder().decode(T.self, from: jsonData)
        else { return nil }
        return model
    }
}
