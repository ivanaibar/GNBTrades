//
//  SceneDelegate.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 03/11/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        AppNavigator(window: window!)
    }

}

