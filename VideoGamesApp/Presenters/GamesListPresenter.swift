//
//  GamesListPresenter.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation

protocol GamesListPresenterProtocol: DefaultPresenterProtocol {
    var delegate: GamesListPresenterDelegate? { get set }
    func fetchGames()
}

class GamesListPresenter: DefaultPresenter, GamesListPresenterProtocol {

    var delegate: GamesListPresenterDelegate?

    let gamesListAdapter: GamesListAdapterProtocol

    override init() {
        self.gamesListAdapter = AdapterProvider.getGamesListAdapter
    }

    func fetchGames() {
        self.gamesListAdapter.getGames(onSuccess: { [weak self] response in
            self?.delegate?.onGamesFetched(games: response)
        }, onError: { [weak self] error in
            self?.basePresenterDelegate?.onError(error)
        })
    }

    
}

protocol GamesListPresenterDelegate {
    func onGamesFetched(games: [UIGameEntity])
}
