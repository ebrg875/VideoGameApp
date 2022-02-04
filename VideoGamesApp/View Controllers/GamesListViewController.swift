//
//  GamesListViewController.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 2.02.2022.
//

import UIKit

class GamesListViewController: DefaultViewController<GamesListPresenter> {

    @IBOutlet weak private var topGamesContainer: UIView!
    @IBOutlet weak private var pageControl: UIPageControl!
    @IBOutlet weak private var gamesCollectionView: UICollectionView!

    @IBOutlet weak private var gamesCVTopToSafeAreaTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var gamesCVTopToPageControlBottomConstraint: NSLayoutConstraint!

    let searchController = UISearchController(searchResultsController: nil)

    var topGamesPageController: TopGamesViewController!

    private var games: [UIGameEntity]?
    private var filteredGames: [UIGameEntity]?

    private var isSearchTextValid: Bool {
      guard let charCount = searchController.searchBar.text?.count,
            charCount > 2 else { return false }
        return true
    }

    private var isFiltering: Bool {
        return searchController.isActive && isSearchTextValid
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        self.setupCollectionView()
        self.presenter?.fetchGames()
    }

    override func initAssociatedPresenter() {
        self.presenter = GamesListPresenter()
        presenter?.delegate = self
    }

    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Games"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        self.navigationItem.titleView = self.searchController.searchBar
        self.searchController.hidesNavigationBarDuringPresentation = false
    }

    private func setupCollectionView() {
        self.gamesCollectionView.delegate = self
        self.gamesCollectionView.dataSource = self
        self.gamesCollectionView.register(UINib(nibName: "GamesCollectionViewCell", bundle: nil),
                                          forCellWithReuseIdentifier: "GamesCollectionViewCell")
        self.gamesCollectionView.allowsSelection = false    }

    private func setupPageController() {
        guard let pageController = self.children.first as? TopGamesViewController else {
            return
        }

        self.topGamesPageController = pageController
        self.topGamesPageController.delegate = self

        guard let topGames = self.games?[0...2] else { return }
        let topGameVCs = topGames.enumerated().map { (index, game) -> TopGamesChildViewController in
            let vc = TopGamesChildViewController(nibName: "TopGamesChildViewController",
                                                 bundle: Bundle.main,
                                                 imageSource: game.imageUrl,
                                                 index: index)
            vc.delegate = self
            return vc
        }

        pageController.orderedViewControllers = topGameVCs
        pageController.loadViewControllers()
    }


    private func filterGames(with text: String) {
        self.filteredGames = games?.filter { game in
            return game.name.contains(text)
        }
        self.updateUI(shouldHideTopView: true)
    }

    private func showAllGames() {
        self.updateUI(shouldHideTopView: false)
    }

    private func updateUI(shouldHideTopView isHidden: Bool) {
        self.pageControl.isHidden = isHidden
        self.topGamesContainer.isHidden = isHidden
        self.gamesCVTopToSafeAreaTopConstraint.isActive = isHidden
        self.gamesCVTopToPageControlBottomConstraint.isActive = !isHidden
        self.gamesCollectionView.reloadData()
    }
}

extension GamesListViewController: GamesListPresenterDelegate {
    func onGamesFetched(games: [UIGameEntity]) {
        self.games = games
        self.setupPageController()
        self.gamesCollectionView.reloadData()
    }
}


extension GamesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = self.searchController.searchBar.text,
              self.isSearchTextValid else { return self.showAllGames() }
        self.filterGames(with: text)
    }
}

extension GamesListViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = topGamesPageController.viewControllers?.first,
                let index = topGamesPageController!.orderedViewControllers.firstIndex(of: currentViewController) {
                pageControl.currentPage = index
            }
        }
    }
}

extension GamesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.isFiltering ? self.filteredGames?.count ?? 0 : self.games?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.gamesCollectionView.bounds.size.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.gamesCollectionView.dequeueReusableCell(withReuseIdentifier: "GamesCollectionViewCell",
                                                                      for: indexPath) as? GamesCollectionViewCell else {
            return GamesCollectionViewCell()
        }
        let game = self.isFiltering ? self.filteredGames?[indexPath.row] : self.games?[indexPath.row]
        cell.game = game
        cell.delegate = self
        return cell
    }
}

extension GamesListViewController: GamesCollectionViewCellDelegate {
    func onCellTapped(id: Int) {
        MainFlowController.shared.goToGameDetail(id: id)
    }
}

extension GamesListViewController: TopGamesChildViewControllerDelegate {
    func onTapped(index: Int) {
        guard let id = self.games?[index].id else { return }
        MainFlowController.shared.goToGameDetail(id: id)
    }
}
