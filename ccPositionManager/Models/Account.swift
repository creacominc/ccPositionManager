//
//  Item.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2024-12-21.
//

import Foundation
import SwiftData

@Model
final class Account
{
    
    private var m_accountNumber: String
    private var m_positionList: [ Position ] = []
    private var m_initialBalances: Balance
    private var m_currentBalances: Balance
    private var m_projectedBalances: Balance
    
    init(accountNumber: String, positionList: [Position], initialBalances: Balance, currentBalances: Balance, projectedBalances: Balance)
    {
        self.m_accountNumber = accountNumber
        self.m_positionList = positionList
        self.m_initialBalances = initialBalances
        self.m_currentBalances = currentBalances
        self.m_projectedBalances = projectedBalances
    }
    
    func positions() -> [Position]
    {
        m_positionList
    }

}

/**
 

 
 */
