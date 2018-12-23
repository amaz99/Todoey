//
//  ViewController.swift
//  Todoey
//
//  Created by Amer Azmeh on 21.12.18.
//  Copyright © 2018 Amer Azmeh. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    //var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

    var itemArray: [Item] = [Item]()
    
    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(dataFilePath)
        
        loadItems()

     }

    //MARK - Table Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("CellForRowAtIndexPath called")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let currentRow = itemArray[indexPath.row]
        
        cell.textLabel?.text = currentRow.title
        
        cell.accessoryType = currentRow.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK . TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        saveItems(itemArray)
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK . Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen when the user press the add button
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems(self.itemArray)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new item here"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    
    }
    
    //MARK - Model Manipulation Methods
    
    func saveItems(_ iArray: [Item]) {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(iArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
        let decoder = PropertyListDecoder()
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error getting data from pList")
            }
            
        }
            
        
    }
}

