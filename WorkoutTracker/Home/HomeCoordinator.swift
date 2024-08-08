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
        let repository = WorkoutRepository(gateway: LocalGateway<Workout>(fileName: "workouts"))
        let viewModel = HomeViewModel(workoutRepository: repository)
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
