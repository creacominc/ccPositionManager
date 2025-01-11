//
//  AuthorizeTestView.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-10.
//

import SwiftUI

struct AuthorizeTestView: View
{
    @State private var resultantUrl: String = ""
    @State private var authenticateButtonUrl: URL = URL( string: "https://localhost" )!
    @State private var authenticateButtonEnabled: Bool = false
    @State private var authenticateButtonTitle: String = "Click to Authorize"
    @State private var extractedCode: String = ""
    @State private var extractedSession: String = ""

    var body: some View
    {

        VStack
        {
            Link( authenticateButtonTitle, destination: authenticateButtonUrl )
            .disabled( !authenticateButtonEnabled )
            .opacity( !authenticateButtonEnabled ? 0 : 1 )
            .onAppear
            {

                let apiClient = APIClient()
                apiClient.authenticate
                { (result : Result< URL, APIError>) in

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

            TextField( "After authorization, paste URL here and hit <Enter>.", text: $resultantUrl
                       , onCommit:
            {
                print( "URL: \(self.resultantUrl)" )

                let urlComponents = URLComponents(string: self.resultantUrl)!
                let queryItems = urlComponents.queryItems
                
                extractedCode = queryItems?.first(where: { $0.name == "code" })?.value ?? ""
                extractedSession = queryItems?.first(where: { $0.name == "session" })?.value ?? ""

            }

            )
            Text( "Code: \(extractedCode)" )
            Text( "Session: \(extractedSession)")

        }

    }
}

#Preview
{
    AuthorizeTestView()
}
