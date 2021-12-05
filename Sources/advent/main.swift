import Foundation

let group = DispatchGroup()

DispatchQueue.global(qos: .default).async(group: group) {
  group.enter()
  Task {
    let start = Date.now
    let (partOne, partTwo) = await Runner.shared.run(day: 4)
    let end = Date.now
    print("Part 1: \(partOne)")
    print("Part 2: \(partTwo)")
    print("Time: \(DateInterval(start: start, end: end).duration.formatted()) seconds")
    group.leave()
  }
}

group.wait()
