//
//  EntryTests.swift
//  JournalTests
//
//  Created by Jinwoo Kim on 2018. 9. 5..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import XCTest
import Nimble
@testable import Journal

class EntryTests: XCTestCase {
    func testEditEntryText() {
        // Setup
        let entry = Entry.today
        
        // Run
        entry.text = "첫 번째 테스트"
        
        // Verify
        expect(entry.text) == "첫 번째 테스트"
    }
    
    func testEquality() {
        // Setup
        let tempId = UUID()
        let tempDate = Date()
        let tempText = "hi"
        let aEntry = Entry(id: tempId, createdAt: tempDate, text: tempText)
        let bEntry = Entry(id: tempId, createdAt: tempDate, text: tempText)
        
        let anotherEntry = Entry(id: UUID(), createdAt: tempDate, text: tempText)
        // Verify
        expect(aEntry) == bEntry
        expect(aEntry) != anotherEntry
    }
    
}
