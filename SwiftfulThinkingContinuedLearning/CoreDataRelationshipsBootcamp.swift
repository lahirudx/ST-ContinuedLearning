//
//  CoreDataRelationshipsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-21.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                print("Error loading Core Data: \(error)")
            }
        }
        context = container.viewContext
    }
    
    func saveContext() {
        do {
            try context.save()
            print("Context saved successfully")
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipsViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init () {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses() {
        let request: NSFetchRequest<BusinessEntity> = BusinessEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)]
//        let filter = NSPredicate(format: "name == %@", "Facebook")
//        request.predicate = filter
        
        do {
            businesses = try manager.context.fetch(request)
        } catch {
            print("Error fetching businesses: \(error.localizedDescription)")
        }
    }
    
    func getDepartments() {
        let request: NSFetchRequest<DepartmentEntity> = DepartmentEntity.fetchRequest()
        
        do {
            departments = try manager.context.fetch(request)
        } catch {
            print("Error fetching departments: \(error.localizedDescription)")
        }
    }
    
    func getEmployees() {
        let request: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
        
        do {
            employees = try manager.context.fetch(request)
        } catch {
            print("Error fetching employees: \(error.localizedDescription)")
        }
    }
    
    func getEmployees(for business: BusinessEntity) {
        let request: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        
        do {
            employees = try manager.context.fetch(request)
        } catch {
            print("Error fetching employees: \(error.localizedDescription)")
        }
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
//        newBusiness.departments = [departments[0], departments[3]]
//        newBusiness.employees = [employees[0], employees[2]]
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Enineeering"
//        newDepartment.businesses = [businesses[0]]
        
        newDepartment.addToEmployees(employees[2])
        
        
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Emily"
        newEmployee.dateJoined = Date()
        newEmployee.age = 54
//        newEmployee.department = departments[0]
//        newEmployee.business = businesses[0]
        
        save()
    }
    
    func deleteDepartment() {
        let department = departments[0]
        manager.context.delete(department)
        save()
    }
    
    func save() {
        
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.manager.saveContext()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
    }
    
    
}

struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
                        vm.deleteDepartment()
                    } label: {
                        Text("Perform Action")
                            .foregroundStyle(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(business: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(department: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(employee: employee)
                            }
                        }
                    }

                }
                .padding()
            }
        }
    }
}

#Preview {
    CoreDataRelationshipsBootcamp()
}

struct BusinessView: View {
    
    let business: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(business.name ?? "N/A")")
                .bold()
            
            if let departments = business.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "N/A")
                }
            }
            
            if let employees = business.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text((employee.name ?? "N/A"))
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View {
    
    let department: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(department.name ?? "N/A")")
                .bold()
            
            if let businesses = department.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses:")
                    .bold()
                ForEach(businesses) { businesse in
                    Text(businesse.name ?? "N/A")
                }
            }
            
            if let employees = department.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text((employee.name ?? "N/A"))
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct EmployeeView: View {
    
    let employee: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(employee.name ?? "N/A")")
                .bold()
            Text("Age: \(employee.age)")
            Text("Date Joined: \(employee.dateJoined?.formatted() ?? "N/A")")
            
            Text("Business:")
                .bold()
            Text(employee.business?.name ?? "")
            
            Text("Department:")
                .bold()
            Text(employee.department?.name ?? "")
            
            
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
