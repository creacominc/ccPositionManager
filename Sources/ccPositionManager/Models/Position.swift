//
//  Position.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-01.
//

import Foundation
import SwiftData

@Model
final class Position
{

    private var m_symbol: String
    private var m_averagePrice: Double = 0.0
//    private var m_currentDayProfitLoss: Double = 0.0
//    private var m_currentDayProfitLossPercentage: Double = 0.0
//    private var m_longQuantity: Double = 0.0
//    private var m_settledLongQuantity: Double = 0.0
//    private var m_settledShortQuantity: Double = 0.0
//    private var m_instrumentDescription: String = ""
//    private var m_marketValue: Double = 0.0

    init(
        symbol: String
        , averagePrice: Double
//        , currentDayProfitLoss: Double
//        , currentDayProfitLossPercentage: Double
//        , longQuantity: Double
//        , settledLongQuantity: Double
//        , settledShortQuantity: Double
//        , instrumentDescription: String
//        , marketValue: Double
    )
    {
        self.m_symbol = symbol
        self.m_averagePrice = averagePrice
//        self.m_currentDayProfitLoss = currentDayProfitLoss
//        self.m_currentDayProfitLossPercentage = currentDayProfitLossPercentage
//        self.m_longQuantity = longQuantity
//        self.m_settledLongQuantity = settledLongQuantity
//        self.m_settledShortQuantity = settledShortQuantity
//        self.m_instrumentDescription = instrumentDescription
//        self.m_marketValue = marketValue
    }

    public func symbol() -> String
    {
        return m_symbol
    }


}




/**
 

 
 
 */
