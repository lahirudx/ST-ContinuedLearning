//
//  DragGestureBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-07.
//

import SwiftUI

struct DragGestureBootcamp: View {
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            VStack {
                Text("\(offset.width), \(offset.height)")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                self.offset = value.translation
                            }
                            
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                self.offset = .zero
                            }
                        }
                )
        }
    }
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        return 1 - min(percentage, 0.5)
    }
    
    func getRotationAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: CGFloat = 10
        return percentageAsDouble * maxAngle
        
    }
}

#Preview {
    DragGestureBootcamp()
}
