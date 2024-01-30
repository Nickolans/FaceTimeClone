//
//  ContentView.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 10/27/23.
//

import SwiftUI
import Combine

struct HomeScreen: View {
    
    @State private var viewModel = HomeScreenViewModel()
    @State private var text = ""
    @State private var message = ""
    @State private var subscriptions = Set<AnyCancellable>()
    
    private let peer = PeerConnectivity(displayName: UUID().uuidString)
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack(spacing: 10) {
                    CustomButton(imageSystemName: "link", 
                                 text: "Create Link",
                                 action: viewModel.createLink)
                    
                    CustomButton(imageSystemName: "video.fill",
                                 text: "New FaceTime",
                                 action: viewModel.newFaceTime,
                                 color: Color.facetimeGreen2)
                }
                
                List(Call.mockCalls) { call in
                    CallCell(call: call)
                }
                .listStyle(.plain)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                Spacer()
            }
            .padding()
            .navigationTitle("FaceTime")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Edit")
                        .foregroundStyle(Color.facetimeGreen)
                }
            }
            .onAppear {
                peer.listenForMessages().sink { message in
                    DispatchQueue.main.async {
                        self.message = message
                    }
                }
                .store(in: &subscriptions)
            }
            .sheet(isPresented: $viewModel.showNewFaceTimeScreen) {
                NewFaceTimeScreen()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
