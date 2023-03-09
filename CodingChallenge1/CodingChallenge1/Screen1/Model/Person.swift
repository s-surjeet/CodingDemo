//
//  Person.swift
//  CodingChallenge1
//
//  Created by Surjeet on 09/03/23.
//

import Foundation
import SwiftUI

enum Priority: String {
    case Low = "low"
    case Medium = "mid"
    case High = "high"
    
    var imageIcon: String {
        switch self {
        case .Low:
            return "exclamationmark.triangle"
        case .Medium:
            return "exclamationmark.circle"
        case .High:
            return "exclamationmark.shield"
        }
    }
    
    var imgColor: Color {
        switch self {
        case .Low:
            return .yellow
        case .Medium:
            return .orange
        case .High:
            return .red
        }
    }
}


struct Person: Identifiable, Decodable {
    let id: String?
    
    var firstName: String?
    var lastName: String?
    
    var age: Int?
    var priority: String?
    
    var email: String?
    var phoneNumber: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName, lastName
        case age
        case priority
        case email, phoneNumber
    }
    
    func getPriority() -> Priority {
        return Priority(rawValue: self.priority ?? "") ?? .Low
    }
}


struct Todo: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted = false
}
