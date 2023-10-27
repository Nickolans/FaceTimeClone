//
//  FaceTimeTypeView.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 10/29/23.
//

import Foundation
import SwiftUI

struct FaceTimeTypeView: View {
    
    let type: FaceTimeType
    
    var body: some View {
        HStack {
            Image(systemName: imageSystemName())
            Text(name())
        }
        .font(.system(size: 10))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func imageSystemName() -> String {
        return switch type {
        case .audio:
            "phone.arrow.down.left.fill"
        case .video:
            "video.fill"
        }
    }
    
    private func name() -> String {
        return switch type {
        case .audio:
            "FaceTime Audio"
        case .video:
            "FaceTime Video"
        }
    }
}
