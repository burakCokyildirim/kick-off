//
//  LoginInteractorTests.swift
//  Kick-OffTests
//
//  Created by Burak Çokyıldırım on 9.03.2022.
//

import XCTest
@testable import Kick_Off

class LoginInteractorTests: XCTestCase {
    var loginInteractor: LoginInteractorProtocol!
    let networkService = MockNetworkService()
    let loginPresenter = MockLoginPresenter()

    override func setUp() {
        super.setUp()

        let loginInteractor = LoginInteractor(networkService: networkService)
        loginInteractor.presenter = loginPresenter

        self.loginInteractor = loginInteractor
    }

    override func tearDown() {
        loginInteractor = nil
        networkService.currentError = nil
        super.tearDown()
    }

    func testLogin() {
        let exp = expectation(description: #function)

        loginPresenter.expectation = exp
        loginInteractor.login(username: "", password: "")

        wait(for: [exp], timeout: 3.0)

        let loginModel = loginPresenter.getLoginModel()
        XCTAssertFalse(loginModel.accessToken.isEmptyOrNil)
    }
}
