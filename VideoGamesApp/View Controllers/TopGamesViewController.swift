//
//  TopGamesViewController.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 2.02.2022.
//

import UIKit

class TopGamesViewController: UIPageViewController {
    var currentIndex: Int = 0
    lazy var orderedViewControllers =  [UIViewController]()

    // MARK: - Load Controller
    func loadViewController(viewController: UIViewController) {
        if(orderedViewControllers.contains(viewController)) {
            setViewControllers([viewController], direction: .forward, animated: false, completion: nil)
        }    }

    func loadViewControllers() {
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: false, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.view.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension TopGamesViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        currentIndex = previousIndex
        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        guard orderedViewControllersCount != nextIndex else {
            return nil
        }

        guard orderedViewControllersCount > nextIndex else {
            return nil
        }

        currentIndex = nextIndex
        return orderedViewControllers[nextIndex]
    }
}
