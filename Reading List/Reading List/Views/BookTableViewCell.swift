//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by David Oliver Doswell on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?

    func toggleHasBeenRead(for cell: BookTableViewCell) {}
 
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var uncheckedOutlet: UIButton!
    
    @IBAction func uncheckedButton(_ sender: Any) {
        toggleHasBeenRead(for: self)
    }
    
    private func updateViews() {
        guard let book = book else { return }
        title.text = book.title
        uncheckedOutlet.imageView?.image = UIImage(named: "unchecked")
        
    }
    
}

