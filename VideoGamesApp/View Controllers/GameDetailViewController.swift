//
//  GameDetailViewController.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import UIKit
import AlamofireImage

class GameDetailViewController: DefaultViewController<GameDetailPresenter> {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var releasedLabel: UILabel!
    @IBOutlet weak private var ratingLabel: UILabel!
    @IBOutlet weak private var descriptionTextView: UITextView!
    @IBOutlet weak private var imageView: UIImageView!

    public var id: Int?

    var game: UIGameDetailEntity? {
        didSet {
            guard let game = self.game else { return }
            self.nameLabel.text = game.name
            self.releasedLabel.text = game.released
            self.ratingLabel.text = "\(game.metacriticRating)"
            self.descriptionTextView.attributedText = game.description.htmlToAttributedString
            if let imageUrl = URL(string: game.imageUrl) {
                self.imageView.af.setImage(withURL: imageUrl)
            }
        }
    }

    override func initAssociatedPresenter() {
        self.presenter = GameDetailPresenter()
        self.presenter?.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = self.id else { return }
        self.presenter?.fetchGameDetail(id: id)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

extension GameDetailViewController: GameDetailPresenterDelegate {
    func onGameDetailFetched(game: UIGameDetailEntity) {
        self.game = game
    }
}
