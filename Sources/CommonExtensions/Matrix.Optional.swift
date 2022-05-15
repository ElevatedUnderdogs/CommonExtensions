//
//  Matrix.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

//import UIKit
//
//public extension Array where Element == Array<Optional>  {
//
//    static func empty(rows: Int) -> Self {
//        Array(repeating: [Element.Iterator.Element](repeating: nil, count: rows), count: rows)
//    }
//
//    var noNils: Bool {
//        allSatisfy(\.noNils)
//    }
//
//    /// Assumes self is a square
//    var rowWinner: Player? {
//        compactMap(\.winner).first ?? nil
//    }
//
//    /// Assumes self is a square
//    var columnWinner: Elemen? {
//        indices.compactMap { column($0).winner }.first
//    }
//
//    /// assumes self is a square
//    func column(_ index: Int) -> [Player?] {
//        map { $0[index] }
//    }
//
//    /// Assumes self is a square
//    var topLeftToBottomRght: [Player?] {
//        indices.map { self[$0][$0] }
//    }
//
//    /// Assumes self is a square
//    var bottomLeftToTopRight: [Player?] {
//        indices.map { self[count - 1 - $0][$0]}
//    }
//}
//
//public extension Collection where Element: Collection {
//
//}
//
//
//// could also make this an public extension on Collection where the outer Index is also an Int.
//public extension Array where Element : Collection, Element.Index == Int {
//
//    subscript(indexPath indexPath: IndexPath) -> Element.Iterator.Element {
//        return self[indexPath.section][indexPath.row]
//    }
//}
//
//public extension Array where Element == [Player? {
//
//    var winner: Player? {
//        rowWinner ??
//        columnWinner ??
//        topLeftToBottomRght.winner ??
//        bottomLeftToTopRight.winner
//    }
//
//
//}
