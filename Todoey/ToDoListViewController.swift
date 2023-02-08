//
//  ToDoListViewController.swift
//  Todoey
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray=["born","live","die"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController!.view.backgroundColor = .systemBlue
        
    }

    //MARK - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell=Table
    }
}

