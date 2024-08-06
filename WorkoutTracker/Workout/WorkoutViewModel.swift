//
//  WorkoutViewModel.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 30/07/2024.
//

import Foundation
import UIKit

class WorkoutViewModel: NSObject {
    var title: String {
        get {
            return workout.title
        } set {
            workout.title = newValue
        }
    }

    var exercisesCount: Int {
        workout.exercises.count
    }

    private(set) var workout: Workout

    init(workout: Workout) {
        self.workout = workout
    }

    func setsCount(for section: Int) -> Int {
        workout.exercises[section].sets.count
    }

    func set(for indexPath: IndexPath) -> WorkoutSet {
        workout.exercises[indexPath.section].sets[indexPath.row]
    }

    func exerciseName(for section: Int) -> String {
        workout.exercises[section].name
    }

    func addExercise() {
        workout.exercises.append(Exercise())
    }

    func addSet(section: Int) {
        workout.exercises[section].sets.append(WorkoutSet())
    }

    func updateExerciseName(section: Int, name: String) {
        workout.exercises[section].name = name
    }

    func updateReps(at indexPath: IndexPath, reps: Int) {
        workout.exercises[indexPath.section].sets[indexPath.row].repetitions = reps
    }

    func updateWeight(at indexPath: IndexPath, weight: Double) {
        workout.exercises[indexPath.section].sets[indexPath.row].weight = .init(value: weight, unit: .kilograms)
    }

    func removeExercise(section: Int) {
        workout.exercises.remove(at: section)
    }
}
