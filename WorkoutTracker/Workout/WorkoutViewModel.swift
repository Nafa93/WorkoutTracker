//
//  WorkoutViewModel.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 30/07/2024.
//

import Foundation
import UIKit

class WorkoutViewModel: NSObject {
    enum SectionType: Int, CaseIterable {
        case title, exercises

        var title: String {
            switch self {
            case .title:
                "Title"
            case .exercises:
                "Exercises"
            }
        }
    }

    var workout: Workout
    var sections: [SectionType] = SectionType.allCases

    init(workout: Workout) {
        self.workout = workout
    }

    func addSet(section: Int) {
        workout.exercises[section].sets.append(WorkoutSet())
    }

    func removeExercise(section: Int) {
        workout.exercises.remove(at: section)
    }

    func updateTitle(section: Int, newTitle: String) {
        workout.exercises[section].name = newTitle
    }
}
