//
//  ArraysBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-13.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    @Published var dataArray: [UserModel] = []
    @Published var filteredDataArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Lahiru", points: 4, isVerified: true)
        let user2 = UserModel(name: "Saman", points: 80, isVerified: true)
        let user3 = UserModel(name: nil, points: 30, isVerified: true)
        let user4 = UserModel(name: "Kavindu", points: 71, isVerified: false)
        let user5 = UserModel(name: "Thilanga", points: 64, isVerified: false)
        let user6 = UserModel(name: "Asanka", points: 50, isVerified: false)
        let user7 = UserModel(name: "Ravindu", points: 45, isVerified: true)
        let user8 = UserModel(name: nil, points: 30, isVerified: true)
        let user9 = UserModel(name: "Pradeep", points: 20, isVerified: true)
        let user10 = UserModel(name: "Dilshan", points: 98, isVerified: false)
        
        dataArray.append(
            contentsOf: [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10]
        )
        
        
    }
    
    func updateFilteredArray() {
        // sort
//        filteredDataArray = dataArray.sorted { $0.points > $1.points }
        
        // filter
//        filteredDataArray = dataArray.filter { $0.isVerified }
        
        // map
//        mappedArray = dataArray.map { $0.name }
        
        // compactMap
//        mappedArray = dataArray.compactMap(\.name)
        
        mappedArray = dataArray
            .sorted(by: { $0.points > $1.points })
            .filter { $0.isVerified }
            .compactMap(\.name)
        
    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm: ArrayModificationViewModel = .init()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
                
//                ForEach(vm.filteredDataArray) { user in
//                    VStack(alignment: .leading) {
//                        Text("\(user.name)")
//                            .font(.headline)
//                        HStack {
//                            Text("\(user.points) points")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundStyle(.white)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(10)
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

#Preview {
    ArraysBootcamp()
}
