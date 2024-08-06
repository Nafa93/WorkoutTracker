//
//  WorkoutSetTableViewCell.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 01/08/2024.
//

import UIKit

protocol WorkoutSetTableViewCellDelegate: AnyObject {
    func repsDidChange(indexPath: IndexPath, reps: Int)
    func weightDidChange(indexPath: IndexPath, weight: Double)
}

class WorkoutSetTableViewCell: UITableViewCell {

    @IBOutlet weak var weightTextField: UITextField!

    @IBOutlet weak var repsTextField: UITextField!

    weak var delegate: WorkoutSetTableViewCellDelegate?

    private var indexPath: IndexPath!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func repsEditingDidEnd(_ sender: Any) {
        guard let reps = Int(repsTextField.text ?? "") else { return }
        delegate?.repsDidChange(indexPath: indexPath, reps: reps)
    }

    @IBAction func weigthEditingDidEnd(_ sender: Any) {
        guard let weight = Double(weightTextField.text ?? "") else { return }
        delegate?.weightDidChange(indexPath: indexPath, weight: weight)
    }
    

    func setup(_ workoutSet: WorkoutSet, indexPath: IndexPath) {
        weightTextField.text = "\(workoutSet.weight.value)"
        repsTextField.text = "\(workoutSet.repetitions)"
        self.indexPath = indexPath
    }
}
