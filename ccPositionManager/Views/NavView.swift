//
//  NavView.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-01.
//

import SwiftUI
import SwiftData

struct NavView: View
{
    @Query private var accounts: [Account]

    var body: some View
    {
        VStack
        {
            List
            {
//                ForEach( accounts )
//                { account in
//
//                    ForEach( account.positions() )
//                    { position in
//                        Text( position.symbol() )
//                    }
//
//                    NavigationLink
//                    {
//                        Text( "Item at \(account.accountNumber) " )
//                    }
//                label:
//                    {
//                        Text( account.accountNumber )
//                    }
//                }
//                .onDelete(perform: deleteItems)
                
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
            }
//            .task {
//                context.insert( Account( accountNumber: "AAPL" ) )
//                context.insert( Account( accountNumber: "NVDA" ) )
//                context.insert( Account( accountNumber: "RKLB" ) )
//            }
            
            HStack
            {
                // buttons at bottom
//                Picker("Workflow", selection: $workflowEnum)
//                {
//                    Text( "Sell" ).tag( WorkflowEnum.SellWF )
//                    Text( "Buy" ).tag( WorkflowEnum.BuyWF )
//                    Text( "Cntract" ).tag( WorkflowEnum.ContractWF )
//                    Text( "Account" ).tag( WorkflowEnum.AccountWF )
//                }
                
            }
            
        }
        
        
        
    }
    
    

    
}

#Preview
{
    NavView()
}
