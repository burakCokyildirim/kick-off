//
//  LoginModel.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 6.03.2022.
//

import Foundation

struct LoginModel: Decodable {
    var accessToken: String?
    var refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
