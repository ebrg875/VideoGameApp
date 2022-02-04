//
//  GamesCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var infoLabel: UILabel!
    @IBOutlet weak private var imageView: UIImageView!

    var game: UIGameEntity? {
        didSet {
            guard let game = self.game else { return }
            self.nameLabel.text = game.name
            self.infoLabel.text = "\(game.released) - \(game.rating)"
            if let imageUrl = URL(string: game.imageUrl) {
                self.imageView.af.setImage(withURL: imageUrl)
            }
        }
    }

    var delegate: GamesCollectionViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped)))
    }

    @objc func cellTapped() {
        guard let gameId =  self.game?.id else { return }
        self.delegate?.onCellTapped(id: gameId)
    }
}

protocol GamesCollectionViewCellDelegate: AnyObject {
    func onCellTapped(id: Int)
}
