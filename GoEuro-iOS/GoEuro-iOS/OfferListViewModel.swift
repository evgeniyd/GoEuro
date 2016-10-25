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
    func didFailWith( _ localizedErrorText: String?)
}

protocol OfferListViewModelType {
    // properties
    var delegate: OfferListViewModelDelegate { get set }
    var list: [OfferViewModelType] { get }
    // control
    func fetch()
    func toggleOrderByDate()
}

////////////////////////////////////
// MARK: OfferViewModel
////////////////////////////////////

protocol OfferViewModelType {
    // properties
    var localizedPriceText: String? { get }
    var localizedDepartureText: String? { get }
    var localizedArrivalText: String? { get }
    var localizedStopsText: String? { get }
    var logoImageURL: URL? { get }
}

////////////////////////////////////
// MARK: OfferListViewModel Conformance
////////////////////////////////////

import GoEuroKit

final class OfferListViewModel: OfferListViewModelType {
    internal var list: [OfferViewModelType] {
        get {
            guard let ol = self.offerList else {
                return []
            }
            
            return ol.sorted(by: { [unowned self] (o1, o2) -> Bool in
                
                return self.isAscendingOrder
                    ? o1.departure > o2.departure // descending
                    : o1.departure < o2.departure // ascending
            })
        }
    }
    internal var delegate: OfferListViewModelDelegate

    private let service = OffersService()
    private var offerList: Optional<OfferList>
    private let backgroundQueue = DispatchQueue(label: "com.goeuro.GoEuro-iOS.offerListViewModel.backgroundQueue", attributes: [DispatchQueue.Attributes.concurrent])
    private var isAscendingOrder = false
    
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
                    
                    DispatchQueue.main.async {
                        self.delegate.didFailWith( serviceError.localizedDescription )
                    }
                }
            }
        }
    }
    
    func toggleOrderByDate() {
        isAscendingOrder = !isAscendingOrder
        self.delegate.didUpdateData()
    }
}

extension Offer: OfferViewModelType {
    var localizedPriceText: String? {
        return self.price.localized()
    }
    
    var localizedDepartureText: String? {
        return timeFrom(self.departure)
    }
    
    var localizedArrivalText: String? {
        return timeFrom(self.arrival)
    }
    
    var logoImageURL: URL? {
        return self.logo.url
    }
    
    var localizedStopsText: String? {
        return "\(self.stops) stop\(self.stops == 1 ? "" : "s")" // TODO: this is not a localized format
    }
    
    // TODO: move to StringUtils....swift
    private static let dateFormatter = DateFormatter()
    private func timeFrom(_ date: Date) -> String {
        Offer.dateFormatter.dateStyle = .none
        Offer.dateFormatter.timeStyle = .short
        Offer.dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        Offer.dateFormatter.locale = Locale.autoupdatingCurrent
        return Offer.dateFormatter.string(from: date)
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
