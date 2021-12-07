//
//  day06.swift
//
//
//  Created by Omar Estrella on 12/6/21.
//

import Foundation

// This definitely doesnt work for Part 2 😬
private func naiveAgeAllFish(_ fish: [Int]) -> [Int] {
  let amountToAdd = fish.filter { $0 == 0 }.count
  let newFish = fish.map({ age -> Int  in
    return age == 0 ? 6 : age - 1
  })
  return newFish + Array(repeating: 8, count: amountToAdd)
}

private func ageAllFish(_ fish: [Int]) -> [Int] {
  var newAges = fish
  for (idx, ages) in fish.enumerated() {
    let loc = idx == 0 ? 8 : idx - 1
    newAges[loc] = ages
    if idx == 7 {
      newAges[6] = ages + fish[0]
    }
  }
  return newAges
}

private func runDays(_ fish: [Int], days: Int) -> Int {
  var ages = Array(repeating: 0, count: 9)
  for age in fish {
    ages[age] += 1
  }
  for _ in 1 ... days {
    ages = ageAllFish(ages)
  }
  return ages.reduce(0, +)
}

struct Day6: Solution {
  var day = 6

  func partOne(input: String) async -> String {
    let fish = input
        .components(separatedBy: .init(charactersIn: ",\n"))
        .compactMap { Int($0) }
    let newFish = runDays(fish, days: 80)
    return "\(newFish)"
  }

  func partTwo(input: String) async -> String {
    let fish = input
        .components(separatedBy: .init(charactersIn: ",\n"))
        .compactMap { Int($0) }
    let newFish = runDays(fish, days: 256)
    return "\(newFish)"
  }
}
