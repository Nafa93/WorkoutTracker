//
//  WorkoutRepository.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 08/08/2024.
//

import Foundation

class WorkoutRepository {
    let gateway: any Gateway<Workout>

    init(gateway: any Gateway<Workout>) {
        self.gateway = gateway
    }

    func save(_ workouts: [Workout]) {
        do {
            try self.gateway.save(workouts)
        } catch {
            print(error)
        }
    }

    func load() -> [Workout] {
        do {
            return try self.gateway.load()
        } catch {
            print(error)
            return []
        }
    }
}
