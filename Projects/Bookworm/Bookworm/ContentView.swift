//
//  ContentView.swift
//  Bookworm
//
//  Created by Angela Garrovillas on 4/15/25.
//

import SwiftData
import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
}

//@Observable
@Model
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

struct ContentView: View {
    @State private var rememberMe = false
    
    @AppStorage("notes") private var notes = ""
    
    //@Query var students: [Student]
    @Environment(\.modelContext) var modelContext
    
    //@Query var books: [Book]
    //@Query(sort: \Book.title) var books: [Book]
    //@Query(sort: \Book.rating, order: .reverse) var books: [Book]
    @Query(sort: [
        SortDescriptor(\Book.title, order: .reverse),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating == 1 ? .red : .black)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("Bookworm")
                .navigationDestination(for: Book.self) { book in
                    DetailView(book: book)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Book", systemImage: "plus") {
                            showingAddScreen.toggle()
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
        }
        
        //MARK: SwiftData intro
//        NavigationStack {
//            List(students) { student in
//                Text(student.name)
//            }
//            .navigationTitle("Classroom")
//            .toolbar {
//                Button("Add") {
//                    let firstNames = ["Richard","Jason","Tim","Damien"]
//                    let lastNames = ["Greyson","Todd","Drake","Wayne"]
//                    let chosenFirstName = firstNames.randomElement()!
//                    let chosenLastName = lastNames.randomElement()!
//                    let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
//                    
//                    modelContext.insert(student)
//                }
//            }
//        }
        
        //MARK: TextEditor
//        NavigationStack {
//            TextField("Enter your text", text: $notes, axis: .vertical)
//                .textFieldStyle(.roundedBorder)
//                .padding()
//            
//            TextEditor(text: $notes)
//                .navigationTitle("Notes")
//                .padding()
//        }
        
        //MARK: Custom component with @Binding
//        VStack {
//            PushButton(title: "Remember Me", isOn: $rememberMe)
//            Text(rememberMe ? "On" : "Off")
//        }
//        Toggle("Remember Me", isOn: $rememberMe)
    }
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            //find this book in our query
            let book = books[offset]
            
            //delete if from the context
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
