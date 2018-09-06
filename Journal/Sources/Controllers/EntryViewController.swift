//
//  ViewController.swift
//  Journal
//
//  Created by 김진우 on 2018. 8. 13..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

extension DateFormatter {
    static var entryDateFormatter: DateFormatter = { () -> DateFormatter in
        let df = DateFormatter()
        df.dateFormat = "yyyy. MM. dd. EEE"
        return df
    }()
}

class EntryViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    let journal: Journal = InMemoryJournal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = DateFormatter.entryDateFormatter.string(from: Date())
        textView.text = "Journal text test"
    }

    @IBAction func saveEntry(_ sender: Any) {
        let entry: Entry = Entry(text: textView.text)
        journal.add(entry)
        
        print("Entry 개수: ", journal.numberOfEntries)
    }
}

