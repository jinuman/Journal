//
//  TimelineViewController.swift
//  Journal
//
//  Created by Jinwoo Kim on 2018. 9. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    @IBOutlet weak var entryCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "나만의 일기장"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let journal = InMemoryEntryRepository(entries: [
            Entry.init(text: "일기 1"),
            Entry.init(text: "일기 2"),
            Entry.init(text: "일기 3")
            ])
        entryCountLabel.text = journal.numberOfEntries > 0
            ? "엔트리 개수: \(journal.numberOfEntries)"
            : "엔트리 없음"
    }
}
