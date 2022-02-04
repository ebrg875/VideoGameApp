//
//  TopGamesChildViewController.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import UIKit

class TopGamesChildViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    var index: Int
    var imageSource: String
    var delegate: TopGamesChildViewControllerDelegate?

    init(nibName: String?, bundle: Bundle?, imageSource: String, index: Int) {
        self.imageSource = imageSource
        self.index = index

        super.init(nibName: nibName, bundle: bundle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillLayoutSubviews() {
        self.imageView.frame = self.view.bounds
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
        guard let imageUrl = URL(string: self.imageSource) else { return }
        self.imageView.af.setImage(withURL: imageUrl)
    }

    @objc func tapped() {
        self.delegate?.onTapped(index: self.index)
    }
}

protocol TopGamesChildViewControllerDelegate: AnyObject {
    func onTapped(index: Int)
}
