//
//  Regular.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-11.
//

import Foundation
import SwiftData

@Model
final class Regular
{

    init(m_regularMarketLastPrice: Float, m_regularMarketLastSize: Int, m_regularMarketNetChange: Float, m_regularMarketPercentChange: Float, m_regularMarketTradeTime: Int)
    {
        self.m_regularMarketLastPrice = m_regularMarketLastPrice
        self.m_regularMarketLastSize = m_regularMarketLastSize
        self.m_regularMarketNetChange = m_regularMarketNetChange
        self.m_regularMarketPercentChange = m_regularMarketPercentChange
        self.m_regularMarketTradeTime = m_regularMarketTradeTime
    }

    private var m_regularMarketLastPrice: Float = 0.0
    private var m_regularMarketLastSize: Int = 0
    private var m_regularMarketNetChange: Float = 0.0
    private var m_regularMarketPercentChange: Float = 0.0
    private var m_regularMarketTradeTime: Int = 0

}

/**
 "regular": {
   "regularMarketLastPrice": 118.42,
   "regularMarketLastSize": 45019,
   "regularMarketNetChange": -3.25,
   "regularMarketPercentChange": -2.67115969,
   "regularMarketTradeTime": 1736553600002
 }
 */
