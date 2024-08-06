//
//  WorkoutSet.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 30/07/2024.
//

import Foundation

struct WorkoutSet: Hashable, Equatable, Identifiable {
    var id: UUID
    var weight: Measurement<UnitMass>
    var repetitions: Int

    init(id: UUID = UUID(), weight: Measurement<UnitMass>, repetitions: Int) {
        self.id = id
        self.weight = weight
        self.repetitions = repetitions
    }

    init() {
        self.init(weight: .init(value: 0, unit: .kilograms), repetitions: 0)
    }
}

extension WorkoutSet: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case repetitions
        case weightValue
        case weightUnit
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        repetitions = try container.decode(Int.self, forKey: .repetitions)

        let weightValue = try container.decode(Double.self, forKey: .weightValue)
        let weightUnitString = try container.decode(String.self, forKey: .weightUnit)
        let weightUnit = UnitMass(symbol: weightUnitString)

        weight = Measurement(value: weightValue, unit: weightUnit)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(repetitions, forKey: .repetitions)
        try container.encode(weight.value, forKey: .weightValue)
        try container.encode(weight.unit.symbol, forKey: .weightUnit)
    }
}
