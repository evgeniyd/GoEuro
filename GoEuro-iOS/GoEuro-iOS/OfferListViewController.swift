//
//  OfferListViewController.swift
//  GoEuro-iOS
//
//  Created by Evgen Dubinin on 10/23/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import UIKit

final class OfferListViewController: UITableViewController, OfferListViewModelDelegate {

    // MARK: Properties
    
    private let offerCellIdentifier = "OfferCellIdentifier"
    private var viewModel: OfferListViewModelType?
    
    ////////////////////////////////////
    // MARK: TBVC lifecycle -
    ////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.viewModel = OfferListViewModel(delegate: self)
        self.viewModel!.fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ////////////////////////////////////
    // MARK: OfferListViewModelDelegate -
    ////////////////////////////////////
    
    func didUpdateData() {
        print("didUpdateData")
        
        tableView.reloadData()
    }
    
    ////////////////////////////////////
    // MARK: UITableViewDataSource -
    ////////////////////////////////////
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel!.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: offerCellIdentifier, for: indexPath) as? OfferTableViewCell else {
            fatalError("Misconfigured cell type!")
        }
        
        // Configure the cell...
        let offerModelView = self.viewModel!.list[indexPath.row]
        cell.configureWith(offerModelView)
        
        return cell
    }
}


