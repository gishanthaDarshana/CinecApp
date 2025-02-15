//
//  Student.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

struct StudentGroups : Codable{
    let iOS: [Student]
    let android: [Student]
}

struct Student: Codable, Identifiable {
    let id: String
    var name: String
    var department: String
    
    enum CodingKeys: String, CodingKey {
        case id = "studentId"
        case name
        case department
    }
}
