//
//  SceneDelegate.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        let list = iOSTodosListFactory().makeViewController()
        
        window?.rootViewController = UINavigationController(rootViewController: list)
        window?.makeKeyAndVisible()
    }

}
