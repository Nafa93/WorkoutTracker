//
//  WorkoutViewController.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 30/07/2024.
//

import UIKit

protocol WorkoutViewControllerDelegate: AnyObject {
    func workoutDidChange(_ workout: Workout)
}

class WorkoutViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var setsTableView: UITableView!

    var viewModel: WorkoutViewModel?
    var coordinator: WorkoutCoordinator?
    var delegate: WorkoutViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTableView()
        setupTitleTextField()
    }

    override func viewWillDisappear(_ animated: Bool) {
        coordinator?.removeSelf()
    }

    private func setupNavigationBar() {
        let button = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(onSavePressed))
        self.navigationItem.setRightBarButton(button, animated: false)
    }

    private func setupTableView() {
        setsTableView.register(
            UINib(nibName: "WorkoutSetTableViewCell", bundle: nil), 
            forCellReuseIdentifier: "WorkoutSetTableViewCell"
        )
        setsTableView.register(
            UINib(nibName: "ExerciseHeader", bundle: nil),
            forHeaderFooterViewReuseIdentifier: "ExerciseHeader"
        )
        setsTableView.register(
            UINib(nibName: "ExerciseFooter", bundle: nil),
            forHeaderFooterViewReuseIdentifier: "ExerciseFooter"
        )
        setsTableView.dataSource = self
        setsTableView.delegate = self
    }

    private func setupTitleTextField() {
        titleTextField.text = viewModel?.workout.title
    }

    @objc func onSavePressed() {
        guard let workout = viewModel?.workout else { return }
        delegate?.workoutDidChange(workout)
        coordinator?.goBack()
    }

    @IBAction func titleEditingDidEnd(_ sender: Any) {
        guard let title = titleTextField.text else { return }
        viewModel?.workout.title = title
    }

    @IBAction func onAddExercisePressed(_ sender: Any) {
        viewModel?.workout.exercises.append(Exercise())
        setsTableView.reloadData()
    }
}

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.workout.exercises.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.workout.exercises[section].sets.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutSetTableViewCell", for: indexPath) as? WorkoutSetTableViewCell,
           let set = viewModel?.workout.exercises[indexPath.section].sets[indexPath.row]{
            cell.setup(set, indexPath: indexPath)
            cell.delegate = self
            return cell
        } else {
            return WorkoutSetTableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = setsTableView.dequeueReusableHeaderFooterView(withIdentifier: "ExerciseHeader") as? ExerciseHeader
        header?.delegate = self
        header?.configureHeader(
            title: viewModel?.workout.exercises[section].name ?? "No title",
            section: section
        )
        return header
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = setsTableView.dequeueReusableHeaderFooterView(withIdentifier: "ExerciseFooter") as? ExerciseFooter
        footer?.delegate = self
        footer?.configure(section: section)
        return footer
    }
}

extension WorkoutViewController: ExerciseHeaderDelegate {
    func onDeletePressed(section: Int) {
        viewModel?.removeExercise(section: section)
        setsTableView.reloadData()
    }

    func onTitleEditingChanged(section: Int, newTitle: String) {
        viewModel?.updateTitle(section: section, newTitle: newTitle)
        setsTableView.reloadData()
    }
}

extension WorkoutViewController: ExerciseFooterDelegate {
    func onAddPressed(section: Int) {
        viewModel?.addSet(section: section)
        setsTableView.reloadData()
    }
}

extension WorkoutViewController: WorkoutSetTableViewCellDelegate {
    func repsDidChange(indexPath: IndexPath, reps: Int) {
        viewModel?.workout.exercises[indexPath.section].sets[indexPath.row].repetitions = reps
    }

    func weightDidChange(indexPath: IndexPath, weight: Double) {
        viewModel?.workout.exercises[indexPath.section].sets[indexPath.row].weight = .init(value: weight, unit: .kilograms)
    }
}
