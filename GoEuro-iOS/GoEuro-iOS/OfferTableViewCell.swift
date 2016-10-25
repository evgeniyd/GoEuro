//
//  OfferTableViewCell.swift
//  GoEuro-iOS
//
//  Created by Evgen Dubinin on 10/25/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import UIKit
import Nuke

final class OfferTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var operatorLogoImageView: UIImageView!
    @IBOutlet weak var stopsLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        durationLabel.textColor = UIColor.goeuroGray
        stopsLabel.textColor = UIColor.goeuroLightgrey
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureWith(_ viewModel: OfferViewModelType) {
        self.priceLabel.text = viewModel.localizedPriceText
        self.durationLabel.text = "\(viewModel.localizedDepartureText!) - \(viewModel.localizedArrivalText!)"
        self.stopsLabel.text = viewModel.localizedStopsText
        Nuke.loadImage(with: viewModel.logoImageURL!, into: self.operatorLogoImageView)
    }
}
