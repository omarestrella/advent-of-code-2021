//
//  day01.swift
//  
//
//  Created by Omar Estrella on 12/1/21.
//

import Foundation

struct Day1: Solution {
  var day: Int = 1
  
  func partOne(input: String) async -> String {
    var count = 0
    let numbers = input.split(separator: "\n")
      .compactMap { Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
    for (idx, num) in numbers[1...].enumerated() {
      if numbers[idx] < num {
        count += 1
      }
    }
    return "\(count)"
  }
  
  func partTwo(input: String) async -> String {
    let numbers = input.split(separator: "\n")
      .compactMap { Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
    var last = Int.max
    var count = 0
    for (idx, _) in numbers.enumerated() {
      if idx > numbers.count - 3 {
        break
      }
      let sum = numbers[idx...(idx + 2)].reduce(0, +)
      if sum > last {
        count += 1
      }
      last = sum
    }
    return "\(count)"
  }
}
