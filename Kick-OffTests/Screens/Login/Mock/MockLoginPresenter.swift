//
//  MockLoginPresenter.swift
//  Kick-OffTests
//
//  Created by Burak Çokyıldırım on 9.03.2022.
//

import XCTest
@testable import Kick_Off

class MockLoginPresenter: BasePresenter {
    var expectation: XCTestExpectation?
    var loginModel: LoginModel?

    override func showNetworkError(with error: NetworkError) {
        print(error.localizedDescription)
    }

    func getLoginModel() -> LoginModel {
        loginModel ?? LoginModel()
    }
}

extension MockLoginPresenter: LoginPresenterInteractorProtocol {
    func successLogin(with model: LoginModel) {
        loginModel = model
        expectation?.fulfill()
    }
}
