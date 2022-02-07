//
//  FavouritesViewController.swift
//  VideoGameApp
//
//  Created by emeksu.barug on 2.02.2022.
//

import UIKit

class FavouritesViewController: DefaultViewController<FavouritesPresenter> {

    @IBOutlet weak private var favouritesCollectionView: UICollectionView!

    private var favouritesGames: [UIGameEntity]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.getFavourites()
    }

    override func initAssociatedPresenter() {
        self.presenter = FavouritesPresenter()
        presenter?.delegate = self
    }

    private func setupCollectionView() {
        self.favouritesCollectionView.delegate = self
        self.favouritesCollectionView.dataSource = self
        self.favouritesCollectionView.register(UINib(nibName: "GamesCollectionViewCell", bundle: nil),
                                          forCellWithReuseIdentifier: "GamesCollectionViewCell")
        self.favouritesCollectionView.allowsSelection = false
    }

}

extension FavouritesViewController: FavouritesPresenterDelegate {
    func onFavouriteGamesFetched(games: [UIGameEntity]) {
        self.favouritesGames = games
        self.favouritesCollectionView.reloadData()
    }

}

extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favouritesGames?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.favouritesCollectionView.bounds.size.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.favouritesCollectionView.dequeueReusableCell(withReuseIdentifier: "GamesCollectionViewCell",
                                                                      for: indexPath) as? GamesCollectionViewCell else {
            return GamesCollectionViewCell()
        }
        let game = self.favouritesGames?[indexPath.row]
        cell.game = game
        cell.delegate = self
        return cell
    }
}

extension FavouritesViewController: GamesCollectionViewCellDelegate {
    func onCellTapped(id: Int) {
        MainFlowController.shared.goToGameDetail(id: id)
    }
}

