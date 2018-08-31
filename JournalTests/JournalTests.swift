//
//  JournalTests.swift
//  JournalTests
//
//  Created by Jinwoo Kim on 2018. 8. 31..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import XCTest
@testable import Journal

class JournalTests: XCTestCase {
    func testEditEntryText() {
        // Setup
        let entry = Entry(id: 0, createdAt: Date(), text: "first journal")
        
        // Run
        entry.text = "first test"
        
        // Verify
        XCTAssertEqual(entry.text, "first test")
    }
    
    func testAddEntryToJournal() {
        // Setup
        let journal = InMemoryJournal()
        let newEntry = Entry(id: 1, createdAt: Date(), text: "Hello")
        
        // Run
        journal.add(newEntry)
        
        // Verify
        let entryInJournal: Entry? = journal.entry(with: 1)
        
        XCTAssertEqual(entryInJournal, .some(newEntry))
        XCTAssertTrue(entryInJournal === newEntry)
        XCTAssertTrue(entryInJournal?.isIdentical(to: newEntry) == true)
    }
}
