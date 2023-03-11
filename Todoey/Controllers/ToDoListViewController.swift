//
//  ToDoListViewController.swift
//  Todoey
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray : [Item] = []
    
    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // Do any additional setup after loading the view.
        navigationController!.view.backgroundColor = .systemBlue
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
            itemArray = items;
        }
        
    }

    //MARK - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ?  .checkmark :  .none
        
        
        return cell
    
    }
    
    //MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - ADD New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text != ""{
                let newItem = Item()
                newItem.title = textField.text!
                self.itemArray.append(newItem)
                self.saveItems()
                
            }
        }
        alert.addTextField{(alertTextField)in
            alertTextField.placeholder="Create New Item"
            textField=alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try  data.write(to: dataFilePath!)
        } catch {
            print("Error encoding: \(error)")
        }
        
        tableView.reloadData()
    }
    
}

