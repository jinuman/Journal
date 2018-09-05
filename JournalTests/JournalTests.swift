//
//  JournalTests.swift
//  JournalTests
//
//  Created by Jinwoo Kim on 2018. 8. 31..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import XCTest
import Nimble
@testable import Journal

extension Entry {
    static var dayBeforeYesterday: Entry { return Entry(id: UUID(), createdAt: Date.distantPast, text: "그저께 일기") }
    static var yesterDay: Entry { return Entry(id: UUID(), createdAt: Date(), text: "어제 일기") }
    static var today: Entry { return Entry(id: UUID(), createdAt: Date.distantFuture, text: "오늘 일기") }
}

class JournalTests: XCTestCase {
    var newEntry: Entry!
    
    func testAddEntryToJournal() {
        // Setup
        let journal = InMemoryJournal()
        let newEntry = Entry.today
        
        // Run
        journal.add(newEntry)
        
        // Verify
        let entryInJournal: Entry? = journal.entry(with: newEntry.id)
        
//        XCTAssertEqual(entryInJournal, .some(newEntry))
//        XCTAssertTrue(entryInJournal === newEntry)
//        XCTAssertTrue(entryInJournal?.isIdentical(to: newEntry) == true)
        expect(entryInJournal) == newEntry
        expect(entryInJournal) === newEntry
        expect(entryInJournal?.isIdentical(to: newEntry)).to(beTrue())
    }
    
    func testGetEntryWithId() {
        // Setup
        let oldEntry = Entry.today
        let journal = InMemoryJournal(entries: [oldEntry])
        
        // Run
        let entry = journal.entry(with: oldEntry.id)
        
        // Verify
//        XCTAssertEqual(entry, .some(oldEntry))
//        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
        expect(entry) == oldEntry
        expect(entry?.isIdentical(to: oldEntry)).to(beTruthy())
    }
    
    func testUpdateEntry() {
        // Setup
        let oldEntry = Entry.today
        let journal = InMemoryJournal(entries: [oldEntry])
        
        // Run
        oldEntry.text = "일기 내용 수정"
        journal.update(oldEntry)
        
        // Verify
        let entry = journal.entry(with: oldEntry.id)
//        XCTAssertEqual(entry, .some(oldEntry))
//        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
//        XCTAssertEqual(entry?.text, .some("일기 내용 수정"))
        expect(entry).to(equal(oldEntry))
        expect(entry?.isIdentical(to: oldEntry)).to(beTruthy())
        expect(entry?.text).to(equal("일기 내용 수정"))
    }
    
    func testRemoveEntryFromJournal() {
        // Setup
        let oldEntry = Entry.today
        let journal = InMemoryJournal(entries: [oldEntry])
        
        // Run
        journal.remove(oldEntry)
        
        // Verify
        let entry = journal.entry(with: oldEntry.id)
//        XCTAssertEqual(entry, nil)
        expect(entry).to(beNil())

    }
    
    func test_최근_순으로_엔트리를_불러올_수_있다() {
        // Setup
        let dayBeforeYesterday = Entry.dayBeforeYesterday
        let yesterDay = Entry.yesterDay
        let today = Entry.today
        
        let journal = InMemoryJournal(entries: [dayBeforeYesterday, yesterDay, today])
        
        // Run
        let entries = journal.recentEntries(max: 3)
        
        // Verify
//        XCTAssertEqual(entries.count, 3)
//        XCTAssertEqual(entries, [today, yesterDay, dayBeforeYesterday])
        expect(entries.count).to(equal(3))
        expect(entries).to(equal([today, yesterDay, dayBeforeYesterday]))
    }
    
    func test_요청한_엔트리의_수만큼_최신_순으로_반환한다() {
        // Setup
        let dayBeforeYesterday = Entry.dayBeforeYesterday
        let yesterDay = Entry.yesterDay
        let today = Entry.today
        
        let journal = InMemoryJournal(entries: [dayBeforeYesterday, yesterDay, today])
        
        // Run
        let entries = journal.recentEntries(max: 1)
        
        // Verify
//        XCTAssertEqual(entries.count, 1)
//        XCTAssertEqual(entries, [today])
        expect(entries.count).to(equal(1))
        expect(entries).to(equal([today]))
    }
    
    func test_존재하는_엔트리보다_많은_수를_요청하면_존재하는_엔트리만큼만_반환한다() {
        // Setup
        let dayBeforeYesterday = Entry.dayBeforeYesterday
        let yesterDay = Entry.yesterDay
        let today = Entry.today
        
        let journal = InMemoryJournal(entries: [dayBeforeYesterday, yesterDay, today])
        
        // Run
        let entries = journal.recentEntries(max: 10)
        
        // Verify
//        XCTAssertEqual(entries.count, 3)
//        XCTAssertEqual(entries, [today, yesterDay, dayBeforeYesterday])
        expect(entries.count).to(equal(3))
        expect(entries).to(equal([today, yesterDay, dayBeforeYesterday]))
    }
    
    func testJournalReturnsEmptyWhenMaxIsNegativeNumber() {
        // Setup
        let journal = InMemoryJournal()
        
        // Run
        let entries = journal.recentEntries(max: -10)
        
        // Verify
        expect(entries) == []
    }
}
