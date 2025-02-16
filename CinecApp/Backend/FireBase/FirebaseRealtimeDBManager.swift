//
//  FirebaseRealtimeDBManager.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import Foundation
import Firebase
import FirebaseDatabaseInternal


class FirebaseRealtimeDBManager: DatabaseManaging {
    private var databaseRef: DatabaseReference
    private var observers: [DatabaseHandle] = []
    
    init(databaseRef: DatabaseReference = Database.database(url: AppConst.databaseURL).reference()) {
        self.databaseRef = databaseRef
    }
    
    func fetchStudents(completion: @escaping (Result<StudentGroups, DatabaseError>) -> Void) {
        // Start observing the "students" node in Firebase
        let handle = databaseRef.child("students").observe(.value) { snapshot in
            // Check if the snapshot contains data in the expected format
            guard let value = snapshot.value as? [String: Any] else {
                completion(.success(StudentGroups(iOS: [], android: [])))
                return
            }
            
            // Parse the students for iOS and Android categories using your custom parsing method
            let iosStudents = self.parseStudents(from: value, key: "iOS")
            let androidStudents = self.parseStudents(from: value, key: "android")
            
            // Create a StudentGroups object with the parsed data
            let studentGroups = StudentGroups(iOS: iosStudents, android: androidStudents)
            
            // Return the result via the completion handler
            completion(.success(studentGroups))
        }
        
        // Keep track of the observer handle so we can remove it later if needed
        observers.append(handle)
    }
    
    
    
    // Add a new student to a specified category
    func addStudent(to category: String, student: Student) async throws {
        let studentRef = databaseRef.child("students/\(category)/\("SID:"+student.id)")
        
        let studentData: [String: Any] = [
            "studentId": "SID:"+student.id,
            "name": student.name,
            "department": student.department
        ]
        
        do {
            try await studentRef.setValue(studentData)
        } catch {
            throw DatabaseError.unknownError(error)
        }
    }
    
    // Update an existing student's information in a specified category
    func updateStudent(in category: String, student: Student) async throws {
        let studentRef = databaseRef.child("students/\(category)/\(student.id)")
        
        let studentData: [String: Any] = [
            "studentId": student.id,
            "name": student.name,
            "department": student.department
        ]
        
        do {
            try await studentRef.setValue(studentData)
        } catch {
            throw DatabaseError.unknownError(error)
        }
    }
    
    // Delete a student by their studentId from a specified category not updates realtime
    func deleteStudent(from category: String, studentId: String) async throws {
        let studentRef = databaseRef.child("students/\(category)/\(studentId)")
        
        do {
            try await studentRef.removeValue()
        } catch {
            throw DatabaseError.unknownError(error)
        }
    }
    
    // Delete a student by their studentId from a specified category while keeps realtime update
    func deleteStudent(from category: String, studentId: String, completion: @escaping (Result<Void, DatabaseError>) -> Void) {
        self.databaseRef.child("students/\(category)/\(studentId)").removeValue { error, _ in
            if let error = error {
                completion(.failure(.unknownError(error)))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // Get a specific student by their studentId from a specified category
    func getStudent(from category: String, studentId: String) async throws -> Student {
        let ref = databaseRef.child("students/\(category)/\(studentId)")
        
        return try await withCheckedThrowingContinuation { continuation in
            ref.observeSingleEvent(of: .value) { snapshot in
                guard let value = snapshot.value as? [String: Any] else {
                    continuation.resume(throwing: DatabaseError.decodingError)
                    return
                }
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let student = try JSONDecoder().decode(Student.self, from: jsonData)
                    continuation.resume(returning: student)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    
    
    private func parseStudents(from value: [String: Any], key: String) -> [Student] {
        var students: [Student] = []
        
        // Check if the platform data exists (like "iOS" or "android")
        if let platformData = value[key] as? [String: Any] {
            // Iterate through each student entry under this platform (the key like "Test", "Alice", etc.)
            for (_, studentData) in platformData {
                // Ensure the data is in the expected dictionary format
                if let studentDict = studentData as? [String: Any],
                   let name = studentDict["name"] as? String,
                   let studentId = studentDict["studentId"] as? String,
                   let department = studentDict["department"] as? String {
                    // Create a Student object and append it to the array
                    let student = Student(id: studentId, name: name, department: department)
                    students.append(student)
                }
            }
        }
        
        return students
        
    }
    
    deinit {
        for handle in observers {
            databaseRef.removeObserver(withHandle: handle)
        }
    }
}
