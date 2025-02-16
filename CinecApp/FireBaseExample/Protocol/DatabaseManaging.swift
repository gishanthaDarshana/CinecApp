//
//  DatabaseManaging.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

enum DatabaseError: Error {
    case decodingError
    case unknownError(Error)
}

protocol DatabaseManaging {
    func fetchStudents(completion: @escaping (Result<StudentGroups, DatabaseError>) -> Void)
    func addStudent(to category: String, student: Student) async throws  
    func updateStudent(in category: String, student: Student) async throws
    func deleteStudent(from category: String, studentId: String) async throws
    func deleteStudent(from category: String, studentId: String, completion: @escaping (Result<Void, DatabaseError>) -> Void)
    func getStudent(from category : String , studentId : String) async throws -> Student
}
