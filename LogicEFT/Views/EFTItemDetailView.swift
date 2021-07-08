//
//  EFTItemDetailView.swift
//  LogicEFT
//
//  Created by James Sayer on 7/8/21.
//

import SwiftUI
import Kingfisher

struct EFTItemDetailView: View {
    
    /// The passed in item to construct the view
    let item: EFTItem
    
    let viewModel: EFTItemDetailViewModel
    
    init(item: EFTItem) {
        self.item = item
        self.viewModel = EFTItemDetailViewModel(item: item)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 8) {
                KFImage(item.imgBigURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width / 2, height: geometry.size.width / 2, alignment: .center)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Latest Price: \(viewModel.price)₽")
                    Text(viewModel.lastUpdated)
                    Text("Price Per Slot: \(item.pricePerSlot)")
                    Text("\(item.traderName) Buyback Price: \(item.traderPrice)\(item.traderPriceCur)")
                    Text("Average Price Over Last 24h: \(item.avg24hPrice)")
                    Text("Average Price Over Last 7d: \(item.avg7daysPrice)")
                    Text("Last 24 Hours: \(item.diff24hString)")
                        .foregroundColor(item.diff24hColor)
                    Text("Last 7 Days: \(item.diff7dString)")
                        .foregroundColor(item.diff7dColor)
                }
                
                Spacer()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .navigationTitle(item.shortName)
    }
}

struct EFTItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EFTItemDetailView(item: MockItem)
    }
}
