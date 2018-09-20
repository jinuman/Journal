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
    
    var environment: Environment!   // 이게 없으면 앱이 터져도된다.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "addEntry":
            let entryVC = segue.destination as? EntryViewController
            entryVC?.environment = environment
            
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "내 손안의 일기장"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let journalRepository = environment.entryRepository
        
        entryCountLabel.text = journalRepository.numberOfEntries > 0
            ? "엔트리 개수: \(journalRepository.numberOfEntries)"
            : "엔트리 없음"
    }
}
