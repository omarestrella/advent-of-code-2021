//
//  day02.swift
//
//
//  Created by Omar Estrella on 12/2/21.
//

import Foundation

// IDK why I'm using tuples...
typealias Position = (Int, Int)
typealias PositionAndAim = (Int, Int, Int)

struct Day2: Solution {
  var day: Int = 2

  func partOne(input: String) async -> String {
    let commands = input
      .split(separator: "\n")
      .compactMap { $0.split(separator: " ") }
      .map { (commandParts: [Substring]) in (String(commandParts[0]), Int(commandParts[1])!) }
    let position = commands.reduce((0, 0)) { (position: Position, command) in
      switch command.0 {
      case "forward":
        return (position.0 + command.1, position.1)
      case "down":
        return (position.0, position.1 + command.1)
      case "up":
        return (position.0, position.1 - command.1)
      default:
        return (position.0, position.1)
      }
    }
    return "\(position.0 * position.1)"
  }

  func partTwo(input: String) async -> String {
    let commands = input
      .split(separator: "\n")
      .compactMap { $0.split(separator: " ") }
      .map { (commandParts: [Substring]) in (String(commandParts[0]), Int(commandParts[1])!) }
    let position = commands.reduce((0, 0, 0)) { (position: PositionAndAim, command) in
      let (instruction, amount) = command
      let (horizontal, depth, aim) = position
      switch instruction {
      case "forward":
        return (horizontal + amount, depth + (aim * amount), aim)
      case "down":
        return (horizontal, depth, aim + amount)
      case "up":
        return (horizontal, depth, aim - amount)
      default:
        return position
      }
    }
    return "\(position.0 * position.1)"
  }
}
