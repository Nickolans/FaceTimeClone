//
//  CustomButton.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 10/28/23.
//

import Foundation
import SwiftUI

struct CustomButton: View {
    
    let imageSystemName: String
    let text: String
    let action: () -> ()
    let color: Color?
    
    init(imageSystemName: String, text: String, action: @escaping () -> Void, color: Color? = nil) {
        self.imageSystemName = imageSystemName
        self.text = text
        self.action = action
        self.color = color
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: imageSystemName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25)
                
                Text(text)
                    .bold()
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.white)
        }
        .background((color != nil) ? color : Color.white.opacity(0.20))
        .frame(maxWidth: .infinity, maxHeight: 80)
        .clipShape(.rect(cornerRadius: 15))
    }
}
