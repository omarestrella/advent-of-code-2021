//
//  day04.swift
//
//
//  Created by Omar Estrella on 12/4/21.
//

import Foundation

struct Board {
  let rows: [[Int]]
  let cols: [[Int]]

  let allNumbers: Set<Int>
  let rowSets: [Set<Int>]
  let colSets: [Set<Int>]

  init(numbers: [[Int]]) {
    rows = numbers
    cols = numbers.first?.indices.map { idx in
      numbers.map { $0[idx] }
    } ?? []

    rowSets = rows.map { Set($0) }
    colSets = cols.map { Set($0) }

    allNumbers = Set(numbers.flatMap { $0 })
  }

  func hasNumber(num: Int) -> Bool {
    allNumbers.contains(num)
  }

  func playNumber(numbersPlayed: [Int], num: Int) -> Bool {
    if !hasNumber(num: num) {
      return false
    }
    return hasWon(numbersSeen: numbersPlayed + [num])
  }

  func hasWon(numbersSeen: [Int]) -> Bool {
    let seenSet = Set(numbersSeen)
    if rowSets.first(where: { $0.intersection(seenSet).count == $0.count }) != nil {
      return true
    }
    if colSets.first(where: { $0.intersection(seenSet).count == $0.count }) != nil {
      return true
    }
    return false
  }

  func unmarkedNumbers(played: [Int]) -> [Int] {
    allNumbers.filter { !played.contains($0) }
  }
}

struct GameResult {
  let board: Board
  let played: [Int]

  var score: Int {
    let unmarkedNumbers = board.unmarkedNumbers(played: played)
    let sum = unmarkedNumbers.reduce(0, +)
    guard let lastPlayed = played.last else { return 0 }
    return sum * lastPlayed
  }
}

private func getBoards(input: [String]) -> [Board] {
  let boards = input
    .split(separator: "", maxSplits: input.count, omittingEmptySubsequences: false)
    .map { seq in
      Array(seq).map { str in
        str.split(separator: " ").compactMap { Int($0) }
      }
    }.filter {
      $0.count > 0
    }.map {
      Board(numbers: $0)
    }

  return boards
}

private func playFirstGames(numbers: [Int], boards: [Board]) -> (Int, Board, [Int])? {
  var played: [Int] = []
  for num in numbers {
    played.append(num)
    if let winningBoard = boards.first(where: { $0.playNumber(numbersPlayed: played, num: num) }) {
      return (num, winningBoard, played)
    }
  }
  return nil
}

private func playGames(numbers: [Int], boards: [Board]) -> [GameResult] {
  boards.map { board in
    var played: [Int] = [numbers.first!]
    var numbersToPlay = numbers.rest
    while numbersToPlay.first != nil, !board.hasWon(numbersSeen: played) {
      played.append(numbersToPlay.first!)
      numbersToPlay = numbersToPlay.rest
    }
    return GameResult(board: board, played: played)
  }
}

struct Day4: Solution {
  var day: Int = 4

  func partOne(input: String) async -> String {
    let data = input.components(separatedBy: .newlines)
    guard let numbers = data.first?
      .split(separator: ",")
      .compactMap({ Int($0) }) else { return "" }
    let boards = getBoards(input: Array(data[2...]))

    let results = playGames(numbers: numbers, boards: boards)
      .sorted(by: { $0.played.count < $1.played.count })

    return "\(results.first!.score)"
  }

  func partTwo(input: String) async -> String {
    let data = input.components(separatedBy: .newlines)
    guard let numbers = data.first?
      .split(separator: ",")
      .compactMap({ Int($0) }) else { return "" }
    let boards = getBoards(input: Array(data[2...]))

    let results = playGames(numbers: numbers, boards: boards)
      .sorted(by: { $0.played.count < $1.played.count })

    return "\(results.last!.score)"
  }
}
