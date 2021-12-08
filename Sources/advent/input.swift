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
//  return "16,1,2,0,4,2,7,1,2,14,5"
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
