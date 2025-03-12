import Cocoa

//How to use type annotations

//let surname = "Lasso" -> String
//var score = 0 -> Int

//being explicit
let surname: String = "Lasso"
//var score: Int = 0

var score: Double = 0

var soda: [String] = ["Coke", "Pepsi", "Irn-Bru"]

var teams: [String] = [String]()

var cities2: [String] = []

var clues = [String]()

enum UIStyle {
    case light, dark, system
}

var style = UIStyle.light

let username: String
// lots of complex logic
username = "@twostraws"
// lots more complex logic
print(username)

//let score2: Int = "Zero"
//gets error

//Checkpoint 2

//create an array of strings, then write some code that prints the number of items in the array and also the number of unique items in the array

let games = ["Pokemon","Monster Hunter", "Metaphor", "SMT", "Pokemon", "Monster Hunter"]
print("Number of items in array: \(games.count)")
print("Number of unique items in array: \(Set(games).count)")
