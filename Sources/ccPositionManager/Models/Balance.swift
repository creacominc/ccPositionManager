//
//  Balance.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-01.
//

import Foundation
import SwiftData

@Model
final class Balance
{
    
    private var accruedInterest: Double = 0.0
//    private var bondValue: Double = 0.0
//    private var buyingPower: Double = 0.0
//    private var cashBalance: Double = 0.0
//    private var cashAvailableForTrading: Double = 0.0
//    private var mutualFundValue: Double = 0.0
//    private var moneyMarketFund: Double = 0.0
//    private var totalCash: Double = 0.0
//    private var isInCall: Bool = false
//    private var unsettledCash: Double = 0.0
    
    init(
        accruedInterest: Double
//        , bondValue: Double
//        , buyingPower: Double
//        , cashBalance: Double
//        , cashAvailableForTrading: Double
//        , mutualFundValue: Double
//        , moneyMarketFund: Double
//        , totalCash: Double
//        , isInCall: Bool
//        , unsettledCash: Double
    )
    {
        self.accruedInterest = accruedInterest
//        self.bondValue = bondValue
//        self.buyingPower = buyingPower
//        self.cashBalance = cashBalance
//        self.cashAvailableForTrading = cashAvailableForTrading
//        self.mutualFundValue = mutualFundValue
//        self.moneyMarketFund = moneyMarketFund
//        self.totalCash = totalCash
//        self.isInCall = isInCall
//        self.unsettledCash = unsettledCash
    }
    
    
}


/**

 */
