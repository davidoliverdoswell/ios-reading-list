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
    
    var unreadBooks: [Book] = []
    var readBooks: [Book] = []
    var bookSections: [[Book]] = []
    
    init() {
        bookSections.append(unreadBooks)
        bookSections.append(readBooks)
        loadFromPersistentStore()
    }
    
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
    
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        books.append(book)
        checksUpdatedBook()
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        checksUpdatedBook()
        saveToPersistentStore()
    }
    
    func updateHasBeenRead() {
        var readBooks: [Book] {
            return books.filter( { $0.hasBeenRead } )
        }
        self.readBooks = readBooks
    }
    
    func updateHasNotBeenRead() {
        var unreadBooks: [Book] {
            return books.filter( { $0.hasBeenRead == false } )
        }
        self.unreadBooks = unreadBooks
    }
    
    func checksUpdatedBook() {
        readBooks.removeAll(keepingCapacity: true)
        unreadBooks.removeAll(keepingCapacity: true)
        for book in books {
            if book.hasBeenRead {
                readBooks.append(book)
            } else {
                unreadBooks.append(book)
            }
        }
        bookSections.removeAll(keepingCapacity: true)
        bookSections.append(unreadBooks)
        bookSections.append(readBooks)
        // updateHasBeenRead()
        // updateHasNotBeenRead()
    }
    
}
