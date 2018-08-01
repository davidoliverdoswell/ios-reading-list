//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by David Oliver Doswell on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var book: Book?
    var bookController: BookController?
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var reasonToReadLabel: UITextView!
    
    @IBAction func saveButton(_ sender: Any) {
        guard let title = titleLabel.text, let reasonToRead = reasonToReadLabel.text else { return }
        
        bookController!.createBook(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard let book = book else { return }
        titleLabel.text = book.title
        reasonToReadLabel.text = book.reasonToRead
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
