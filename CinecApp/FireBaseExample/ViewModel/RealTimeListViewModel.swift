//
//  RealTimeListViewModel.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import Foundation
class RealTimeListViewModel : ObservableObject{
    let service : DatabaseManaging
    
    init(service : DatabaseManaging = FirebaseRealtimeDBManager()){
        self.service = service
    }
    
    @Published var students : [Student] = []
    
    @Published var studentId : String = ""
    @Published var studentName : String = ""
    @Published var studentDepartment    : String = ""
    
    func fetchStudents(){
        service.fetchStudents { students in
            switch students{
                case .success(let students):
                self.students = students.iOS
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
    
    func addStudent() {
        Task {
            await addStudent()
        }
    }
    
    @MainActor
    private func addStudent() async {
        let newStudent : Student = Student(id: studentId, name: studentName, department: studentDepartment)
        do {
            try await service.addStudent(to: "iOS", student: newStudent)
            studentId = ""
            studentName = ""
            studentDepartment = ""
        } catch {
            print("Error in adding student : \(error)")
        }
    }
}
