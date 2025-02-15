//
//  RealTimeFetchList.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import SwiftUI

struct StudentsList: View {
    @StateObject private var fetchListViewModel = RealTimeListViewModel()
    
    var body: some View {
        VStack {
            List(fetchListViewModel.students) { student in
                
                NavigationLink {
                    StudentDetailView(studentId: student.id)
                } label: {
                    Text(student.name)
                }

            }
            .onAppear {
                fetchListViewModel.fetchStudents()
            }
            
            Divider()
            
            
            StudentForm(
                actionText: "Add",
                studentId: $fetchListViewModel.studentId,
                studentName: $fetchListViewModel.studentName,
                studentDepartment: $fetchListViewModel.studentDepartment,
                onAction: {
                    fetchListViewModel.addStudent()
                }
            )
        }
        
    }
}

#Preview {
    StudentsList()
}
