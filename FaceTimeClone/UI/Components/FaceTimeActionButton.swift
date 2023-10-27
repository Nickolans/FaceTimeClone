//
//  SmallCircleButton.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 10/28/23.
//

import Foundation
import SwiftUI

struct FaceTimeActionButton: View {
    
    @Binding var faceTimeAction: FaceTimeAction
    
    var body: some View {
        Button(action: faceTimeAction.action, label: {
            VStack {
                Image(systemName: faceTimeAction.imageSystemName)
                    .padding(10)
                    .background(faceTimeAction.selected ? Color.white : Color.white.opacity(0.20))
                    .foregroundStyle(faceTimeAction.selected ? Color.black : Color.white)
                    .clipShape(Circle())
                    .frame(width: 40)
                
                Text(faceTimeAction.title.rawValue)
                    .foregroundStyle(.white)
                    .font(.system(size: 9))
            }
        })
    }
}
