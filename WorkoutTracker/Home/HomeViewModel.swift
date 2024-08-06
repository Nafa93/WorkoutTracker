//
//  HomeViewModel.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 06/08/2024.
//

import Foundation

class HomeViewModel {
    enum SectionType: Int, CaseIterable {
        case create, workouts

        var title: String {
            switch self {
            case .create:
                "Create"
            case .workouts:
                "Workouts"
            }
        }
    }

    var workoutCount: Int {
        return workouts.count
    }

    var sectionCount: Int {
        return sections.count
    }

    private var workouts: [Workout]
    private var sections: [SectionType] = SectionType.allCases

    init(workouts: [Workout]) {
        self.workouts = workouts
    }

    func workout(for row: Int) -> Workout {
        workouts[row]
    }

    func sectionTitle(for section: Int) -> String {
        sections[section].title
    }

    func upsert(_ workout: Workout) {
        if let workoutIndex = workouts.firstIndex(where: { $0.id == workout.id }) {
            workouts[workoutIndex] = workout
        } else {
            workouts.append(workout)
        }
    }
}
