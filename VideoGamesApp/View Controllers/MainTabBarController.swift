//
//  MainTabBarController.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 2.02.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}
