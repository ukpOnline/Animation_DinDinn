//
//  SceneDelegate.swift
//  Demo
//
//  Created by Unnikrishnan P on 27/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: UISceneSession Properties

    var window: UIWindow?

    // MARK: UIWindowSceneDelegate Lifecycle

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

}

