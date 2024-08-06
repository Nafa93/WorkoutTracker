//
//  SceneDelegate.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 30/07/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let coordinator = HomeCoordinator(navigationController: navigationController)
        coordinator.start()
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()
    }
}
