//
//  MainFlowController.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 2.02.2022.
//

import Foundation
import UIKit

final class MainFlowController {

    public static let shared = MainFlowController()
    public var window: UIWindow!

    public var rootNavController: UINavigationController {
        guard let rootNav = self.window.rootViewController as? UINavigationController else {
            preconditionFailure("RootViewController must be set")
        }
        return rootNav
    }

    var mainVCFactory: MainVCFactory! = MainVCFactory()

    public func start() {
        window.rootViewController = self.rootNavController
        window.makeKeyAndVisible()
        window.backgroundColor = UIColor.white
        self.showGamesList()
    }

    private func showGamesList() {
        let tabBarController = self.mainVCFactory.tabbar()
        let gamesList = self.mainVCFactory.gamesList()
        let favourites = self.mainVCFactory.favourites()
        tabBarController.viewControllers = [
            gamesList,
            favourites
        ]

        self.rootNavController.setViewControllers([tabBarController], animated: false)
    }

    public func goToGameDetail(id: Int) {
        let gameDetail = self.mainVCFactory.gameDetail()
        gameDetail.id = id
        self.rootNavController.pushViewController(gameDetail, animated: true)
    }
}

class MainVCFactory {
    public func tabbar() -> UITabBarController{
        return StoryboardFactory.main.instantiate(MainTabBarController.self)
    }

    public func gamesList() -> UIViewController {
        return StoryboardFactory.gamesList.instantiateInitial()
    }

    public func gameDetail() -> GameDetailViewController {
        return StoryboardFactory.gameDetail.instantiateInitial(GameDetailViewController.self)
    }

    public func favourites() -> UIViewController {
        return StoryboardFactory.favourites.instantiateInitial()
    }
}
