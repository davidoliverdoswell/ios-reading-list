//
//  BookController.swift
//  Reading List
//
//  Created by David Oliver Doswell on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
 
    var books : [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        
        do {
            guard let url = readingListURL else { return }
           
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        
        do {
            guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
            
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            NSLog("Error decoding: \(error)")
        }
    }
    
    func createBook(book: Book) {
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        var readBooks: [Book] {
            return books.filter( { $0.hasBeenRead } )
        }
    }
    
    func updateHasNotBeenRead(for book: Book) {
        var unreadBooks: [Book] {
            return books.filter( { $0.hasBeenRead == false } )
        }
    }
    
    
    
    
    
}
