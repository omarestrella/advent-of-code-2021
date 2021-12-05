import Foundation

let group = DispatchGroup()

DispatchQueue.global(qos: .default).async(group: group) {
  group.enter()
  Task {
    let (partOne, partTwo) = await Runner.shared.run(day: 4)
    print("Part 1: \(partOne)")
    print("Part 2: \(partTwo)")
    group.leave()
  }
}

group.wait()
