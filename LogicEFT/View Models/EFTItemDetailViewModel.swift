//
//  EFTItemDetailViewModel.swift
//  LogicEFT
//
//  Created by James Sayer on 7/8/21.
//

import Foundation

class EFTItemDetailViewModel: ObservableObject {
    
    var item: EFTItem
    
    @Published var itemName: String = ""
    @Published var shortName: String = ""
    @Published var price: Int = 0
    @Published var basePrice: Int = 0
    @Published var average24hourPrice: Int = 0
    @Published var average7dayPrice: Int = 0
    @Published var traderName: String
    @Published var traderPrice: Int
    @Published var traderPriceCurrency: String = ""
    @Published var lastUpdated: String = ""
    @Published var diff24hours: Double = 0.0
    @Published var diff7days: Double = 0.0
    @Published var priceString: String = ""
    
    init(item: EFTItem) {
        self.item = item
        self.itemName = item.name
        self.shortName = item.shortName
        self.price = item.price
        self.basePrice = item.basePrice
        self.average24hourPrice = item.avg24hPrice
        self.average7dayPrice = item.avg7daysPrice
        self.traderName = item.traderName
        self.traderPrice = item.traderPrice
        self.traderPriceCurrency = item.traderPriceCur
        self.lastUpdated = item.hoursSinceLastUpdate
        self.diff24hours = item.diff24h
        self.diff7days = item.diff7days
    }
}
