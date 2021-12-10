//
//  day08.swift
//
//
//  Created by Omar Estrella on 12/7/21.
//

import Foundation

private let lengths: [Int: Int] = [
  0: 6,
  1: 2,
  2: 5,
  3: 5,
  4: 4,
  5: 5,
  6: 6,
  7: 3,
  8: 7,
  9: 6,
]

func matchesLength(_ set: Set<String.Element>, numbers nums: [Int]) -> Bool {
  nums.filter { num in
    guard let length = lengths[num] else { return false }
    return set.count == length
  }.count > 0
}

struct Day8: Solution {
  var day = 8

  func partOne(input: String) async -> String {
    let data = input
      .split(separator: "\n")
      .compactMap { rows -> (input: [String], output: [String]) in
        let entries = rows.split(separator: " ").split(separator: "|").map { Array($0.map(String.init)) }
        return (input: entries[0], output: entries[1])
      }

    var sum = 0
    for datum in data {
      let sets = datum.output.map { Set($0.map { $0 }) }
      let uniqueCount = sets.reduce(0) { count, output in
        matchesLength(output, numbers: [1, 4, 7, 8]) ? count + 1 : count
      }
      sum += uniqueCount
    }

    return "\(sum)"
  }

  func partTwo(input: String) async -> String {
    let data = input
      .split(separator: "\n")
      .compactMap { rows -> (input: [String], output: [String]) in
        let entries = rows.split(separator: " ").split(separator: "|").map { Array($0.map(String.init)) }
        return (input: entries[0], output: entries[1])
      }

    // We know that:
    // 1 = 2 letters
    // 4 = 4 letters
    // 7 = 3 letters
    // 8 = 7 letters

    // We also know:
    // 0, 6, 9 = 6 letters
    // 2, 3, 5 = 5 letters

    let results = data.map { (input, output) -> String in
      guard let oneStr = input.first(where: { $0.count == 2 }) else { return "" }
      guard let fourStr = input.first(where: { $0.count == 4 }) else { return "" }
      guard let sevenStr = input.first(where: { $0.count == 3 }) else { return "" }
      guard let eightStr = input.first(where: { $0.count == 7 }) else { return "" }

      let knownMap = [
        oneStr: 1,
        fourStr: 4,
        sevenStr: 7,
        eightStr: 8,
      ]
      let map: [String: Int] = input
        .sorted(by: { $0.count > $1.count })
        .reduce(knownMap) { dict, str in
          let strSet = Set(str)
          if str.count == 6 {
            // Find 0, 6, or 9

            // 9 contains 4, but 6 and 0 do not
            if Set(fourStr).isSubset(of: strSet) {
              return dict.merging([str: 9], uniquingKeysWith: { curr, _ in curr })
            }
            // 0 contains 1, but 6 does not
            if Set(oneStr).isSubset(of: strSet) {
              return dict.merging([str: 0], uniquingKeysWith: { curr, _ in curr })
            }
            return dict.merging([str: 6], uniquingKeysWith: { curr, _ in curr })
          }

          if str.count == 5 {
            // Find 2, 3, or 5

            // 3 contains 1, but 2 and 5 do not
            if Set(oneStr).isSubset(of: strSet) {
              return dict.merging([str: 3], uniquingKeysWith: { curr, _ in curr })
            }
            // 5 and 6 intersect, so use the previous check
            if let sixString = dict.first(where: {_, value in value == 6}), strSet.isSubset(of: Set(sixString.key)) {
              return dict.merging([str: 5], uniquingKeysWith: { curr, _ in curr })
            }
            return dict.merging([str: 2], uniquingKeysWith: { curr, _ in curr })
          }

          return dict
        }
      
      return output
        .compactMap { o in
          map.first(where: { key, _ in Set(key) == Set(o) })
        }
        .map { String($0.value) }
        .joined()
    }
    
    let sum = results.compactMap { Int($0) }.reduce(0, +)

    return "\(sum)"
  }
}
