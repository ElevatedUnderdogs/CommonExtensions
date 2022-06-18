//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension URL {
//    static var localFilePath: URL? {
//        guard
//            let documentURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first,
//            let lastSlash = lastIndex(of: "/")
//        else {
//            return nil
//        }
//
//        // ie: "documentbaseURL/uniqueUrlcomponents" -> "uniqueURlComponents"
//        let uniqueURLComponents = suffix(from: lastSlash).dropFirst().string
//        return documentURL.appendingPathComponent(uniqueURLComponents)
//    }
//
//
//    @discardableResult
//    func createModel(with path: String) throws -> (URL, MLModel) {
//        let startTime: Date = Date()
//        let model = try MLBoostedTreeClassifier(
//            trainingData: try MLDataTable(contentsOf: self).randomSplit(by: 0.8, seed: 0).0,
//            targetColumn: .target,
//            parameters: .init(maxIterations: 60_000)
//        )
//        let url = URL(
//            fileURLWithPath: path + (path.contains(".mlmodel") ? "" : ".mlmodel")
//        )
//        try model.write(
//            to: url,
//            metadata: nil
//        )
//        print("completed in \(startTime.timeIntervalSinceNow / 60) minutes.  Please open the project and run.")
//        return (url, model.model)
//    }
}

public extension URL {

    /// *WARNING* You can only **read** from local files, the system **does not allow writing to local files** within an app project.
    /// You can instead save to a local document and send the document where you need it.
    /// - Parameters:
    ///   - name: name of the file
    ///   - ofType: file type
    /// - Returns: returns a url to access a local project resource.
    static func bundleLocal(name: String, ofType: String) -> URL? {
        Bundle.main.path(forResource: name, ofType: ofType)?.fileurl
    }

    /// name example: "name.json"
    /// - Parameter name: name of the file
    /// - Returns: return the url to the file.
    static func fileManager(name: String) -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.appendingPathComponent(name)
    }

    func save(text: String) throws {
        try text.write(to: self, atomically: true, encoding: .utf8)
    }

    func asyncData(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: self, completionHandler: completion).resume()
    }

    static func muxStream(id: String) -> URL {
        URL(string: "https://stream.mux.com/"+id+".m3u8")!
    }

    static func bundlePath(for resource: String = "Content", of type: String = "json") -> Self? {
        URL(fileURLWithPath: String.bundlePath(for: resource, of: type))
    }

    var data: Data? {
        URL.bundlePath().flatMap { try? Data(contentsOf: $0) }
    }
}



//public extension URL {
//
//
//    /// Creates a model and returns it.
//    /// - Parameter startTime:used to print the
//    /// - Throws: throws an error when trying to create the model.
//    /// - Returns: returns the model thats created.
//    @discardableResult func createBoostedModel(startTime: Date = Date()) throws -> MLModel {
//        let model: MLBoostedTreeClassifier = try .standard(trainingData: mlDataTable())
//        try model.write(to: self, metadata: nil)
//        print("completed in \(startTime.timeIntervalSinceNow / 60) minutes.  Please open the project and run.")
//        return model.model
//    }
//
//    /// Creates an MLDataTable with the contents at this url.
//    /// The table splits by the split argument.
//    func mlDataTable(by split: Double = 0.8) throws -> MLDataTable {
//        try .init(contentsOf: self).randomSplit(by: split, seed: 0).0
//    }
//}
