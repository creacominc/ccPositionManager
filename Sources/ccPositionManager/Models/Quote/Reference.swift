//
//  Reference.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-11.
//

import Foundation
import SwiftData

@Model
final class Reference:
{

    init(m_cusip: String, m_description: String, m_exchange: String, m_exchangeName: String, m_isHardToBorrow: Bool, m_isShortable: Bool, m_htbRate: Integer)
    {
        self.m_cusip = m_cusip
        self.m_description = m_description
        self.m_exchange = m_exchange
        self.m_exchangeName = m_exchangeName
        self.m_isHardToBorrow = m_isHardToBorrow
        self.m_isShortable = m_isShortable
        self.m_htbRate = m_htbRate
    }

    private var m_cusip: String = ""
    private var m_description: String = ""
    private var m_exchange: String = ""
    private var m_exchangeName: String = ""
    private var m_isHardToBorrow: Bool = false
    private var m_isShortable: Bool = false
    private var m_htbRate: Int = 0

}


/**
 "reference": {
   "cusip": "780087102",
   "description": "Royal Bank of Canada",
   "exchange": "N",
   "exchangeName": "NYSE",
   "isHardToBorrow": true,
   "isShortable": true,
   "htbRate": 0
 },
 */
