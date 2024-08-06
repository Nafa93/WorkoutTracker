//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 30/07/2024.
//

import Foundation

struct Workout: Hashable, Equatable, Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var exercises: [Exercise]

    init(title: String, exercises: [Exercise]) {
        self.title = title
        self.exercises = exercises
    }

    init() {
        self.init(title: "Empty Workout", exercises: [Exercise()])
    }
}
