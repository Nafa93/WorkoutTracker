//
//  ExerciseHeader.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 02/08/2024.
//

import UIKit

protocol ExerciseHeaderDelegate: AnyObject {
    func onDeletePressed(section: Int)
    func onNameEditingChanged(section: Int, newTitle: String)
}

class ExerciseHeader: UITableViewHeaderFooterView {

    weak var delegate: ExerciseHeaderDelegate?

    @IBOutlet private var nameTextField: UITextField!

    private var section: Int = -1

    func configureHeader(name: String, section: Int) {
        self.nameTextField.text = name
        self.section = section
    }

    @IBAction private func onNameEditingChanged(_ sender: Any) {
        guard let title = nameTextField.text else { return }
        delegate?.onNameEditingChanged(section: section, newTitle: title)
    }

    @IBAction private func onButtonPressed(_ sender: Any) {
        delegate?.onDeletePressed(section: section)
    }
}
