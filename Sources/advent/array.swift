//
//  array.swift
//
//
//  Created by Omar Estrella on 12/3/21.
//

import Foundation

extension Array {
  var rest: [Element] {
    Array(self[1...])
  }
}

extension Sequence {
  var untyped: [Any] {
    self as! [Any]
  }
}
