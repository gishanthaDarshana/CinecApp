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
    @Published var studentRollNo : String = ""
    // Navigation states
    @Published var navigateToDetails : Bool = false
    
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
    
    func deleteStudentDetail(id : String) {
        self.service.deleteStudent(from: "iOS", studentId: id) { deleteStatus in
            switch deleteStatus {
            case .success(let success):
                print("Delete Success")
            case .failure(let failure):
                print("Delete Failed : \(failure.localizedDescription)")
            }
        }
    }
    
    @MainActor
    private func addStudent() async {
        let newStudent : Student = Student(id: studentId, name: studentName, department: studentDepartment)
        do {
            try await service.addStudent(to: "iOS", student: newStudent)
            clearFields()
        } catch {
            print("Error in adding student : \(error)")
        }
    }
    
    private func clearFields() {
        self.studentId = ""
        self.studentName = ""
        self.studentDepartment = ""
    }
}
