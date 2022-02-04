//
//  GameDetailPresenter.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation

protocol GameDetailPresenterProtocol: DefaultPresenterProtocol {
    var delegate: GameDetailPresenterDelegate? { get set }
    func fetchGameDetail(id: Int)
}

class GameDetailPresenter: DefaultPresenter, GameDetailPresenterProtocol {

    var delegate: GameDetailPresenterDelegate?

    let gameDetailAdapter: GameDetailAdapterProtocol

    override init() {
        self.gameDetailAdapter = AdapterProvider.getGameDetailAdapter
    }

    func fetchGameDetail(id: Int) {
        self.gameDetailAdapter.getGameDetail(gameId: id,
                                             onSuccess: { [weak self] response in
                                                self?.delegate?.onGameDetailFetched(game: response)
                                             }, onError: { [weak self] error in
                                                self?.basePresenterDelegate?.onError(error)
                                             })
    }


}

protocol GameDetailPresenterDelegate {
    func onGameDetailFetched(game: UIGameDetailEntity)
}
