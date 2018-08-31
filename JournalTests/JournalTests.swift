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
//        XCTAssertTrue(entryInJournal === newEntry)
        XCTAssertTrue(entryInJournal?.isIdentical(to: newEntry) == true)
    }
    
    func testGetEntryWithId() {
        // Setup
        let oldEntry = Entry(id: 1, createdAt: Date(), text: "일기")
        let journal = InMemoryJournal(entries: [oldEntry])
        
        // Run
        let entry = journal.entry(with: 1)
        
        // Verify
        XCTAssertEqual(entry, .some(oldEntry))
        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
    }
    
    func testUpdateEntry() {
        // Setup
        let oldEntry = Entry(id: 1, createdAt: Date(), text: "일기")
        let journal = InMemoryJournal(entries: [oldEntry])
        
        // Run
        oldEntry.text = "일기 내용 수정"
        journal.update(oldEntry)
        
        // Verify
        let entry = journal.entry(with: 1)
        XCTAssertEqual(entry, .some(oldEntry))
        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
        XCTAssertEqual(entry?.text, .some("일기 내용 수정"))
    }
    
    func testRemoveEntryFromJournal() {
        // Setup
        let oldEntry = Entry(id: 1, createdAt: Date(), text: "일기")
        let journal = InMemoryJournal(entries: [oldEntry])
        
        // Run
        journal.remove(oldEntry)
        
        // Verify
        let entry = journal.entry(with: 1)
        XCTAssertEqual(entry, nil)
    }
}
