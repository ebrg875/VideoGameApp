//
//  FavouritesListAdapter.swift
//  VideoGameApp
//
//  Created by emeksu.barug on 7.02.2022.
//

import Foundation
import RxSwift
import Alamofire

protocol FavouritesListAdapterProtocol {
    func getFavourites(onSuccess: @escaping ([UIGameEntity]) -> Void,
                       onError: @escaping (Error) -> Void) -> Disposable

    func addToFavourites(game: UIGameEntity,
                         onSuccess: @escaping () -> Void,
                         onError: @escaping (Error) -> Void) -> Disposable

    func removeFromFavourites(gameId: Int,
                              onSuccess: @escaping () -> Void,
                              onError: @escaping (Error) -> Void) -> Disposable

    func isFavourited(gameId: Int,
                      onSuccess: @escaping (Bool) -> Void,
                      onError: @escaping (Error) -> Void) -> Disposable
}

class FavouritesListAdapter: BaseAdapter, FavouritesListAdapterProtocol {

    let favouritesDefaults: FavouritesUserDefaultsProtocol

    init(favouritesDefaults: FavouritesUserDefaultsProtocol) {
        self.favouritesDefaults = favouritesDefaults
    }

    func getFavourites(onSuccess: @escaping ([UIGameEntity]) -> Void,
                       onError: @escaping (Error) -> Void) -> Disposable {
            return call(single: self.favouritesDefaults.getFavourites(),
                        converter: FavouritesListConverter.createFavouritesList(model:),
                        onSuccess: onSuccess,
                        onError: onError)
    }

    func addToFavourites(game: UIGameEntity,
                         onSuccess: @escaping () -> Void,
                         onError: @escaping (Error) -> Void) -> Disposable {
        let single = self.favouritesDefaults.getFavourites()
        .map { favouritesListModel -> FavouritesDefaultsModel in
            let gameModel = FavouritesListConverter.createGameDefaultsModel(game: game)
            favouritesListModel.favourites.append(gameModel)
            return favouritesListModel
        }.flatMap { favouritesListModel -> Single<Void> in
            self.favouritesDefaults.setFavourites(updatedList: favouritesListModel)
        }

        return call(single: single,
                    converter: { _ in},
                    onSuccess: onSuccess,
                    onError: onError)
    }

    func removeFromFavourites(gameId: Int,
                              onSuccess: @escaping () -> Void,
                              onError: @escaping (Error) -> Void) -> Disposable {
        let single = self.favouritesDefaults.getFavourites()
        .map { favouritesListModel -> FavouritesDefaultsModel in
            favouritesListModel.favourites.removeAll(where: { $0.id == gameId })
            return favouritesListModel
        }.flatMap { favouritesListModel -> Single<Void> in
            self.favouritesDefaults.setFavourites(updatedList: favouritesListModel)
        }

        return call(single: single,
                    converter: { _ in},
                    onSuccess: onSuccess,
                    onError: onError)
    }

    func isFavourited(gameId: Int,
                      onSuccess: @escaping (Bool) -> Void,
                      onError: @escaping (Error) -> Void) -> Disposable {
        let single = self.favouritesDefaults.getFavourites()
            .map { favouritesListModel -> Bool in
                return favouritesListModel.favourites.contains(where: { $0.id == gameId })
            }
            return call(single: single,
                        converter: { isFavourited in return isFavourited },
                        onSuccess: onSuccess,
                        onError: onError)
    }
}


