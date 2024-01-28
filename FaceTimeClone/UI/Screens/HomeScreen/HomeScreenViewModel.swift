//
//  HomeScreenViewModel.swift
//  FaceTimeClone
//
//  Created by Nickolans Griffith on 10/28/23.
//

import Foundation
import SwiftUI

@Observable class HomeScreenViewModel {
    func createLink() {
        //
    }
    
    func newFaceTime() {
        // 
    }
    
    private func fetchCallHistory() {
        let request = FaceTimeCall.fetchRequest()
        request.predicate = NSPredicate(format: "date <= %@", NSDate())
        let context = PersistenceController.shared.container.viewContext
        
        do {
            let calls = try context.fetch(request)
        } catch {
            // Error
        }
    }
}
