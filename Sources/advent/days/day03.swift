//
//  day03.swift
//
//
//  Created by Omar Estrella on 12/3/21.
//

import Foundation

private func getColumnCounts(numbers: [[Int]]) -> [(Int, Int)] {
  numbers.first?.indices.map { idx in
    numbers.map { $0[idx] }
  }.map { nums -> (Int, Int) in
    nums.reduce((0, 0)) { sum, number in
      if number == 0 {
        return (sum.0 + 1, sum.1)
      }
      return (sum.0, sum.1 + 1)
    }
  } ?? []
}

struct Day3: Solution {
  var day: Int = 3

  func partOne(input: String) async -> String {
    let numbers = input.split(separator: "\n")
      .map { Array($0) }
      .map { list in list.compactMap { s in Int(String(s)) } }

    let columns = getColumnCounts(numbers: numbers)

    let gamma = columns.map { (col: (Int, Int)) -> Int in
      if col.0 > col.1 {
        return 0
      }
      return 1
    }
    let epsilon = gamma.map { (num: Int) in num == 0 ? 1 : 0 }

    let gammaVal = Int(gamma.map { String($0) }.joined(), radix: 2)
    let epsilonVal = Int(epsilon.map { String($0) }.joined(), radix: 2)

    return "\(gammaVal! * epsilonVal!)"
  }

  func partTwo(input: String) async -> String {
    let numbers = input.split(separator: "\n")
      .map { Array($0) }
      .map { list in list.compactMap { s in Int(String(s)) } }

    let columns = getColumnCounts(numbers: numbers)

    func filterNumbers(colIdx: Int, min: Bool, numbers: [[Int]], columns: [(Int, Int)]) -> [Int]? {
      if numbers.count == 1 {
        return numbers.first
      }

      let col = columns[colIdx]
      let newNumbers = numbers.filter { nums in
        var numberToUse = -1
        if col.0 == col.1 {
          numberToUse = min ? 0 : 1
        } else if min {
          numberToUse = col.0 < col.1 ? 0 : 1
        } else {
          numberToUse = col.0 > col.1 ? 0 : 1
        }
        return nums[colIdx] == numberToUse
      }
      let newColumns = getColumnCounts(numbers: newNumbers)

      return filterNumbers(colIdx: colIdx + 1, min: min, numbers: newNumbers, columns: newColumns)
    }

    guard let oxygen = filterNumbers(colIdx: 0, min: false, numbers: numbers, columns: columns) else { return "" }
    guard let co2 = filterNumbers(colIdx: 0, min: true, numbers: numbers, columns: columns) else { return "" }

    let oxygenVal = Int(oxygen.map { String($0) }.joined(), radix: 2)
    let co2Val = Int(co2.map { String($0) }.joined(), radix: 2)

    return "\(oxygenVal! * co2Val!)"
  }
}
