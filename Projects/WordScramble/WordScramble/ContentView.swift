//
//  ContentView.swift
//  WordScramble
//
//  Created by Angela Garrovillas on 3/28/25.
//

import SwiftUI

struct ContentView: View {
    //let people = ["Ash","Brock","May","Max"]
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score: Int = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement()
                        .accessibilityLabel("\(word), \(word.count) letters")
                        
                        //works alternatively as this combo
//                        .accessibilityElement()
//                        .accessibilityLabel(word)
//                        .accessibilityHint("\(word.count) letters")
                    }
                }
                Section("Score") {
                    Text("\(score)")
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("New Word", action: startGame)
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
        }
        
//        List(people, id: \.self) {
//            Text($0)
//        }
//        List {
//            Text("Can mix static and dynamic")
//            ForEach(people, id: \.self) {
//                Text($0)
//            }
//        }
        
//        List {
//            Section("Section 1") {
//                Text("Static Row 1")
//                Text("Static Row 2")
//            }
//            Section("Section 2") {
//                ForEach(0..<5) {
//                    Text("Dynamic Row \($0)")
//                }
//            }
//            Section("Section 3") {
//                Text("Static Row 3")
//                Text("Static Row 4")
//            }
//        }
//        .padding()
//        List(0..<5) {
//            Text("Dynamic Row \($0)")
//        }
//        .padding()
//        .listStyle(.grouped)
    }
    func addNewWord() {
        //lowercase and trim the word to make sure we don't duplicate words with cases
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        //exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from \(rootWord)!")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up you know!")
            return
        }
        guard !isTooShort(word: answer) else {
            wordError(title: "Word is too short", message: "Try for at least 3 letters long")
            return
        }
        guard !isOriginalWord(word: answer) else {
            wordError(title: "Word is the starting word", message: "Can't use original word")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            score += answer.count
        }
        newWord = ""
    }
    func startGame() {
        //1. find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //2. load start.txt into string
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .ascii) {
                //3. split the string up into array, splitting on the line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                //4. pick random word, or use silkworm as a default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                score = 0
                
                //if we are here, then everything worked and we can exit
                return
            }
        }
        //if we are here then there was a problem, trigger crash and report error
        fatalError("could not load start.txt from bundle")
    }
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    func isTooShort(word: String) -> Bool {
        return word.count < 3
    }
    func isOriginalWord(word: String) -> Bool {
        return rootWord == word
    }
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    func exampleBundleURL() {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            //we found the file in our bundle
            if let fileContents = try? String(contentsOf: fileURL, encoding: .ascii) {
                //we loaded the file into a string
                print(fileContents)
            }
        }
    }
    func exampleStrings() {
        let input = "a b c"
        let letters = input.components(separatedBy: " ")
        let letter = letters.randomElement()
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        print(trimmed ?? "")
        
        let input2 = """
a
b
c
"""
        let letters2 = input2.components(separatedBy: "\n")
        print(letters2)
        
        let word = "swift"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        //gives an NSRange where the misspelling was found
        let allgood = misspelledRange.location == NSNotFound
        print(allgood)
    }
}

#Preview {
    ContentView()
}
