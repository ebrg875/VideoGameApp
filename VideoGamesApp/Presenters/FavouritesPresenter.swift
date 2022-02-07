//
//  FavouritesPresenter.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 7.02.2022.
//

import Foundation

protocol FavouritesPresenterProtocol: DefaultPresenterProtocol {
    var delegate: FavouritesPresenterDelegate? { get set }
    func getFavourites()
}

class FavouritesPresenter: DefaultPresenter, FavouritesPresenterProtocol {

    var delegate: FavouritesPresenterDelegate?

    let favouritesListAdapter: FavouritesListAdapterProtocol

    override init() {
        self.favouritesListAdapter = AdapterProvider.favouritesListAdapter
    }

    func getFavourites() {
        self.favouritesListAdapter.getFavourites(onSuccess: { [weak self] games in
                                                        self?.delegate?.onFavouriteGamesFetched(games: games)
                                                    },
                                                   onError: { [weak self] error in
                                                        self?.basePresenterDelegate?.onError(error)
                                                    })
    }

}

protocol FavouritesPresenterDelegate {
    func onFavouriteGamesFetched(games: [UIGameEntity])
}
