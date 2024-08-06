//
//  WorkoutSetTableViewCell.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 01/08/2024.
//

import UIKit

protocol WorkoutSetTableViewCellDelegate: AnyObject {
    func onRepsDidChange(indexPath: IndexPath, reps: Int)
    func onWeightDidChange(indexPath: IndexPath, weight: Double)
}

class WorkoutSetTableViewCell: UITableViewCell {

    weak var delegate: WorkoutSetTableViewCellDelegate?

    @IBOutlet private var weightTextField: UITextField!
    @IBOutlet private var repsTextField: UITextField!

    private var indexPath: IndexPath!

    func setup(_ workoutSet: WorkoutSet, indexPath: IndexPath) {
        selectionStyle = .none
        weightTextField.text = "\(workoutSet.weight.value)"
        repsTextField.text = "\(workoutSet.repetitions)"
        self.indexPath = indexPath
    }

    @IBAction private func onRepsEditingChanged(_ sender: Any) {
        guard let reps = Int(repsTextField.text ?? "") else { return }
        delegate?.onRepsDidChange(indexPath: indexPath, reps: reps)
    }

    @IBAction private func onWeightEditingChanged(_ sender: Any) {
        guard let weight = Double(weightTextField.text ?? "") else { return }
        delegate?.onWeightDidChange(indexPath: indexPath, weight: weight)
    }
}
