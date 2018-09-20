//
//  Environment.swift
//  Journal
//
//  Created by Jinwoo Kim on 2018. 9. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

class Environment {
    let entryRepository: EntryRepository
    
    init(entryRepository: EntryRepository = InMemoryEntryRepository()) {
        self.entryRepository = entryRepository
    }
}
