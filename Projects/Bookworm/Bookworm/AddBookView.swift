//
//  AddBookView.swift
//  Bookworm
//
//  Created by Angela Garrovillas on 4/15/25.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    
    var disableSave: Bool {
        return title.isEmpty || author.isEmpty || genre.isEmpty
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of Book", text: $title)
                    TextField("Name of Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                    
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6) {
//                            Text(String($0))
//                        }
//                    }
                }
                Section {
                    Button("Save") {
                        let book = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(book)
                        dismiss()
                    }
                }
                .disabled(disableSave)
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
