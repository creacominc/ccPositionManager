//
//  SecurityListView.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-01.
//

import SwiftUI

struct SecurityListView: View
{
    @State private var positions : [Position] = [
        Position(symbol: "AAPL"),
        Position(symbol: "MSFT"),
        Position(symbol: "FB"),
    ]

    var body: some View
    {

        NavigationStack {

            List {
                ForEach(positions)
                { position in
                    Text(position.symbol())
                }
            }

        }
        .navigationTitle(Text("Positions"))

    }

}

#Preview
{
    SecurityListView()
}
