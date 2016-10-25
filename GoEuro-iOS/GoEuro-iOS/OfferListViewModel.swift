//
//  OfferListViewModel.swift
//  GoEuro-iOS
//
//  Created by Evgen Dubinin on 10/25/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import Foundation

////////////////////////////////////
// MARK: OfferListViewModel
////////////////////////////////////

protocol OfferListViewModelDelegate {
    // signal
    func didUpdateData()
}

protocol OfferListViewModelType {
    // properties
    var delegate: OfferListViewModelDelegate { get set }
    var list: [OfferViewModelType] { get }
    // control
    func fetch()
}

////////////////////////////////////
// MARK: OfferViewModel
////////////////////////////////////

protocol OfferViewModelType {
    // properties
    var localizedPriceText: String? { get }
}

////////////////////////////////////
// MARK: OfferListViewModel Conformance
////////////////////////////////////

import GoEuroKit

final class OfferListViewModel: OfferListViewModelType {
    internal var list: [OfferViewModelType] {
        get {
            return self.offerList ?? []
        }
    }
    internal var delegate: OfferListViewModelDelegate

    private let service = OffersService()
    private var offerList: Optional<OfferList>
    private let backgroundQueue = DispatchQueue(label: "com.goeuro.GoEuro-iOS.offerListViewModel.backgroundQueue", attributes: [DispatchQueue.Attributes.concurrent])
    
    init(delegate: OfferListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetch() {
        backgroundQueue.async { [unowned self] in
            self.service.requestWith { [unowned self] result in
                switch result {
                case .success(let offerList):
                    
                    self.offerList = offerList
                    
                    DispatchQueue.main.async {
                        self.delegate.didUpdateData()
                    }
                    
                case .failure(let serviceError):
                    print("\(serviceError)")
                    
                    // TODO: do a call upon failure
                }
            }
        }
    }
}

extension Offer: OfferViewModelType {
    var localizedPriceText: String? {
        get {
            return self.price.localized()
        }
    }
}

extension Price {
    /// Formats the receiver as a currency string using the specified three digit currencyCode. Currency codes are based on the ISO 4217 standard.
    func localized() -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = self.currency.code
        currencyFormatter.maximumFractionDigits = (floor(self.amount) == self.amount ? 0 : 2)
        return currencyFormatter.string(for: self.amount)
    }
}
