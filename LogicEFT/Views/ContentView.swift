//
//  ContentView.swift
//  LogicEFT
//
//  Created by James Sayer on 7/8/21.
//

import SwiftUI

struct ContentView: View {
    
    /// The view model
    @ObservedObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                SearchBar(query: $viewModel.searchQuery)
                if viewModel.items.isEmpty {
                    Spacer()
                    
                    Text("Enter Search Term Above")
                } else {
                    List(viewModel.items) { item in
                        EFTItemRow(item: item)
                    }
                }
                Spacer()
                    .navigationTitle("LogicalEFT")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
