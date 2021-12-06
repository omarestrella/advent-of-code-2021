//
//  runner.swift
//
//
//  Created by Omar Estrella on 12/1/21.
//

import Foundation

protocol Solution {
  var day: Int { get }

  func partOne(input: String) async -> String
  func partTwo(input: String) async -> String
}

struct Runner {
  static let shared = Runner()

  func run(day: Int) async -> (String, String) {
    switch day {
    case 1:
      return await runDay(solution: Day1())
    case 2:
      return await runDay(solution: Day2())
    case 3:
      return await runDay(solution: Day3())
    case 4:
      return await runDay(solution: Day4())
    case 5:
      return await runDay(solution: Day5())
    default:
      return ("no part 1", "no part 2")
    }
  }

  private func runDay(solution: Solution) async -> (String, String) {
    let input = await getInput(day: solution.day)
    let partOne = await solution.partOne(input: input)
    let partTwo = await solution.partTwo(input: input)
    return (partOne, partTwo)
  }
}
