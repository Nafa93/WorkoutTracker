//
//  WorkoutViewController.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 30/07/2024.
//

import UIKit

protocol WorkoutViewControllerDelegate: AnyObject {
    func onWorkoutDidChange(_ workout: Workout)
}

class WorkoutViewController: UIViewController {
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var setsTableView: UITableView!

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
        let button = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(onSavePressed)
        )
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
        setsTableView.showsVerticalScrollIndicator = false
    }

    private func setupTitleTextField() {
        titleTextField.text = viewModel?.title
    }

    @objc private func onSavePressed() {
        guard let workout = viewModel?.workout else { return }
        delegate?.onWorkoutDidChange(workout)
        coordinator?.goBack()
    }

    @IBAction private func onTitleEditingChanged(_ sender: UITextField) {
        guard let title = sender.text else { return }
        viewModel?.title = title
    }

    @IBAction private func onAddExercisePressed(_ sender: Any) {
        viewModel?.addExercise()
        setsTableView.reloadData()

        if let section = viewModel?.exercisesCount {
            setsTableView.scrollToRow(at: IndexPath(row: 0, section: section - 1), at: .middle, animated: true)
        }
    }
}

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.exercisesCount ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.setsCount(for: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "WorkoutSetTableViewCell",
            for: indexPath
        ) as? WorkoutSetTableViewCell,
           let set = viewModel?.set(for: indexPath) {
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
            name: viewModel?.exerciseName(for: section) ?? "No name",
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

    func onNameEditingChanged(section: Int, newTitle: String) {
        viewModel?.updateExerciseName(section: section, name: newTitle)
        setsTableView.reloadData()
    }
}

extension WorkoutViewController: ExerciseFooterDelegate {
    func onAddPressed(section: Int) {
        viewModel?.addSet(section: section)
        setsTableView.reloadData()
        setsTableView.scrollToRow(at: IndexPath(row: 0, section: section), at: .middle, animated: true)
    }
}

extension WorkoutViewController: WorkoutSetTableViewCellDelegate {
    func onRepsDidChange(indexPath: IndexPath, reps: Int) {
        viewModel?.updateReps(at: indexPath, reps: reps)
    }

    func onWeightDidChange(indexPath: IndexPath, weight: Double) {
        viewModel?.updateWeight(at: indexPath, weight: weight)
    }
}
