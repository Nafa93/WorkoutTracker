//
//  HomeViewController.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 30/07/2024.
//

import UIKit

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

    var workouts: [Workout]
    var sections: [SectionType] = SectionType.allCases

    init(workouts: [Workout]) {
        self.workouts = workouts
    }
}

class HomeViewController: UIViewController {
    var viewModel: HomeViewModel?
    var coordinator: HomeCoordinator?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "WorkoutTableViewCell", bundle: nil), forCellReuseIdentifier: "WorkoutTableViewCell")
        tableView.register(UINib(nibName: "CreateWorkoutTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateWorkoutTableViewCell")
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
            return viewModel?.workouts.count ?? 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel?.sections[section].title ?? "No title"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeViewModel.SectionType(rawValue: indexPath.section) else { return UITableViewCell() }

        switch section {
        case .create:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CreateWorkoutTableViewCell", for: indexPath) as? CreateWorkoutTableViewCell {
                return cell
            } else {
                return CreateWorkoutTableViewCell()
            }
        case .workouts:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTableViewCell", for: indexPath) as? WorkoutTableViewCell,
               let workout = viewModel?.workouts[indexPath.row] {
                cell.setup(workout)
                return cell
            } else {
                return WorkoutTableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = HomeViewModel.SectionType(rawValue: indexPath.section) else { return }

        switch section {
        case .create:
            coordinator?.navigateToWorkout(workout: Workout(), delegate: self)
        case .workouts:
            guard let workout = viewModel?.workouts[indexPath.row] else { return }
            coordinator?.navigateToWorkout(workout: workout, delegate: self)
        }
    }
}

extension HomeViewController: WorkoutViewControllerDelegate {
    func workoutDidChange(_ workout: Workout) {
        if let workoutIndex = viewModel?.workouts.firstIndex(where: { $0.id == workout.id }) {
            viewModel?.workouts[workoutIndex] = workout
        } else {
            viewModel?.workouts.append(workout)
        }

        tableView.reloadData()
    }
}
