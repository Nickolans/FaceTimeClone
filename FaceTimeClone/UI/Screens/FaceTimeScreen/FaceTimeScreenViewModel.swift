//
//  FaceTimeScreenViewModel.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 10/28/23.
//

import Foundation
import SwiftUI

@Observable class FaceTimeScreenViewModel {
    var facetimeActions: [FaceTimeAction] = []
    
    init() {
        self.facetimeActions = [
            .init(imageSystemName: "speaker.wave.2.fill",
                  title: .audio,
                  action: audioSource),
            .init(imageSystemName: "video",
                  title: .camera,
                  action: cameraEnabled),
            .init(imageSystemName: "mic.slash",
                  title: .mute,
                  action: audioEnabled),
            .init(imageSystemName: "rectangle.inset.filled.and.person.filled",
                  title: .share,
                  action: shareEnabled),
            .init(imageSystemName: "multiply",
                  title: .end,
                  action: endCall)
        ]
    }
    
    private func toggleActionSelection(forAction action: FaceTimeActionTitle) {
        guard let i = facetimeActions.firstIndex(where: { $0.title == action }) else { return }
        facetimeActions[i].selected.toggle()
    }
    
    private func audioSource() {
        toggleActionSelection(forAction: .audio)
    }
    
    private func cameraEnabled() {
        toggleActionSelection(forAction: .camera)
    }
    
    private func audioEnabled() {
        toggleActionSelection(forAction: .mute)
    }
    
    private func shareEnabled() {
        toggleActionSelection(forAction: .share)
    }
    
    private func endCall() {
        toggleActionSelection(forAction: .end)
    }
    
    func takeScreenshot() {
        //
    }
}
