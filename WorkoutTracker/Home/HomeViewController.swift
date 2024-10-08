//
//  HomeViewController.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 30/07/2024.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!

    var viewModel: HomeViewModel?
    var coordinator: HomeCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.load()

        tableView.register(WorkoutTableViewCell.self)
        tableView.register(CreateWorkoutTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HomeViewModel.SectionType(rawValue: section) else { return 0 }

        switch section {
        case .create:
            return 1
        case .workouts:
            return viewModel?.workoutCount ?? 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sectionCount ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel?.sectionTitle(for: section) ?? "No title"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeViewModel.SectionType(rawValue: indexPath.section) else { return UITableViewCell() }

        switch section {
        case .create:
            let cell = tableView.dequeueReusableCell(CreateWorkoutTableViewCell.self, indexPath: indexPath)
            cell.setup()
            return cell
        case .workouts:
            guard let workout = viewModel?.workout(for: indexPath.row) else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(WorkoutTableViewCell.self, indexPath: indexPath)
            cell.setup(workout)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = HomeViewModel.SectionType(rawValue: indexPath.section) else { return }

        switch section {
        case .create:
            coordinator?.navigateToWorkout(workout: Workout(), delegate: self)
        case .workouts:
            guard let workout = viewModel?.workout(for: indexPath.row) else { return }
            coordinator?.navigateToWorkout(workout: workout, delegate: self)
        }
    }
}

extension HomeViewController: WorkoutViewControllerDelegate {
    func onWorkoutDidChange(_ workout: Workout) {
        viewModel?.upsert(workout)
        tableView.reloadData()
    }
}
