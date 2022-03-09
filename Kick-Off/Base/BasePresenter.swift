//
//  BasePresenter.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 5.03.2022.
//
//  Template generated by Burak Cokyildirim
//

import Foundation

class BasePresenter {
    func showNetworkError(with error: NetworkError) {
        fatalError("You need to override this method.")
    }
}

// MARK: View Protocol
extension BasePresenter: BasePresenterViewProtocol {
}

// MARK: Interactor Protocol
extension BasePresenter: BasePresenterInteractorProtocol {
}
