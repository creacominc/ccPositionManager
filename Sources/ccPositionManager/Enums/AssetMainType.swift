//
//  WorkflowEnum.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2024-12-31.
//

import Foundation

public enum AssetMainType: String, Codable, CaseIterable
{

    case BOND
    case EQUITY
    case FOREX
    case FUTURE
    case FUTURE_OPTION
    case INDEX
    case MUTUAL_FUND
    case OPTION

}
