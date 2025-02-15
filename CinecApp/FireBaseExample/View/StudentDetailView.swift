//
//  StudentDetailView.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import SwiftUI

struct StudentDetailView: View {
    @StateObject var detailViewModel = StudentViewDetailViewModel()
    
    let studentId : String
    
    var body: some View {
        VStack (spacing : .zero){
            StudentForm(
                actionText: "Update",
                studentId: $detailViewModel.studentId,
                studentName: $detailViewModel.studentName,
                studentDepartment: $detailViewModel.studentDepartment,
                onAction: {
                    detailViewModel.updateStudentDetail()
                }
            )
            
            Button(action: {
                detailViewModel.deleteStudentDetail(id: studentId)
            }) {
                Text("Delete Student")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .padding()
        }
        
        .onAppear {
            detailViewModel.fetchStudentDetail(id: studentId)
        }
    }
}

#Preview {
    StudentDetailView(studentId: "323")
}
