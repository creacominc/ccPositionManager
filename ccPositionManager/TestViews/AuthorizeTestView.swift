//
//  AuthorizeTestView.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-10.
//

import SwiftUI

struct AuthorizeTestView: View
{
    private var schwabClient: SchwabClient

    @State private var resultantUrl: String = ""
    @State private var authenticateButtonUrl: URL = URL( string: "https://localhost" )!
    @State private var authenticateButtonEnabled: Bool = false
    @State private var authenticateButtonTitle: String = "Click to Authorize"
    @State private var nextButtonEnabled: Bool = false

    init( schwabClient: SchwabClient )
    {
        self.schwabClient = schwabClient
    }

    var body: some View
    {

        VStack
        {
            Link( authenticateButtonTitle
                  , destination: URL( string: self.schwabClient.secrets.authorizationUrl )! )
            .disabled( !authenticateButtonEnabled )
            .opacity( !authenticateButtonEnabled ? 0 : 1 )
            .onAppear
            {
                self.schwabClient.getAuthenticationUrl
                { (result : Result< URL, ErrorCodes>) in

                    switch result
                    {
                    case .success( let url ):
                        print( "Authentication URL: \(url)" )
                        authenticateButtonEnabled = true
                        self.schwabClient.secrets.authorizationUrl = url.absoluteString
                    case .failure(let error):
                        print("Authentication failed: \(error)")
                    }

                }
            }

            TextField( "After authorization, paste URL here.", text: $resultantUrl )
            .onChange( of: resultantUrl )
            {
                print( "OnChange URL: \( resultantUrl )" )
                nextButtonEnabled = true
            }

            Button( "Next" )
            {
                self.schwabClient.getAccessToken( from: resultantUrl )
                { (result : Result< Void, ErrorCodes>) in
                    switch result
                    {
                    case .success( ):
                        print( "worked?" )
                    case .failure(let error):
                        print("Authenticate error: \(error)")
                        print( error.localizedDescription )
                    }
                }
            }
            .disabled( !nextButtonEnabled )
        }

    }
}

#Preview
{
    let schwabClient = SchwabClient( secrets: getSecretsFromFile() )
    AuthorizeTestView( schwabClient : schwabClient )
}
