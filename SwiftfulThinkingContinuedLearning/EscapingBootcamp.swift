//
//  EscapingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-21.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    @Published var text: String = "Hello"
    
    func getData() {
        downloadData2 { [weak self] res in
            self?.text = res.data
        }
    }
    
    func downloadData() -> String {
        return "New Data!"
    }
    
    func downloadData2(completionHandler: @escaping DownloadHandler) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler(DownloadResult(data: "New Data 2!"))
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadHandler = (DownloadResult) -> ()

struct EscapingBootcamp: View {
    
    @StateObject private var vm: EscapingViewModel = .init()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingBootcamp()
}
