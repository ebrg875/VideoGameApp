//
//  FavouritesUserDefaults.swift
//  VideoGameApp
//
//  Created by emeksu.barug on 7.02.2022.
//

import Foundation
import RxSwift

protocol FavouritesUserDefaultsProtocol {
    func getFavourites<T>() -> Single<T> where T: FavouritesDefaultsModel
    func setFavourites<T>(updatedList: T) -> Single<Void> where T: FavouritesDefaultsModel
}

class FavouritesUserDefaults: BaseUserDefaults, FavouritesUserDefaultsProtocol {
    func getFavourites<T>() -> Single<T> where T: FavouritesDefaultsModel {
        return super.retrieve(with: .favourites)
    }

    func setFavourites<T>(updatedList: T) -> Single<Void> where T: FavouritesDefaultsModel {
        return super.store(with: .favourites, value: updatedList)
    }

}
