//
//  TimelineViewController.swift
//  Journal
//
//  Created by Jinwoo Kim on 2018. 9. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    
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
        tableview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension TimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let journalRepository = environment.entryRepository
        return journalRepository.numberOfEntries
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableview.dequeueReusableCell(withIdentifier: "EntryTableViewCell", for: indexPath)
        tableViewCell.textLabel?.text = "row: \(indexPath.row)"
        tableViewCell.detailTextLabel?.text = "section: \(indexPath.section)"
        
        return tableViewCell
    }
}
