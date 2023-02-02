//
//  Sign.swift
//  RPS
//
//  Created by Evhen Gruzinov on 24.08.2022.
//

import Foundation

enum Sign: String {
    case rock = "✊"
    case paper = "✋"
    case scissors = "✌️"
    case none = ""
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
