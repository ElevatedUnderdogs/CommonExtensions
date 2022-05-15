//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

//extension MLBoostedTreeClassifier {
//
//
//    /// Creates an instance given a table and the name of the target column contained therein.
//    ///  With defaults.
//    ///
//    /// - Parameter trainingData: a DataTable containing training data
//    ///
//    ///             targetColumn: a String specifying the target column name in the trainingData
//    ///
//    ///             featureColumns: an optional list of Strings specifying feature columns to be
//    ///             used to predict the target, if not provided, default to use all the
//    ///             other columns in the trainingData, except the one specified by targetColumn
//    ///
//    ///             parameters: parameters for training the model
//    static func standard(
//        trainingData: MLDataTable,
//        targetColumn: String = .target,
//        featureColumns: [String]? = nil,
//        parameters: MLBoostedTreeClassifier.ModelParameters = .init(maxIterations: 60_000)
//    ) throws -> Self {
//        try .init(
//            trainingData: trainingData,
//            targetColumn: targetColumn,
//            featureColumns: featureColumns,
//            parameters: parameters
//        )
//    }
//}
