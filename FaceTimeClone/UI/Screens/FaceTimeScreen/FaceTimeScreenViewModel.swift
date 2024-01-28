//
//  FaceTimeScreenViewModel.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 10/28/23.
//

import AVFoundation
import Foundation
import SwiftUI

@Observable class FaceTimeScreenViewModel {
    private let camera = Camera()
    var facetimeActions: [FaceTimeAction] = []
    var videoImage: Image?
    
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
    
    private func getBool(forAction action: FaceTimeActionTitle) -> Bool {
        guard let i = facetimeActions.firstIndex(where: { $0.title == action }) else { return false }
        return facetimeActions[i].selected
    }
    
    private func audioSource() {
        toggleActionSelection(forAction: .audio)
    }
    
    private func cameraEnabled() {
        toggleActionSelection(forAction: .camera)
        
        if getBool(forAction: .camera) {
            Task {
                await startCamera()
            }
        } else {
            camera.stop()
        }
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
    
    // CAMERA
    
    private func startCamera() async {
        await camera.start()
        
        let imageStream = camera.previewStream.map { $0.image }
        
        for await image in imageStream {
            Task { @MainActor in
                videoImage = image
            }
        }
    }
}

fileprivate extension CIImage {
    var image: Image? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else { return nil }
        return Image(decorative: cgImage, scale: 1, orientation: .up)
    }
}
