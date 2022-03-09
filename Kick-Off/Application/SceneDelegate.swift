//
//  SceneDelegate.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 5.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.windowScene = windowScene

        if UserDefaults.standard.accessToken.isEmptyOrNil {
            LoginWireframe().show(transitionType: .root(window: window))
        } else {
            HomeWireframe().show(transitionType: .root(window: window))
        }
    }
}

