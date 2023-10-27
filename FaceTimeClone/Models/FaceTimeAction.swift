//
//  FaceTimeAction.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 10/29/23.
//

import Foundation

struct FaceTimeAction: Identifiable {
    let id: UUID = UUID()
    let imageSystemName: String
    let title: FaceTimeActionTitle
    var selected: Bool
    let action: () -> ()
    
    init(imageSystemName: String, title: FaceTimeActionTitle, selected: Bool = false, action: @escaping () -> Void) {
        self.imageSystemName = imageSystemName
        self.title = title
        self.selected = selected
        self.action = action
    }
}
