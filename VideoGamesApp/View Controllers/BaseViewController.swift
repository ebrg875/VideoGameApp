//
//  BaseViewController.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation
import UIKit

public protocol BaseViewControllerProtocol {
    associatedtype PresenterType

    var presenter : PresenterType? {get set}

    func initAssociatedPresenter()

}

open class BaseViewController<PresenterType: BasePresenterProtocol> : UIViewController, BaseViewControllerProtocol, BasePresenterDelegate {

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initAssociatedPresenter()
        self.presenter?.basePresenterDelegate = self
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initAssociatedPresenter()
        self.presenter?.basePresenterDelegate = self
    }

    public var presenter : PresenterType?

    open func initAssociatedPresenter() {

    }

    open func onError(_ error: Error) {

    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.onLoad()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.onWillAppear()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter?.onDidAppear()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter?.onWillDisappear()
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter?.onDidDisappear()
    }
}

public protocol BaseViewControllerDelegate: AnyObject {

}
