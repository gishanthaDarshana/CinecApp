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
                HStack {
                    HStack{
                        Image(systemName: "person.circle")
                        
                        Text(student.name)
                        
                        Spacer()
                    }
                    .padding()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        fetchListViewModel.studentRollNo = student.id
                        fetchListViewModel.navigateToDetails.toggle()
                    }
                    
                    Button {
                        fetchListViewModel.deleteStudentDetail(id: student.id)
                    } label: {
                        Text("Delete")
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
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
                studentDepartment: $fetchListViewModel.studentDepartment, dissableStudentIdField: .constant(false),
                onAction: {
                    fetchListViewModel.addStudent()
                }
            )
        }
        .background(
            NavigationLink(destination: StudentDetailView(studentId: fetchListViewModel.studentRollNo), isActive: $fetchListViewModel.navigateToDetails, label: {
                EmptyView()
            })
        )
    }
}

#Preview {
    StudentsList()
}
