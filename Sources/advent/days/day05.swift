//
//  day05.swift
//
//
//  Created by Omar Estrella on 12/5/21.
//

import Foundation

private struct PointPairs: Equatable {
  let x1: Int
  let y1: Int

  let x2: Int
  let y2: Int

  init(from pairs: [Int]) {
    x1 = pairs[0]
    y1 = pairs[1]
    x2 = pairs[2]
    y2 = pairs[3]
  }

  var isStraightLine: Bool {
    x1 == x2 || y1 == y2
  }

  var linePoints: [(x: Int, y: Int)] {
    if isStraightLine {
      if x1 == x2 {
        return (min(y1, y2) ... max(y1, y2)).map { (x: x1, y: $0) }
      }
      return (min(x1, x2) ... max(x1, x2)).map { (x: $0, y: y1) }
    }

    let min = x1 < x2 ? (x1, y1) : (x2, y2)
    let max = x1 < x2 ? (x2, y2) : (x1, y1)

    return (min.0 ... max.0).reduce([]) { (list: [(Int, Int)], x: Int) in
      let dy = min.1 > max.1 ? -1 : 1
      guard let lastPoint = list.last else { return [(x, min.1)] }
      return list + [(x: x, y: lastPoint.1 + dy)]
    }
  }
}

private func getPointPairs(input: String) -> [PointPairs] {
  input.split(separator: "\n")
    .map { entry in
      entry.components(separatedBy: .init(charactersIn: " ->"))
        .filter { !$0.isEmpty }
        .flatMap { strPairs in
          strPairs.split(separator: ",").compactMap { Int($0) }
        }
    }.map { (pairs: [Int]) -> PointPairs in
      PointPairs(from: pairs)
    }
}

func printGrid(_ grid: [[Int]]) {
  for row in grid {
    print(row, separator: " ")
  }
}

struct Day5: Solution {
  var day: Int = 5

  func partOne(input: String) async -> String {
    let pointPairs = getPointPairs(input: input).filter(\.isStraightLine)
    let allPoints = pointPairs.flatMap(\.linePoints)

    let maxX = allPoints.reduce(0) { max, point in
      point.x > max ? point.x : max
    }
    let maxY = allPoints.reduce(0) { max, point in
      point.y > max ? point.y : max
    }

    var grid = (0 ... maxY).map { _ in
      (0 ... maxX).map { _ in 0 }
    }

    for point in allPoints {
      grid[point.y][point.x] += 1
    }

    let sum = grid.reduce(0) { sum, row in
      sum + row.reduce(0) { colSum, num in
        if num >= 2 {
          return colSum + 1
        }
        return colSum
      }
    }

    return "\(sum)"
  }

  func partTwo(input: String) async -> String {
    let pointPairs = getPointPairs(input: input)
    let allPoints = pointPairs.flatMap(\.linePoints)

    let maxX = allPoints.reduce(0) { max, point in
      point.x > max ? point.x : max
    }
    let maxY = allPoints.reduce(0) { max, point in
      point.y > max ? point.y : max
    }

    var grid = (0 ... maxY).map { _ in
      (0 ... maxX).map { _ in 0 }
    }

    for point in allPoints {
      grid[point.y][point.x] += 1
    }

    let sum = grid.reduce(0) { sum, row in
      sum + row.reduce(0) { colSum, num in
        if num >= 2 {
          return colSum + 1
        }
        return colSum
      }
    }

    return "\(sum)"
  }
}
