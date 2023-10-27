//
//  Call.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 10/28/23.
//

import Foundation

struct Call: Identifiable {
    let id: UUID = UUID()
    let name: String
    let type: FaceTimeType
    let startDate: Date
}
