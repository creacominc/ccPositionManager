//
//  MarketTestView.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-11.
//

import SwiftUI

struct QuotesTestView: View
{
    private var schwabClient: SchwabClient

    @State private var symbol: String = ""
    @State private var quotesButtonEnabled: Bool = false

    init( schwabClient: SchwabClient )
    {
        self.schwabClient = schwabClient
    }

    var body: some View
    {

        TextField( "Symbol", text: $symbol )
            .padding()
            .searchable( text: $symbol )
            .onChange(of: symbol, {
                quotesButtonEnabled = !symbol.isEmpty
                print("Search text changed to \(symbol)")
            })
        Button( action: {
            print("Search text with \(symbol)")
            schwabClient.getQuotes( symbolId: symbol,
                                 completion:
            { result in
                if case .success(let quotes) = result
                {
                    print("\n\nQuotes: \(quotes)\n")
                }
                else {
                    print("\n\nError: \(result)\n")
                }
            }
            )

        }) {
            Text("Search")
        }
        .disabled( !quotesButtonEnabled )


    }
}

#Preview
{
    var schwabClient = SchwabClient( secrets: getSecretsFromFile() )
    QuotesTestView( schwabClient : schwabClient )
}

