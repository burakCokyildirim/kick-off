//
//  HomePresenter.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 7.03.2022.
//
//  Template generated by Burak Cokyildirim
//

import Foundation

class HomePresenter: BasePresenter {
    
    // MARK: - Dependencies
    fileprivate var viewController: HomeViewControllerProtocol!
    fileprivate var interactor: HomeInteractorProtocol!
    fileprivate var delegate: HomePresenterDelegateProtocol?

    // MARK: - Properties
    let userDefaults = UserDefaults.standard
    var allContents: [ContentsModel.Content] = []
    
    // MARK: - Initialization
    init(viewController: HomeViewControllerProtocol, interactor: HomeInteractorProtocol, delegate: HomePresenterDelegateProtocol?, extras: Any?) {
        self.viewController = viewController
        self.interactor = interactor
        self.delegate = delegate
    }

    override func showNetworkError(with error: NetworkError) {
        viewController.hideLoading()
        viewController.showAlert(with: error.localizedDescription)
    }
}

// MARK: View Protocol
extension HomePresenter: HomePresenterViewProtocol {
    func logout() {
        userDefaults.accessToken = nil
        userDefaults.refreshToken = nil
        LoginWireframe().show(transitionType: .root())
    }

    func fetchContents() {
        viewController.showLoading()
        interactor.fetchContents()
    }

    func numberOfRowsInSection() -> Int {
        allContents.count
    }

    func content(of index: Int) -> ContentsModel.Content {
        allContents[index]
    }
}

// MARK: Interactor Protocol
extension HomePresenter: HomePresenterInteractorProtocol {
    func loadContents(with model: ContentsModel) {
        viewController.hideLoading()
        guard let allContents = model.allContents else { return }
        self.allContents = allContents
        viewController.updateView()
    }
}

// MARK: Delegate Protocol
