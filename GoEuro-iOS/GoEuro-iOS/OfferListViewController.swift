//
//  OfferListViewController.swift
//  GoEuro-iOS
//
//  Created by Evgen Dubinin on 10/23/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import UIKit

final class OfferListViewController: UITableViewController, OfferListViewModelDelegate, ViewControllerAppearanceCustomizable {

    // MARK: Properties
    
    private let offerCellIdentifier = "OfferCellIdentifier"
    private var viewModel: OfferListViewModelType?
    
    ////////////////////////////////////
    // MARK: TBVC lifecycle -
    ////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "OrderByDateButton"), style: .plain, target: self, action: #selector(didSwitchFilterByDate))
        navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 20.0)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Trans", style: .plain, target: self, action: #selector(didSwitchTransportationType))
        
        self.title = "Berlin → London"
        
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
        tableView.reloadData()
    }
    
    func didFailWith( _ localizedErrorText: String?) {
        print("didFailWith: \(localizedErrorText)")
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
    
    ////////////////////////////////////
    // MARK: UITableViewDelegate -
    ////////////////////////////////////
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        temp_presentNotYetSupporteAlert()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    ////////////////////////////////////
    // MARK: Layout -
    ////////////////////////////////////
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        applyCustom(DefaultViewControllerAppearance())
    }
    
    ////////////////////////////////////
    // MARK: Actions -
    ////////////////////////////////////
    
    @objc func didSwitchFilterByDate() {
        self.viewModel!.toggleOrderByDate()
    }
    
    @objc func didSwitchTransportationType() {
        print("")
    }
    
    ////////////////////////////////////
    // MARK: Alerts -
    ////////////////////////////////////
    
    private func temp_presentNotYetSupporteAlert() {
        let alertController = UIAlertController(title: "Sorry...", message: "Offer details are not yet implemented!", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "I Understand...", style: .default)
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    ////////////////////////////////////
    // MARK: Status Bar Style -
    ////////////////////////////////////
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


