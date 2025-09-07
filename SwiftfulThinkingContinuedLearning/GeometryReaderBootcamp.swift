//
//  GeometryReaderBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-07.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .rotation3DEffect(Angle(degrees: getPercentage(of: geometry) * 40), axis: (x: 0, y: 1, z: 0))
                           
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                        
                }
            }
        }
        
//        GeometryReader { geometry in
//            HStack(spacing: 0.0) {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: geometry.size.width * 0.6666)
//                
//                Rectangle()
//                    .fill(.blue)
//            }
//            .ignoresSafeArea()
//        }
    }
    
    func getPercentage(of geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let distance = geo.frame(in: .global).midX
        return Double(1 - (distance / maxDistance))
    }
}

#Preview {
    GeometryReaderBootcamp()
}
