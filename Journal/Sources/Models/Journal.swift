//
//  Journal.swift
//  Journal
//
//  Created by Jinwoo Kim on 2018. 8. 31..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

protocol Journal {
    func add(_ entry: Entry)
    func update(_ entry: Entry)
    func remove(_ entry: Entry)
    func entry(with id: Int) -> Entry?
    func recentEntries(max: Int) -> [Entry]
}

class InMemoryJournal: Journal {
//    private var entries: [Int: Entry] = [:]
    private var entries: [Int: Entry]
    
    init(entries: [Entry] = []) {
        var result: [Int: Entry] = [:]
        
        entries.forEach { entry in
            result[entry.id] = entry
        }
        
        self.entries = result
    }
    
    func add(_ entry: Entry) {
        entries[entry.id] = entry
    }
    
    func update(_ entry: Entry) {
//        entries[entry.id] = entry
    }
    
    func remove(_ entry: Entry) {
        
    }
    
    func entry(with id: Int) -> Entry? {
        return entries[id]
    }
    
    func recentEntries(max: Int) -> [Entry] {
        return []
    }
}
