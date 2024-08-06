//
//  ExerciseFooter.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 02/08/2024.
//

import UIKit

protocol ExerciseFooterDelegate: AnyObject {
    func onAddPressed(section: Int)
}

class ExerciseFooter: UITableViewHeaderFooterView {
    weak var delegate: ExerciseFooterDelegate?

    private var section: Int = -1

    func configure(section: Int) {
        self.section = section
    }

    @IBAction private func onButtonPressed(_ sender: Any) {
        delegate?.onAddPressed(section: section)
    }
}
