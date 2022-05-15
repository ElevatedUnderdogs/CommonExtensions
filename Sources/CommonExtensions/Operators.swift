//
//  File 17.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

import Foundation

func == <First:Equatable, Second: Equatable> (tuple1:(First, Second), tuple2:(First, Second)) -> Bool {
    (tuple1.0 == tuple2.0) && (tuple1.1 == tuple2.1)
}

postfix operator *~

infix operator ~~

func ~~(left: Decimal, right: Decimal) -> Bool {
    left * 0.99999 <= right && right <= left * 1.00001
}
