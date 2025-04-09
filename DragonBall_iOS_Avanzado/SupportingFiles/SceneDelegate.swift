//
//  SceneDelegate.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 6/4/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        let splashViewController = SplashBuilder().build()
        let navigationController = UINavigationController(rootViewController: splashViewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }

}

