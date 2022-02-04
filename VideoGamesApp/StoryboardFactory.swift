//
//  StoryboardFactory.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 2.02.2022.
//

import UIKit

public enum StoryboardFactory: String {
    case main = "Main"
    case gamesList = "GamesList"
    case favourites = "Favourites"
    case gameDetail = "GameDetail"


    public func storyboard(bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: bundle)
    }

    public func instantiateInitial<VC: UIViewController>(_ viewController: VC.Type=VC.self, inBundle bundle: Bundle? = nil) -> VC {
        let storyboard = self.storyboard(bundle: bundle)

        guard let viewController = storyboard.instantiateInitialViewController() as? VC else {
            fatalError("Couldn't instantiate \(String(describing: VC.self)) from \(self.rawValue)")
        }
        return viewController
    }

    public func instantiate<VC: UIViewController>(_ viewController: VC.Type=VC.self, inBundle bundle: Bundle? = nil) -> VC {
        let storyboard = self.storyboard(bundle: bundle)

        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: VC.self)) as? VC else {
            fatalError("Couldn't instantiate \(String(describing: VC.self)) from \(self.rawValue)")
        }
        return viewController
    }
}
