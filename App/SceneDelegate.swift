//
//  SceneDelegate.swift
//  App
//
//

import GlobalUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        Theme.setup()
        let window = UIWindow(windowScene: windowScene)
        ListViewCoordinator().start(window: window)
        self.window = window
        window.makeKeyAndVisible()
    }
}

