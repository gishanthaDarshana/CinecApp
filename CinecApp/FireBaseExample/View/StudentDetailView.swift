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
                studentDepartment: $detailViewModel.studentDepartment, dissableStudentIdField: .constant(true),
                onAction: {
                    detailViewModel.updateStudentDetail()
                }
            )
        }
        
        .onAppear {
            detailViewModel.fetchStudentDetail(id: studentId)
        }
    }
}

#Preview {
    StudentDetailView(studentId: "323")
}
