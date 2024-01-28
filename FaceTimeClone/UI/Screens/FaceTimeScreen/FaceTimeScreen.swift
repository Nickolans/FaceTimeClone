//
//  FaceTimeScreen.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 10/28/23.
//

import Foundation
import SwiftUI

struct FaceTimeScreen: View {
    
    @State private var viewModel = FaceTimeScreenViewModel()
    @State private var location: CGPoint = CGPoint(x: 38, y: 75)
    
    var body: some View {
        GeometryReader(content: { geometry in
            
            ZStack {
                VStack(spacing: 15) {
                    
                    HStack {
                        Circle()
                            .frame(width: 40)
                        VStack {
                            Text("Noah Reed")
                                .leadingInfinite()
                            FaceTimeTypeView(type: .video)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "info.circle")
                    }
                    
                    HStack {
                        ForEach($viewModel.facetimeActions) { $action in
                            FaceTimeActionButton(faceTimeAction: $action)
                            
                            if (action.title != FaceTimeActionTitle.end) {
                                Spacer()
                            }
                        }
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .bottom) {
                        Button(action: viewModel.takeScreenshot, label: {
                            Image(systemName: "circle.inset.filled")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.white)
                        })
                        
                        Spacer()
                    }
                }
                .padding()
                
                if (self.viewModel.videoImage != nil) {
                    self.viewModel.videoImage!
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75, height: 150)
                        .clipShape(.rect(cornerRadius: 15))
                        .position(location)
                        .gesture(DragGesture().onChanged({ value in
                            self.location = value.location
                        })
                        .onEnded({ value in
                            self.determineLocation(location: value.location, size: geometry.size, frameSize: CGSize(width: 75, height: 150))
                        }))
                        .gesture(MagnifyGesture().onChanged({ value in
                            print("MAGNIFYING GESTURE: ", value)
                        }))
                }
                
            }
        })
    }
    
    private func determineLocation(location: CGPoint, size: CGSize, frameSize: CGSize) {
        
        let halfWidth = size.width / 2
        let halfHeight = size.height / 2
        let halfFrameWidth = frameSize.width / 2
        let halfFrameHeight = frameSize.height / 2
        
        withAnimation {
            if (location.x < halfWidth && location.y < halfHeight) {
                // Top Left
                self.location = CGPoint(x: 0 + halfFrameWidth, y: 0 + halfFrameHeight)
            } else if (location.x < halfWidth && location.y > halfHeight) {
                // Bottom Left
                self.location = CGPoint(x: 0 + halfFrameWidth, y: size.height - halfFrameHeight)
            } else if (location.x > halfWidth && location.y < halfHeight) {
                // Top Right
                self.location = CGPoint(x: size.width - halfFrameWidth, y: 0 + halfFrameHeight)
            } else if (location.x > halfWidth && location.y > halfHeight) {
                // Bottom Right
                self.location = CGPoint(x: size.width - halfFrameWidth, y: size.height - halfFrameHeight)
            }
        }
    }
}

#Preview {
    FaceTimeScreen()
}
