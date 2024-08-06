//
//  WorkoutTableViewCell.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 30/07/2024.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet private var name: UILabel!

    func setup(_ workout: Workout) {
        self.name.text = workout.title
    }
}
