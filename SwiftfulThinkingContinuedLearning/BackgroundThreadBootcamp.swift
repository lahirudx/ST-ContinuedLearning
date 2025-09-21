//
//  BackgroundThreadBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-21.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("Check 1: \(Thread.isMainThread)")
            print("Check 1: \(Thread.current)")
            
            DispatchQueue.main.async {
                
                print("Check 2: \(Thread.isMainThread)")
                print("Check 2: \(Thread.current)")
                
                self.dataArray = newData
            }
            
        }
        
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 1..<100 {
            data.append("\(x)")
            print(x)
        }
        
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    @StateObject private var vm: BackgroundThreadViewModel = .init()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("Load Data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(.red)
                }
                    
            }
        }
    }
}

#Preview {
    BackgroundThreadBootcamp()
}
