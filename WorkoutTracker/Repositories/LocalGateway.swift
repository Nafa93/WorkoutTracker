//
//  LocalGateway.swift
//  WorkoutTracker
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 08/08/2024.
//

import Foundation

class LocalGateway<T: Codable>: Gateway {
    private let directoryURL: URL
    private let fileName: String

    init(fileName: String, subdirectory: String? = nil) {
        self.fileName = fileName
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        if let subdirectory = subdirectory {
            self.directoryURL = documentsURL.appendingPathComponent(subdirectory, isDirectory: true)
            if !FileManager.default.fileExists(atPath: directoryURL.path) {
                try? FileManager.default.createDirectory(
                    at: directoryURL,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            }
        } else {
            self.directoryURL = documentsURL
        }
    }

    func save(_ data: [T]) throws {
        let fileURL = directoryURL.appendingPathComponent(fileName)
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(data)
        try jsonData.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
    }

    func load() throws -> [T] {
        let fileURL = directoryURL.appendingPathComponent(fileName)
        let jsonData = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let data = try decoder.decode([T].self, from: jsonData)
        return data
    }
}
