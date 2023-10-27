//
//  CallCell.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 10/28/23.
//

import Foundation
import SwiftUI

struct CallCell: View {
    
    let call: Call
    
    var body: some View {
        HStack {
            
            ZStack {
                Circle()
                    .frame(width: 30)
                    .foregroundStyle(LinearGradient(colors: [Color.gray, Color.darkGray],
                                                    startPoint: .top,
                                                    endPoint: .bottom))
                
                Text(String(call.name[call.name.startIndex]))
                    .bold()
            }
            
            
            VStack {
                Text(call.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                FaceTimeTypeView(type: call.type)
            }
            .multilineTextAlignment(.leading)
            
            
            Spacer()
            
            Text(call.startDate.formatted(date: .numeric, time: .omitted))
            Button(action: {
                //
            }, label: {
                Image(systemName: "info.circle")
                    .foregroundStyle(Color.facetimeGreen)
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20)
        .padding(.bottom, 20)
        .listRowInsets(EdgeInsets())
    }
}
