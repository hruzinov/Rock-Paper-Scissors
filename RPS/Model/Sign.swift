//
//  Sign.swift
//  RPS
//
//  Created by Evhen Gruzinov on 24.08.2022.
//

import Foundation

enum Sign {
    case rock, paper, scissors, none
    
    var emoji: String {
        switch self {
        case .rock: return "✊"
        case .paper: return "✋"
        case .scissors: return "✌️"
        case .none: return ""
        }
    }
}

func randomSign() -> Sign {
    let sign = Int.random(in: 0...2)
    if sign == 0 {
        return .rock
    } else if sign == 2 {
        return .paper
    } else {
        return .scissors
    }
}
