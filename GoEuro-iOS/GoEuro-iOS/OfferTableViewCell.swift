//
//  OfferTableViewCell.swift
//  GoEuro-iOS
//
//  Created by Evgen Dubinin on 10/25/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import UIKit

final class OfferTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureWith(_ viewModel: OfferViewModelType) {
        self.priceLabel.text = viewModel.localizedPriceText
    }
}
