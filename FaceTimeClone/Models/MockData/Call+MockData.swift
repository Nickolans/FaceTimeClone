//
//  Call+MockData.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 10/28/23.
//

import Foundation

extension Call {
    static let mockCalls: [Call] = [
        Call(name: "Noah R", type: .audio, startDate: .init(timeIntervalSinceNow: -1000000)),
        Call(name: "Kelli", type: .video, startDate: .init(timeIntervalSinceNow: -3000000)),
        Call(name: "Greg Griffith", type: .video, startDate: .init(timeIntervalSinceNow: -4000000))
    ]
}
