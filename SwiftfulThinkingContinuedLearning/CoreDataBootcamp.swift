//
//  CoreDataBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-20.
//

import SwiftUI
import CoreData

// View - UI
// Model - data point
// ViewModel - manages the data for view

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading core data: \(error)")
            } else {
                print("Successfully loaded core data")
            }
        }
        
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching fruits: \(error)")
        }
    }
    
    func addFruit(name: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = name
        
        saveContext()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveContext()
    }
    
    func updateFruit(entity: FruitEntity) {
        
        let currentName = entity.name ?? ""
        let newName = currentName + "!!"
        entity.name = newName
        
        saveContext()
    }
    
    func saveContext() {
        
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving context: \(error)")
        }
        
    }
}

struct CoreDataBootcamp: View {
    
    @StateObject var vm = CoreDataViewModel()
    
    @State var newFruitName: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add a fruit", text: $newFruitName)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    
                    guard !newFruitName.isEmpty else { return }
                    
                    vm.addFruit(name: newFruitName)
                    newFruitName = ""
                    
                } label: {
                    Text("Add Fruit")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.pink)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                }
                
                List {
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "Unknown Fruit")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())

                
                Spacer()
            }
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    CoreDataBootcamp()
}
