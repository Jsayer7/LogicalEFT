//
//  EFTItem.swift
//  LogicEFT
//
//  Created by James Sayer on 7/8/21.
//

import Foundation
import SwiftUI

struct EFTItem: Decodable, Identifiable {
    /// The self generated id property to conform to Identifiable
    let id = UUID()
    /// The UID of the item
    let uid: String
    /// The full name of the item
    let name: String
    /// The short name of the item
    let shortName: String
    /// The latest price of the item
    let price: Int
    /// The base price of the item
    let basePrice: Int
    /// The average price of the item over the last 24 hours
    let avg24hPrice: Int
    /// The average price of the item over the last 7 days
    let avg7daysPrice: Int
    /// The trader name associated with the item
    let traderName: String
    /// The price that the trader would pay you for the item
    let traderPrice: Int
    /// The currency that the trader uses
    let traderPriceCur: String
    /// The last time the data was updated (in ISO8601 string format)
    let updated: String
    /// The number of slots the item takes
    let slots: Int
    /// The difference in price over the last 24 hours
    let diff24h: Double
    /// The difference in price over the last 7 days
    let diff7days: Double
    /// The url string of the item icon
    let icon: String
    /// The url string of the item's webpage
    let link: String
    /// The url string of the item's wiki webpage
    let wikiLink: String
    /// The url string of the item's image
    let img: String
    /// The url string of the item's large image icon
    let imgBig: String
    /// The Battlestate Games ID of the item
    let bsgId: String
    /// Boolean value of if the item is functional
    let isFunctional: Bool
    /// The url string of the reference
    let reference: String
    
    /// The URL of the item icon
    var iconURL: URL? {
        return URL(string: icon)
    }
    
    /// The URL of the item image
    var imgURL: URL? {
        return URL(string: img)
    }
    
    /// The URL of the item's large image
    var imgBigURL: URL? {
        return URL(string: imgBig)
    }
    
    /// The last time the data was updated (in Date format)
    var lastUpdatedDate: Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return dateFormatter.date(from: updated)
    }
    
    /// String that describes the last time the data was updated
    var hoursSinceLastUpdate: String {
        let now = Date()
        guard let lastUpdate = lastUpdatedDate else {
            return "Last Update: Unknown"
        }
        
        let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: lastUpdate, to: now)
        let hours = diffComponents.hour ?? 0
        let minutes = diffComponents.minute ?? 0
        let hourString = hours > 1 ? "hours" : "hour"
        
        if hours == 0 {
            return "Last Updated: \(minutes) minutes ago"
        } else {
            return "Last Updated: \(hours) \(hourString) ago"
        }
    }
    
    /// The price per slot of the item
    var pricePerSlot: Double {
        return Double(price / slots).rounded()
    }
    
    /// The formatted string of price movement in % over the last 24 hours
    var diff24hString: String {
        return String(format: "%.2f", diff24h).appending("%")
    }
    
    /// The formatted string of price movement in % over the last 7 days
    var diff7dString: String {
        return String(format: "%.2f", diff7days).appending("%")
    }
    
    /// The color of the price movement over the last 24 hours. Green if +, red if -
    var diff24hColor: Color {
        return diff24h >= 0.0 ? .green : .red
    }
    
    /// The color of the price movement over the last 7 days. Green if +, red if -
    var diff7dColor: Color {
        return diff7days >= 0.0 ? .green : .red
    }
}
