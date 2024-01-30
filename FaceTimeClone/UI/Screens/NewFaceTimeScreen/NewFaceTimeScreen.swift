//
//  NewFaceTimeScreen.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 1/29/24.
//

import Foundation
import SwiftUI

struct NewFaceTimeScreen: View {
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                
                Button {
                    //
                } label: {
                    HStack {
                        Text("Noah Reed")
                            .foregroundStyle(Color.white)
                        Spacer()
                        Image(systemName: "phone.fill")
                            .foregroundStyle(Color.facetimeGreen)
                    }
                    .padding(15)
                    .background(Color.darkGray.opacity(0.5))
                    .clipShape(.rect(cornerRadius: 15))
                }
                
                
                
                Spacer()
            }
            .padding(15)
            .navigationTitle("New FaceTime")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(Color.facetimeGreen)
                    }
                }
            }
        }
    }
}

#Preview {
    NewFaceTimeScreen()
}
