//
//  HashableBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-13.
//

import SwiftUI

struct MyCustomModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableBootcamp: View {
    
    let data : [MyCustomModel] = [
       MyCustomModel(title: "Apple"),
        MyCustomModel(title: "Banana"),
        MyCustomModel(title: "Orange"),
        MyCustomModel(title: "Pineapple"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                
//                ForEach(data) { data in
//                    Text(data.title)
//                }
                
                ForEach(data, id: \.self) { item in
                    Text(item.title)
                }
            }
        }
    }
}

#Preview {
    HashableBootcamp()
}
