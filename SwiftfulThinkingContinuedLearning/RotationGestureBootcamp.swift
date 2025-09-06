//
//  RotationGestureBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-06.
//

import SwiftUI

struct RotationGestureBootcamp: View {
    
    @State var angle: Angle = .degrees(0)
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(50)
            .background(.blue)
            .cornerRadius(20)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged { rotation in
                        print("Rotation: \(rotation)")
                        angle = rotation
                    }
                    .onEnded { _ in
                        withAnimation {
                            angle = .degrees(0)
                        }
                    }
            )
        
    }
}

#Preview {
    RotationGestureBootcamp()
}
