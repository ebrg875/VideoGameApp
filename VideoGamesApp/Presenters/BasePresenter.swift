//
//  BasePresenter.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation

public protocol BasePresenterProtocol {

    var basePresenterDelegate: BasePresenterDelegate? {get set}

    func onLoad()

    func onWillAppear()

    func onDidAppear()

    func onWillDisappear()

    func onDidDisappear()

    func onWillEnterForeground()
}

open class BasePresenter: BasePresenterProtocol {

    public weak var basePresenterDelegate: BasePresenterDelegate?

    open var TAG:String{
        return String(describing: self)
    }

    public func onLoad() {

    }

    public func onWillAppear() {

    }

    public func onDidAppear() {

    }

    public func onWillDisappear() {

    }

    public func onDidDisappear() {

    }

    public func onWillEnterForeground() {

    }
}

public protocol BasePresenterDelegate:class {
    func onError(_ error:Error)
}
