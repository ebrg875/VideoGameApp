//
//  GameDetailViewController.swift
//  VideoGameApp
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
    @IBOutlet weak private var favouriteButton: UIButton!

    public var id: Int?

    private var isFavourited: Bool = false

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
        self.presenter?.fetchIsFavourited(id: id)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBAction func onFavouriteButtonTapped(_ sender: Any) {
        self.toggleFavourite()
    }

    private func toggleFavourite() {
        guard let game = self.game else { return }
        if self.isFavourited {
            self.presenter?.removeFromFavourites(id: game.id)
        } else {
            self.presenter?.addToFavourites(game: game)
        }
    }

}

extension GameDetailViewController: GameDetailPresenterDelegate {
    func onisFavouritedFetched(isFavourited: Bool) {
        self.isFavourited = isFavourited
        let image = isFavourited ? UIImage(named: "hand.thumbsup.fill") : UIImage(named: "hand.thumbsup")
        self.favouriteButton.setImage(image, for: .normal)
    }

    func onGameFavourited() {
        self.isFavourited = true
        self.favouriteButton.setImage(UIImage(named: "hand.thumbsup.fill"), for: .normal)
    }

    func onGameUnfavourited() {
        self.isFavourited = false
        self.favouriteButton.setImage(UIImage(named: "hand.thumbsup"), for: .normal)
    }

    func onGameDetailFetched(game: UIGameDetailEntity) {
        self.game = game
    }
}
