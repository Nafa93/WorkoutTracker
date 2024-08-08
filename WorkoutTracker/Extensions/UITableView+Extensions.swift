//
//  UITableView+Extensions.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 08/08/2024.
//

import UIKit

extension UITableView {
    func register<T>(_ type: T.Type) {
        let identifier = String(describing: T.self)
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }

    func registerHeaderFooter<T>(_ type: T.Type) {
        let identifier = String(describing: T.self)
        register(UINib(nibName: identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T>(_ type: T.Type, indexPath: IndexPath) -> T where T: UITableViewCell {
        if let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T {
            return cell
        } else {
            return T()
        }
    }

    func dequeueReusableHeaderFooterView<T>(_ type: T.Type) -> T? where T: UITableViewHeaderFooterView {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T
    }
}
