//
//  TypeAliasBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-21.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

struct TypeAliasBootcamp: View {
    
    @State var item: MovieModel = MovieModel(title: "Inception", director: "Christopher Nolan", count: 5)
    
    var body: some View {
        VStack {
            Text(item.title)
                .font(.largeTitle)
            Text(item.director)
                .font(.title)
            Text("\(item.count) likes")
        }
    }
}

#Preview {
    TypeAliasBootcamp()
}
