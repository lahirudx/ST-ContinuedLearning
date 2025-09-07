//
//  MultipleSheetsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-07.
//

import SwiftUI

struct RandomModel: Identifiable {
    var id = UUID().uuidString
    var title: String
}

// 1. use binding
// 2. use multiple sheets at same level views.
// 3. use $item (scalable)

struct MultipleSheetsBootcamp: View {
    
    @State var selectedModel: RandomModel = .init(title: "Starting Title")
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 20.0) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "One")
                showSheet.toggle()
            }
            
            Button("Button 2") {
                selectedModel = RandomModel(title: "Two")
                showSheet.toggle()
            }
        }
        .sheet(isPresented: $showSheet) {
            NextScreen(selectedModel: $selectedModel)
        }
    }
}

struct NextScreen: View {
    
    @Binding var selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetsBootcamp()
}
