//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by David Oliver Doswell on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

private let unread = "Unread"

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    let bookController = BookController()
    
    let book = Book(title: "", reasonToRead: "", hasBeenRead: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookController.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    private func bookFor(indexPath: IndexPath) -> Book {
       return bookController.bookSections[indexPath.section][indexPath.row]
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return ["Unread", "Read"][section]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookController.bookSections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookTableViewCell
        
        cell.delegate = self
        cell.book = bookController.bookSections[indexPath.section][indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? BookDetailViewController {
                vc.bookController = bookController
                if let cell = sender as? BookTableViewCell {
                    vc.book = cell.book
                }
            }
    }

}
