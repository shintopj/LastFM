//
//  RootRouter.swift
//  LastFM
//
//  Created by Shinto Joseph on 29/07/2021.
//

import UIKit

class RootRouter {
    
    var window: UIWindow
    private var windowScene: UIWindowScene
    private var rootNavigation: UINavigationController?
    
    init(scene: UIWindowScene) {
        windowScene = scene
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
    }
    
    func initalizeApp() {
        window.rootViewController = initalView()
        window.makeKeyAndVisible()
    }
    
    private func initalView() -> UINavigationController {
        
        let vc = AlbumListConfigurator.create()
        
        let navController = UINavigationController(rootViewController: vc)
        rootNavigation = navController
        
        return navController
    }    
}
