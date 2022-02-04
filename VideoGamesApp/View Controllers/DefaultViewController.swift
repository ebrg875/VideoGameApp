//
//  DefaultViewController.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation
import UIKit

public protocol DefaultViewControllerProtocol: BaseViewControllerProtocol {

}

open class DefaultViewController<PresenterType: DefaultPresenterProtocol>: BaseViewController<PresenterType>, DefaultViewControllerProtocol {
    open override func onError(_ error: Error) {
        let alertController = UIAlertController(title: "",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
