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
    @IBOutlet weak var button: UIButton!
    
    let journal: Journal = InMemoryJournal()
    private var editingEntry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = DateFormatter.entryDateFormatter.string(from: Date())
        textView.text = "Journal text test"
        button.addTarget(self,
                         action: #selector(saveEntry(_:)),
                         for: UIControlEvents.touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }

    @objc func saveEntry(_ sender: Any) {
        if let editing = editingEntry {
            editing.text = textView.text
            journal.update(editing)
            print("editing text save event")
        } else {
            let entry: Entry = Entry(text: textView.text)
            journal.add(entry)
            editingEntry = entry
            print("first text save event")
        }
        updateSubviews(for: false)
    }
    
    @objc func editEntry(_ sender: Any) {
        updateSubviews(for: true)
    }
    
    fileprivate func updateSubviews(for isEditing: Bool) {
        if isEditing {
            textView.isEditable = true
            textView.becomeFirstResponder()
            
            button.setTitle("저장하기", for: UIControlState.normal)
            button.addTarget(self,
                             action: #selector(saveEntry(_:)),
                             for: UIControlEvents.touchUpInside)
        } else {
            textView.isEditable = false
            textView.resignFirstResponder()
            
            button.setTitle("수정하기", for: UIControlState.normal)
            button.addTarget(self,
                             action: #selector(editEntry(_:)),
                             for: UIControlEvents.touchUpInside)
        }
    }
}

