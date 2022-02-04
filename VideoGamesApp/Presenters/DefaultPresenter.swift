//
//  DefaultPresenter.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation

public protocol DefaultPresenterProtocol: BasePresenterProtocol {

}

open class DefaultPresenter: BasePresenter, DefaultPresenterProtocol {

    deinit {
        //* dispose observables here using the presenter's tag
    }

}
