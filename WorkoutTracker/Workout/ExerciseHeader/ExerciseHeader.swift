//
//  ExerciseHeader.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 02/08/2024.
//

import UIKit

protocol ExerciseHeaderDelegate: AnyObject {
    func onDeletePressed(section: Int)
    func onTitleEditingChanged(section: Int, newTitle: String)
}

class ExerciseHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var titleTextField: UITextField!
    
    weak var delegate: ExerciseHeaderDelegate?

    private var section: Int = -1

    func configureHeader(title: String, section: Int) {
        self.titleTextField.text = title
        self.section = section
    }

    @IBAction func onTitleEditingChanged(_ sender: Any) {
        guard let title = titleTextField.text else { return }
        delegate?.onTitleEditingChanged(section: section, newTitle: title)
    }
    
    @IBAction func onButtonPressed(_ sender: Any) {
        delegate?.onDeletePressed(section: section)
    }
}
