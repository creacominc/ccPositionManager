//
//  TestUI.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-10.
//

import SwiftUI

struct TestUI: View
{
    
    var body: some View
    {
        VStack {
            SecretsTestView()
                .padding()
            AuthorizeTestView()
                .padding()
        }
        
    }

    
}



#Preview {
    TestUI()
}

