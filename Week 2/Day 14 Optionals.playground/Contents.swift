import Cocoa

//How to handle missing data with optionals
let opposites = [
    "Mario":"Wario",
    "Luigi":"Waluigi"
]

let peachOpposite = opposites["Peach"]

if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)") //Mario's opposite is Wario
}

var username: String? = nil

if let unwrappedName = username {
    print("We got a user: \(unwrappedName)")
} else {
    print("The optional was empty") //The optional was empty
}

func square(number: Int) -> Int {
    number * number
}

var number: Int? = nil
//print(square(number: number))
//give error: Value of optional type 'Int?' must be unwrapped to a value of type 'Int'

if let number = number {
    print(square(number: number))
}

//How to unwrap optionals with guard
func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")
        //1: We must exit the function here
        return
    }
    //2: 'number' is still available outside of the guard statement
    print("\(number) x \(number) is \(number * number)")
}

var myVar: Int? = 3

if let unwrapped = myVar {
    print("Run if myVar has a value inside") //Run if myVar has a value inside
}

/*
 guard let unwrapped = myVar else {
     print("Run if myVar doesn't have a value inside")
 }
 guard needs to follow through with return at the end of else statement and return should be used inside a func
 */

//How to unwrap optionals with nil coalescing
let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

let new = captains["Serenity"] ?? "N/A"
let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
let favorite = tvShows.randomElement() ?? "None"

struct Book {
    let title: String
    let author: String?
}

let book = Book(title: "Beowulf", author: nil)
let author = book.author ?? "Anonymous"
print(author) //Anonymous

let input = ""
let number2 = Int(input) ?? 0
print(number2) //0

//How to handle multiple optionals using optional chaining
let names = ["Arya","Bran","Robb","Sansa"]
let chosen = names.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)") //Next in line: SANSA

var book2: Book? = nil
let author2 = book2?.author?.first?.uppercased() ?? "A"
print(author2) //A

//How to handle function failure with optionals
enum UserError: Error {
    case badID, networkFailed
}
func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
}

let newUser = (try? getUser(id: 23)) ?? "Anonymous"
print(newUser) //Anonymous

//Checkpoint 9

/*
 Write a function that accepts an optional array of integers and returns one randomly
 If the array is missing or empty, return a number between 1 - 100
 Write it in a single line of code
 */

func giveRandomNumber(from array: [Int]?) -> Int {
    array?.randomElement() ?? Int.random(in: 1...100)
}

print(giveRandomNumber(from: nil))
