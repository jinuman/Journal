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
    
    var environment: Environment!   // if nil : error!
    private var entries: [Entry] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "addEntry":
            let entryVC = segue.destination as? EntryViewController
            entryVC?.environment = environment
        
        case "showEntry":
            if
                let entryVC = segue.destination as? EntryViewController,
                let selectedIndexPath = tableview.indexPathForSelectedRow {
                
                entryVC.environment = environment
                entryVC.editingEntry = entries[selectedIndexPath.row]
            }
            
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
        
        entries = environment.entryRepository.recentEntries(max: environment.entryRepository.numberOfEntries)
        tableview.reloadData()
    }
}

extension TimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let journalRepository = environment.entryRepository
        return journalRepository.numberOfEntries
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableview.dequeueReusableCell(withIdentifier: "EntryTableViewCell", for: indexPath)
        
        let entry = entries[indexPath.row]
        tableViewCell.textLabel?.text = entry.text
        tableViewCell.detailTextLabel?.text = DateFormatter.entryDateFormatter.string(from: entry.createdAt)
        
        return tableViewCell
    }
}
