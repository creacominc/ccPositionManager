//
//  Fundamental.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-11.
//

import Foundation
import SwiftData



@Model
final class Fundamental
{

    init(m_avg10DaysVolume: Int, m_avg1YearVolume: Int, m_declarationDate: Date, m_divAmount: Float, m_divExDate: Date, m_divFreq: Int, m_divPayAmount: Float, m_divPayDate: Date, m_divYield: Float, m_eps: Float, m_fundLeverageFactor: Int, m_lastEarningsDate: Date, m_nextDivExDate: Date, m_nextDivPayDate: Date, m_peRatio: Float)
    {
        self.m_avg10DaysVolume = m_avg10DaysVolume
        self.m_avg1YearVolume = m_avg1YearVolume
        self.m_declarationDate = m_declarationDate
        self.m_divAmount = m_divAmount
        self.m_divExDate = m_divExDate
        self.m_divFreq = m_divFreq
        self.m_divPayAmount = m_divPayAmount
        self.m_divPayDate = m_divPayDate
        self.m_divYield = m_divYield
        self.m_eps = m_eps
        self.m_fundLeverageFactor = m_fundLeverageFactor
        self.m_lastEarningsDate = m_lastEarningsDate
        self.m_nextDivExDate = m_nextDivExDate
        self.m_nextDivPayDate = m_nextDivPayDate
        self.m_peRatio = m_peRatio
    }

    private var m_avg10DaysVolume: Int = 0
    private var m_avg1YearVolume: Int = 0
    private var m_declarationDate: Date = Date.now
    private var m_divAmount: Float = 0.0
    private var m_divExDate: Date = Date.now
    private var m_divFreq: Int = 0
    private var m_divPayAmount: Float = 0.0
    private var m_divPayDate: Date = Date.now
    private var m_divYield: Float = 0.0
    private var m_eps: Float = 0.0
    private var m_fundLeverageFactor: Int = 0
    private var m_lastEarningsDate: Date = Date.now
    private var m_nextDivExDate: Date = Date.now
    private var m_nextDivPayDate: Date = Date.now
    private var m_peRatio: Float = 0.0

}


/**
 "fundamental": {
   "avg10DaysVolume": 585643,
   "avg1YearVolume": 1057134,
   "declarationDate": "2024-12-03T05:00:00Z",
   "divAmount": 4.11852,
   "divExDate": "2025-01-27T05:00:00Z",
   "divFreq": 4,
   "divPayAmount": 1.02858,
   "divPayDate": "2025-02-24T05:00:00Z",
   "divYield": 3.38499,
   "eps": 8.07986,
   "fundLeverageFactor": 0,
   "lastEarningsDate": "2024-12-04T05:00:00Z",
   "nextDivExDate": "2025-04-28T04:00:00Z",
   "nextDivPayDate": "2025-05-27T04:00:00Z",
   "peRatio": 15.05843
 }
 */

