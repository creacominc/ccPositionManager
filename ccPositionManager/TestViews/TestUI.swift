//
//  TestUI.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-10.
//

import SwiftUI

struct TestUI: View
{
    private var schwabClient: SchwabClient

    init( schwabClient: SchwabClient )
    {
        self.schwabClient = schwabClient
    }

    var body: some View
    {
        VStack {
            SecretsTestView( schwabClient: schwabClient )
                .padding()
            AuthorizeTestView( schwabClient: schwabClient )
                .padding()
            QuotesTestView( schwabClient: schwabClient )
                .padding()
        }
        
    }

    
}



#Preview
{
    let schwabClient = SchwabClient( code: "", session: "" )
    TestUI( schwabClient : schwabClient )
}

