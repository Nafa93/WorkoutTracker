//
//  HomeCoordinator.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 30/07/2024.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator]

    init(navigationController: UINavigationController, childCoordinators: [any Coordinator] = []) {
        self.navigationController = navigationController
        self.childCoordinators = childCoordinators
    }

    func start() {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel(workouts: [
            Workout(
                title: "Push #1",
                exercises: [
                    Exercise(
                        name: "Bench Press",
                        sets: [
                            WorkoutSet(
                                weight: .init(value: 100, unit: .kilograms),
                                repetitions: 10
                            )
                        ]
                    ),
                    Exercise(
                        name: "Dumbell Fly",
                        sets: [
                            WorkoutSet(
                                weight: .init(value: 100, unit: .kilograms),
                                repetitions: 10
                            ),
                            WorkoutSet(
                                weight: .init(value: 100, unit: .kilograms),
                                repetitions: 10
                            )
                        ]
                    )
                ]
            )
        ])
        viewController.viewModel = viewModel
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }

    func navigateToWorkout(workout: Workout, delegate: WorkoutViewControllerDelegate?) {
        let coordinator = WorkoutCoordinator(
            navigationController: navigationController,
            workout: workout,
            delegate: delegate
        )

        childCoordinators.append(coordinator)

        coordinator.childCoordinators = childCoordinators

        coordinator.start()
    }
}
