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

protocol EntryViewControllerDelegate: class {
    func didRemoveEntry(_ entry: Entry)
}

class EntryViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var button: UIBarButtonItem!
    @IBOutlet weak var removeButton: UIBarButtonItem!
    
    var environment: Environment!
    weak var delegate: EntryViewControllerDelegate?

    var journal: EntryRepository { return environment.entryRepository }
    var editingEntry: Entry?
    var hasEntry: Bool {
        return editingEntry != nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = editingEntry?.text
        let date: Date = editingEntry?.createdAt ?? Date()
        title = DateFormatter.entryDateFormatter.string(from: date)
        
        updateSubviews(for: !hasEntry)
        
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(handleKeyboardAppearance(_:)),
                name: UIResponder.keyboardWillShowNotification,
                object: nil)
        
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(handleKeyboardAppearance(_:)),
                name: UIResponder.keyboardWillHideNotification,
                object: nil)
    }
    
    @objc func handleKeyboardAppearance(_ note: Notification) {
        guard
            let userInfo = note.userInfo,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as?
                NSValue),
            let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as?
                TimeInterval),
            let curve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as?
                UInt)
            else { return }
        
        let isKeyboardWillShow: Bool = note.name ==
            UIResponder.keyboardWillShowNotification
        let keyboardHeight = isKeyboardWillShow
            ? keyboardFrame.cgRectValue.height
            : 0
        let animationOption = UIView.AnimationOptions.init(rawValue: curve)
        
        UIView.animate(
            withDuration:  duration,
            delay: 0.0,
            options: animationOption,
            animations: {
                self.textViewBottomConstraint.constant = -keyboardHeight
                self.view.layoutIfNeeded()
            },
            completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !hasEntry {
            textView.becomeFirstResponder()
        }
    }

    @objc func saveEntry(_ sender: Any) {
        if let editing = editingEntry {
            editing.text = textView.text
            journal.update(editing)
        } else {
            let entry: Entry = Entry(text: textView.text)
            journal.add(entry)
            editingEntry = entry
        }
        updateSubviews(for: false)
        textView.resignFirstResponder()
    }
    
    @objc func editEntry(_ sender: Any) {
        updateSubviews(for: true)
        textView.becomeFirstResponder()
    }

    @IBAction func removeEntry(_ sender: Any) {
        guard let entryToRemove = editingEntry else { return }
        let alertController = UIAlertController(title: "이 일기를 삭제하시겠습니까?",
                                                message: "이 작업은 되돌릴 수 없습니다.",
                                                preferredStyle: .alert)
        let removeAction = UIAlertAction(title: "확인",
                                         style: .destructive) { (_) in
                                            self.environment.entryRepository.remove(entryToRemove)
                                            self.editingEntry = nil
                                            
                                            self.delegate?.didRemoveEntry(entryToRemove)
        }
        
        let cancelAction = UIAlertAction(title: "취소",
                                         style: .cancel,
                                         handler: nil)
            
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    fileprivate func updateSubviews(for isEditing: Bool) {
        button.image = isEditing ? #imageLiteral(resourceName: "baseline_save_white_24pt") : #imageLiteral(resourceName: "baseline_edit_white_24pt")
        button.target = self
        button.action = isEditing ? #selector(saveEntry(_:)) : #selector(editEntry(_:))
        textView.isEditable = isEditing
        removeButton.isEnabled = hasEntry
    }
}

