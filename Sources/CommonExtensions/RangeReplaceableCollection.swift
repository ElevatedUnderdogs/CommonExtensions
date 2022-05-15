//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

public extension RangeReplaceableCollection where Element: Hashable {
    var duplicates: Self {
        var set: Set<Element> = []
        var filtered: Set<Element> = []
        return filter { !set.insert($0).inserted && filtered.insert($0).inserted }
    }

    var repeats: Set<Element> {
        duplicates.set
    }
}
