//
//  Gateway.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 08/08/2024.
//

import Foundation

protocol Gateway<T> {
    // swiftlint:disable:next type_name
    associatedtype T: Codable
    func save(_ data: [T]) throws
    func load() throws -> [T]
}
