//
//  TimelineViewControllerTests.swift
//  JournalTests
//
//  Created by Jinwoo Kim on 2018. 9. 20..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import XCTest
import Nimble

@testable import Journal

class TimelineViewControllerTests: XCTestCase {
    
    func testEntryCountLabelTextWhenNoEntry() {
        // Setup
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TimelineViewController") as! TimelineViewController
        _ = vc.view // loadView(), viewDidLoad() 강제로 호출
        
        vc.environment = Environment()
        
        // Run
        vc.viewWillAppear(false)
        
        // Verify
        expect(vc.entryCountLabel.text) == "엔트리 없음"
    }
    
    func testEntryCountLabelTextWhenEntryExist() {
        // Setup
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TimelineViewController") as! TimelineViewController
        _ = vc.view // loadView(), viewDidLoad() 강제로 호출
        
        vc.environment = Environment(entryRepository: InMemoryEntryRepository(entries: [
            Entry.dayBeforeYesterday,
            Entry.yesterDay,
            Entry.today
            ])
        )
        
        // Run
        vc.viewWillAppear(false)
        
        // Verify
        expect(vc.entryCountLabel.text) == "엔트리 개수: 3"
    }
    
}
