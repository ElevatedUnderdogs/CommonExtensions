//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation
import Security

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

    /// Creates a file and writes to it.  If the file already exists at this location, then this writes to it
    /// - Parameter text: text to write to the file.
    func createFileAndWrite(text: String) throws {
        assert(!Bundle.main.ob_isSandboxed, "Delete the sandbox key value pair in the entitlements")
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

    /// **WARNING** This can only be used on Macos.  The iOS dandbox doesn't have access to desktop!
    /// **WARNING** If you want to write to desktop files,
    /// - consider creating a Macos app.
    /// - Delete the app sandbox key value pair in the entitlements.
    ///
    ///  You can map through the folder like so: `appendingPathComponent("iOS/DataFrame/name.json")`
    ///  Strategy: Sometimes it helps to read the files at the location, first to ensure you can reach the document leaf,
    ///  and then attempt to write.
    static var desktop: URL? {
        try? FileManager.default.url(
            for: .desktopDirectory,
            in: .allDomainsMask,
            appropriateFor: nil,
            create: false
        )
    }

    ///  You can map through the folder like so:
    ///  `appendingPathComponent("iOS/DataFrame/name.json")`
    static var documents: URL? {
        try? FileManager.default.url(
            for: .desktopDirectory,
            in: .allDomainsMask,
            appropriateFor: nil,
            create: false
        )
    }
}
