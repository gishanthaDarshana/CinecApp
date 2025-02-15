//
//  File.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import SwiftUI

struct StudentForm : View {
    let actionText : String
    @Binding var studentId: String
    @Binding var studentName: String
    @Binding var studentDepartment: String
    
    let onAction : () -> Void
    
    var body: some View {
        VStack{
            TextField("Enter ID", text: $studentId)
                .roundedTextFieldStyle()
            TextField("Enter Department", text: $studentDepartment)
                .roundedTextFieldStyle()
            TextField("Enter Name", text: $studentName)
                .roundedTextFieldStyle()
            
            Button(action: {
                onAction()
            }) {
                Text(actionText)
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}

#Preview {
    StudentForm(actionText: "Test", studentId: .constant("qwerty"), studentName: .constant("ddddd"), studentDepartment: .constant("Depaaaa"), onAction: {
        
    })
}
