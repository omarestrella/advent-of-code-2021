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
    default:
      return ("", "")
    }
  }

  private func runDay(solution: Solution) async -> (String, String) {
    let input = await getInput(day: solution.day)
    let partOne = await solution.partOne(input: input)
    let partTwo = await solution.partTwo(input: input)
    return (partOne, partTwo)
  }
}