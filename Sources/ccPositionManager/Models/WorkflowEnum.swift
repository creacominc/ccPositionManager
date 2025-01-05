//
//  WorkflowEnum.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2024-12-31.
//

import Foundation

enum WorkflowEnum: String, CaseIterable, Identifiable
{
    var id: Self { self }

    case SellWF
    case BuyWF
    case ContractWF
    case AccountWF
}

