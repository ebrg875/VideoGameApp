//
//  GameDetailPresenter.swift
//  VideoGameApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation

protocol GameDetailPresenterProtocol: DefaultPresenterProtocol {
    var delegate: GameDetailPresenterDelegate? { get set }
    func fetchGameDetail(id: Int)
    func fetchIsFavourited(id: Int)
    func addToFavourites(game: UIGameDetailEntity)
    func removeFromFavourites(id: Int)
}

class GameDetailPresenter: DefaultPresenter, GameDetailPresenterProtocol {

    var delegate: GameDetailPresenterDelegate?

    let gameDetailAdapter: GameDetailAdapterProtocol
    let favouritesListAdapter: FavouritesListAdapterProtocol

    override init() {
        self.gameDetailAdapter = AdapterProvider.getGameDetailAdapter
        self.favouritesListAdapter = AdapterProvider.favouritesListAdapter
    }

    func fetchGameDetail(id: Int) {
        self.gameDetailAdapter.getGameDetail(gameId: id,
                                             onSuccess: { [weak self] response in
                                                self?.delegate?.onGameDetailFetched(game: response)
                                             }, onError: { [weak self] error in
                                                self?.basePresenterDelegate?.onError(error)
                                             })
    }

    func fetchIsFavourited(id: Int) {
        self.favouritesListAdapter.isFavourited(gameId: id,
                                             onSuccess: { [weak self] response in
                                                self?.delegate?.onisFavouritedFetched(isFavourited: response)
                                             }, onError: { [weak self] error in
                                                self?.basePresenterDelegate?.onError(error)
                                             })
    }

    func addToFavourites(game: UIGameDetailEntity) {
        let gameReq = UIGameEntity(id: game.id,
                                   name: game.name,
                                   imageUrl: game.imageUrl,
                                   rating: Double(game.metacriticRating),
                                   released: game.released)
        self.favouritesListAdapter.addToFavourites(game: gameReq,
                                                   onSuccess: { [weak self] in
                                                        self?.delegate?.onGameFavourited()
                                                    },
                                                   onError: { [weak self] error in
                                                        self?.basePresenterDelegate?.onError(error)
                                                    })
    }

    func removeFromFavourites(id: Int) {
        self.favouritesListAdapter.removeFromFavourites(gameId: id,
                                                   onSuccess: { [weak self] in
                                                        self?.delegate?.onGameUnfavourited()
                                                    },
                                                   onError: { [weak self] error in
                                                        self?.basePresenterDelegate?.onError(error)
                                                    })
    }

}

protocol GameDetailPresenterDelegate {
    func onGameDetailFetched(game: UIGameDetailEntity)
    func onGameFavourited()
    func onGameUnfavourited()
    func onisFavouritedFetched(isFavourited: Bool)
}
