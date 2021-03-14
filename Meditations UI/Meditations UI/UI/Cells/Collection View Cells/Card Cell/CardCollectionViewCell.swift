//
//  CardCollectionViewCell.swift
//  Meditations_UI
//
//  Created by Emrah Akgül on 13.03.2021.
//

import UIKit
import Kingfisher

private extension CardCollectionViewCell {
    enum Constants {
        static let cornerRadius: CGFloat = 8.0
    }
}

public class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var cardImageView: UIImageView!
    @IBOutlet private weak var cardTitleLabel: UILabel!
    @IBOutlet private weak var cardDetailLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        cardImageView.layer.cornerRadius = Constants.cornerRadius
    }
    
    public func setupUI(presentation: CardCollectionViewCellPresentation?) {
        cardTitleLabel.text = presentation?.title
        cardDetailLabel.text = presentation?.detail
        cardImageView.image = nil
                
        guard let image = presentation?.smallImage, let imageURL = URL(string: image) else {
            cardImageView.image = nil
            return
        }
        
        cardImageView.kf.setImage(with: imageURL)
    }

}
