//
//  LongPressGestureBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-06.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State private var isComplete: Bool = false
    @State private var isSuccess: Bool = false
    
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)
            
            HStack {
                Text("Press Here")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1, maximumDistance: 50) { isPressing in
                        
                        // start to press -> min duration
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1)) {
                                isComplete.toggle()
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                        
                    } perform: {
                        withAnimation(.easeInOut) {
                            isSuccess.toggle()
                        }
                    }

                
                Text("Reset")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isSuccess = false
                        isComplete = false
                    }
            }
        }
        
//        Text(isComplete ? "Long Press Completed" : "Long Press")
//            .padding()
//            .padding(.horizontal)
//            .background( isComplete ? Color.green : Color.gray)
//            .cornerRadius(20)
////            .onTapGesture {
////                isComplete.toggle()
////            }
//            .onLongPressGesture(minimumDuration: 3, maximumDistance: 1) {
//                isComplete.toggle()
//            }
        
    }
}

#Preview {
    LongPressGestureBootcamp()
}
