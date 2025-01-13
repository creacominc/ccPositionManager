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
    @State private var extractedAccessToken: String = ""
    @State private var extractedSession: String = ""

    init( schwabClient: SchwabClient )
    {
        self.schwabClient = schwabClient
    }

    var body: some View
    {

        VStack
        {
            Link( authenticateButtonTitle, destination: authenticateButtonUrl )
            .disabled( !authenticateButtonEnabled )
            .opacity( !authenticateButtonEnabled ? 0 : 1 )
            .onAppear
            {
                schwabClient.authenticate
                { (result : Result< URL, ErrorCodes>) in

                    switch result
                    {
                    case .success( let url ):
                        print( "authenticated" )
                        print( url )
                        authenticateButtonEnabled = true
                        authenticateButtonUrl = url
                    case .failure(let error):
                        print("Authentication failed: \(error)")
                    }

                }

            }

            TextField( "After authorization, paste URL here.", text: $resultantUrl
            )
            .onChange( of: resultantUrl )
            {
                print( "URL: \(self.resultantUrl)" )

                let urlComponents = URLComponents(string: self.resultantUrl)!
                let queryItems = urlComponents.queryItems
                
                extractedAccessToken = queryItems?.first(where: { $0.name == "code" })?.value ?? ""
                extractedSession = queryItems?.first(where: { $0.name == "session" })?.value ?? ""

                self.schwabClient.setAccessToken( accessToken: extractedAccessToken )
                self.schwabClient.setSession( session: extractedSession )
                print( "accessToken: \(extractedAccessToken)" )
                print( "session: \(extractedSession)" )
            }
            Text( "Access Token: \(extractedAccessToken)" )
            Text( "Session: \(extractedSession)")

        }

    }
}

#Preview
{
    let schwabClient = SchwabClient( accessToken: "", session: "" )
    AuthorizeTestView( schwabClient : schwabClient )
}
