//
//  SwiftUIView.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 10/29/23.
//

import SwiftUI

extension View {
    func leadingInfinite() -> some View {
        return self.frame(maxWidth: .infinity, alignment: .leading)
    }
}
