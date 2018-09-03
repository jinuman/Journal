//
//  Identifiable.swift
//  Journal
//
//  Created by Jinwoo Kim on 2018. 8. 31..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: UUID { get }
}
extension Identifiable {
    func isIdentical(to other: Self) -> Bool {
        return id == other.id
    }
}
