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
        
        VStack
        {
            
            TextField( "Symbol", text: $symbol )
                .padding()
                .onChange(of: symbol, perform: { newValue in
                    quotesButtonEnabled = !newValue.isEmpty
                } )
            
            //            .searchable( text: $symbol )
            //            .onChange(of: symbol, {
            //                quotesButtonEnabled = !symbol.isEmpty
            //                print("Search text changed to \(symbol)")
            //            })
            
            Button( "Get Quotes" )
            {
                
            }
            .disabled( !quotesButtonEnabled )
            .padding( 10 )
        }
        
    }

    func getQuotes() async
    {
        self.schwabClient.getQuotes( forSymbols: [ symbol ] )
    }
    
}

#Preview
{
    var schwabClient = SchwabClient( secrets: getSecretsFromFile() )
    QuotesTestView( schwabClient : schwabClient )
}

