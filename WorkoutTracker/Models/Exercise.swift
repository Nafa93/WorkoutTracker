//
//  Exercise.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 30/07/2024.
//

import Foundation

struct Exercise: Hashable, Equatable, Identifiable, Codable {
    var id: UUID
    var name: String
    var sets: [WorkoutSet]

    init(id: UUID = UUID(), name: String, sets: [WorkoutSet]) {
        self.id = id
        self.name = name
        self.sets = sets
    }

    init() {
        self.init(name: "Exercise Name", sets: [.init()])
    }
}
