//
//  OfferListViewController.swift
//  GoEuro-iOS
//
//  Created by Evgen Dubinin on 10/23/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import UIKit
import GoEuroKit

class OfferListViewController: UITableViewController {

    let offerCellIdentifier = "OfferCellIdentifier"
    let service = OffersService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = .red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

