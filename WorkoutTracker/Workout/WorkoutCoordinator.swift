//
//  WorkoutCoordinator.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 30/07/2024.
//

import Foundation
import UIKit

class WorkoutCoordinator: Coordinator {
    var navigationController: UINavigationController

    var childCoordinators: [any Coordinator]

    var workout: Workout

    var delegate: WorkoutViewControllerDelegate?

    init(navigationController: UINavigationController, childCoordinators: [any Coordinator] = [], workout: Workout, delegate: WorkoutViewControllerDelegate?) {
        self.navigationController = navigationController
        self.childCoordinators = childCoordinators
        self.workout = workout
        self.delegate = delegate
    }

    func start() {
        let viewController = WorkoutViewController()
        let viewModel = WorkoutViewModel(workout: workout)
        viewController.viewModel = viewModel
        viewController.coordinator = self
        viewController.delegate = delegate
        navigationController.pushViewController(viewController, animated: false)
    }

    func goBack() {
        navigationController.popViewController(animated: true)
    }

    func removeSelf() {
        self.childCoordinators.removeLast()
    }
}
