//
//  day07.swift
//  
//
//  Created by Omar Estrella on 12/7/21.
//

import Foundation


struct Day7: Solution {
  var day = 7

  func partOne(input: String) async -> String {
    let crabs = input
        .components(separatedBy: .init(charactersIn: ",\n"))
        .compactMap { Int($0) }
    let positions = Set(crabs)
    
    var costs: [(Int, Int)] = []
    for pos in positions {
      let fuel = crabs.reduce(0, { sum, crab in
        return sum + abs(crab - pos)
      })
      costs.append((pos, fuel))
    }
    guard let smallestCost = costs.sorted(by: { $0.1 < $1.1 }).first else { return "could not find cost" }
    return "\(smallestCost.1)"
  }

  func partTwo(input: String) async -> String {
    let crabs = input
        .components(separatedBy: .init(charactersIn: ",\n"))
        .compactMap { Int($0) }
    let positions = Set(crabs)
    
    var costs: [(Int, Int)] = []
    for pos in positions {
      let fuel = crabs.reduce(0, { sum, crab in
        let moves = abs(crab - pos)
        return sum + (moves * (moves + 1) / 2)
      })
      costs.append((pos, fuel))
    }
    guard let smallestCost = costs.sorted(by: { $0.1 < $1.1 }).first else { return "could not find cost" }
    return "\(smallestCost.1)"
  }
}
