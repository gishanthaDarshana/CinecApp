//
//  StudentViewDetailViewModel.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import Foundation
class StudentViewDetailViewModel : ObservableObject{
    
    let service : DatabaseManaging
    
    init(service : DatabaseManaging = FirebaseRealtimeDBManager()){
        self.service = service
    }
    
    @Published var studentDetail : Student?
    @Published var studentId : String = ""
    @Published var studentName : String = ""
    @Published var studentDepartment : String = ""
    
    func fetchStudentDetail(id : String){
        Task {
            await getSpecificStudentDetail(student: id, from: "iOS")
        }
    }

    func updateStudentDetail() {
        let student = Student(id: studentId, name: studentName, department: studentDepartment)
        Task {
           await updateStudentDetail(student: student, from: "iOS")
        }
    }
    
    func deleteStudentDetail(id : String) {
        Task {
            await deleteStudentDetail(student: id, from: "iOS")
        }
    }
    
    @MainActor
    private func getSpecificStudentDetail(student : String , from : String) async {
        do {
            let student = try await self.service.getStudent(from: from, studentId: student)
            studentId = student.id
            studentName = student.name
            studentDepartment = student.department
        } catch {
            print("Student Detail can not fetched : \(error.localizedDescription)")
        }
        
    }
    
    @MainActor
    private func updateStudentDetail(student : Student , from : String) async {
        do {
            try await self.service.updateStudent(in: from, student: student)
            clearFields()
        } catch {
            print("Student Detail update failed : \(error.localizedDescription)")
        }
        
    }
    
    @MainActor
    private func deleteStudentDetail(student : String , from : String) async {
        do {
            try await self.service.deleteStudent(from: from, studentId: student)
            clearFields()
        } catch {
            print("Student Detail update failed : \(error.localizedDescription)")
        }
        
    }
    
    @MainActor
    private func clearFields() {
        studentId = ""
        studentName = ""
        studentDepartment = ""
    }
}
