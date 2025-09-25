//
//  TimerBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-25.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
//    @State var currentDate = Date()
    
//    @State var count: Int = 10
    
//    @State var timeRemaining: String = ""
//    let futureDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
//    
//    func updateTimeRemaining() {
//        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
//        let minutes = remaining.minute ?? 0
//        let seconds = remaining.second ?? 0
//        timeRemaining = "\(minutes):\(seconds)"
//    }
    
    
    @State var count: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [
                    Color(red: 94/255.0, green: 38/255.0, blue: 251/255.0),  // #5E26FB
                    Color(red: 22/255.0, green: 5/255.0, blue: 78/255.0)     // #16054E
                ]),
                center: .center,
                startRadius: 0,
                endRadius: 400
            )
            .ignoresSafeArea()
            
            HStack(spacing: 15) {
                Circle()
                    .offset(y: count == 1 ? -20 : 0)
                Circle()
                    .offset(y: count == 2 ? -20 : 0)
                Circle()
                    .offset(y: count == 1 ? -20 : 0)
            }
            .frame(width: 200)
            .foregroundStyle(.white)
        }
        .onReceive(timer) { value in
            withAnimation(.easeInOut(duration: 0.5)) {
                count = count == 3 ? 0 : count+1
            }
        }
    }
}

#Preview {
    TimerBootcamp()
}
