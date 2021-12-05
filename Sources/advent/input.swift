//
//  input.swift
//
//
//  Created by Omar Estrella on 12/1/21.
//

import Foundation

func getEnvVar(name: String) -> String {
  guard let envVar = ProcessInfo.processInfo.environment[name] else {
    return ""
  }
  return envVar
}

func getInput(day: Int) async -> String {
//  return """
//7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1
//
//22 13 17 11  0
// 8  2 23  4 24
//21  9 14 16  7
// 6 10  3 18  5
// 1 12 20 15 19
//
// 3 15  0  2 22
// 9 18 13 17  5
//19  8  7 25 23
//20 11 10 24  4
//14 21 16 12  6
//
//14 21 17 24  4
//10 16 15  9 19
//18  8 23 26 20
//22 11 13  6  5
// 2  0 12  3  7
//"""
  guard let url = URL(string: "https://adventofcode.com/2021/day/\(day)/input") else {
    print("Bad URL")
    return ""
  }
  guard let cookie = HTTPCookie(properties: [
    .domain: ".adventofcode.com",
    .path: "/",
    .secure: true,
    .discard: false,
    .name: "session",
    .value: getEnvVar(name: "session")
  ]) else {
    print("Could not make cookie")
    return ""
  }
  URLSession.shared.configuration.httpCookieStorage?.setCookie(cookie)
  do {
    let (data, _) = try await URLSession.shared.data(from: url)
    let input = String.init(decoding: data, as: UTF8.self)
    return input
  } catch {
    print("Error loading input", error)
    return ""
  }
}
