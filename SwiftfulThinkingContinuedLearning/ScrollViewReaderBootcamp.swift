//
//  ScrollViewReaderBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-07.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State private var scrollToIndex: Int? = 0
    @State private var gotoIndexString: String = ""
    
    var body: some View {
        VStack {
            
            TextField("Enter a # to go to", text: $gotoIndexString)
                .padding()
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("Go to #49") {
                
                withAnimation(.spring()) {
                    if let scrollToIndex = Int(gotoIndexString) {
                        self.scrollToIndex = scrollToIndex
                    }
                    
//                    proxy.scrollTo(44, anchor: .center)
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    
                    
                    
                    ForEach(0..<50) { index in
                        Text("this is Item \(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { _, newValue in
                        withAnimation(.spring()) {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderBootcamp()
}
