import Cocoa

//Creating constants and variables
var name = "Ted"
name = "Rebecca"

let user = "Daphne"

print(user) //Daphne

//Strings
let actor = "Tom Cruise"

let actorWithEmoji = "Tom Cruise 🏃‍♂️"

let quote = "He tapped a sign saying \"Believe\" and walked away"

let movie = """
A day in
the life of an
Apple engineer
"""

print(actor.count) //10

print(quote.hasPrefix("He")) //true
print(quote.hasSuffix("Away")) //false

//Integers
let score = 10
let higherScore = score + 10
let halvedScore = score / 2

var counter = 10
counter += 5

let number = 120
print(number.isMultiple(of: 3)) //true

let id = Int.random(in: 1...1000)

//Decimals
let decimalScore = 3.0

//Booleans
let goodDogs = true
let gameOver = false

var isSaved = false
isSaved.toggle()

print(isSaved) //true

//Joining Strings
let nameString = "Taylor"
let age = 26
let message = "I'm \(nameString) and I'm \(age) years old."
print(message) //I'm Taylor and I'm 26 years old.

var colors = ["Red","Green","Blue"]
let numbers = [4,8,15,16]
var readings = [0.1,0.5,0.8]

print(colors[0]) //Red
print(readings[2]) //0.8

colors.append("Tartan")

colors.remove(at: 0)
print(colors.count) //3

print(colors.contains("Octarine")) //false

//Dictionaries
let employee = [
    "name":"Taylor",
    "job":"Singer"
]

print(employee["name", default: "Unknown"])
print(employee["job", default: "Unknown"])

//Sets
var numberSet = Set([1,1,3,5,7])
print(numberSet)

numberSet.insert(10)

//Enums
enum Weekday {
    case monday, tuesday, wednesday, thursday, friday
}

var day = Weekday.monday
day = .friday

//Type annotations
var scoreDouble: Double = 0

let player: String = "Roy"
var luckyNumber: Int = 13
let pi: Double = 3.141
var isEnabled: Bool = true
var albums: Array<String> = ["Red","Fearless"]
var userDict: Dictionary<String, String> = ["id": "@twostraws"]
var books: Set<String> = Set(["The Bluest Eye", "Foundation"])

var albums2: [String] = ["Red","Fearless"]
var user2: [String: String] = ["Id": "@twostraws"]

var teams: [String] = [String]()
var clues = [String]()

enum UIStyle {
    case light, dark, system
}

var style: UIStyle = .light

//Conditions
let currentAge = 16

if currentAge < 12 {
    print("You can't vote.")
} else if currentAge < 18 {
    print("You can vote soon.") //You can vote soon.
} else {
    print("You can vote now.")
}

let temp = 26

if temp > 20 && temp < 30 {
    print("It's a nice day.") //It's a nice day.
}

//Switch statements

enum Weather {
    case sun, rain, wind
}

let forecast = Weather.sun

switch forecast {
case .sun:
    print("A nice day.") //A nice day.
case .rain:
    print("Pack an umbrella.")
default:
    print("Should be okay.")
}

//Ternary conditional operator
let newAge = 18
let canVote = newAge >= 18 ? "Yes" : "No"
print(canVote) //Yes

//Loops
let platforms = ["iOS","macOS","tvOS","watchOS"]
for os in platforms {
    print("Swift works on \(os).")
}
/*
 Swift works on iOS.
 Swift works on macOS.
 Swift works on tvOS.
 Swift works on watchOS.
 */

for i in 1...12 {
    print("5 x \(i) is \(5 * i)")
}
/*
 5 x 1 is 5
 5 x 2 is 10
 5 x 3 is 15
 5 x 4 is 20
 5 x 5 is 25
 5 x 6 is 30
 5 x 7 is 35
 5 x 8 is 40
 5 x 9 is 45
 5 x 10 is 50
 5 x 11 is 55
 5 x 12 is 60
 */

for i in 1..<13 {
    print("5 x \(i) is \(5 * i)")
}
/*
 5 x 1 is 5
 5 x 2 is 10
 5 x 3 is 15
 5 x 4 is 20
 5 x 5 is 25
 5 x 6 is 30
 5 x 7 is 35
 5 x 8 is 40
 5 x 9 is 45
 5 x 10 is 50
 5 x 11 is 55
 5 x 12 is 60
 */

var lyric = "Haters gonna"

for _ in 1...5 {
    lyric += " hate"
}

print(lyric) //Haters gonna hate hate hate hate hate

var count = 10

while count > 0 {
    print("\(count)...")
    count -= 1
}

print("Go!")
/*
 10...
 9...
 8...
 7...
 6...
 5...
 4...
 3...
 2...
 1...
 Go!
 */

let files = ["me.jpg","work.txt","sophie.jpg"]
for file in files {
    if file.hasSuffix(".jpg") == false {
        continue
    }
    print("Found picture: \(file)")
}
/*
 Found picture: me.jpg
 Found picture: sophie.jpg
 */

//Functions
func printTimesTables(number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5)
/*
 1 x 5 is 5
 2 x 5 is 10
 3 x 5 is 15
 4 x 5 is 20
 5 x 5 is 25
 6 x 5 is 30
 7 x 5 is 35
 8 x 5 is 40
 9 x 5 is 45
 10 x 5 is 50
 11 x 5 is 55
 12 x 5 is 60
 */

func rollDice() -> Int {
    Int.random(in: 1...6)
}

let result = rollDice()
print(result)

//Returning multiple values from functions
func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let userTuple = getUser()
print("Name: \(userTuple.firstName) \(userTuple.lastName)") //Name: Taylor Swift

let (firstName, _) = getUser()
print("Name: \(firstName)") //Name: Taylor

//Customizing parameter labels
func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let isUppercased = isUppercase(string)

func printTimesTables(for number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5)
/*
 1 x 5 is 5
 2 x 5 is 10
 3 x 5 is 15
 4 x 5 is 20
 5 x 5 is 25
 6 x 5 is 30
 7 x 5 is 35
 8 x 5 is 40
 9 x 5 is 45
 10 x 5 is 50
 11 x 5 is 55
 12 x 5 is 60
 */

//Providing default values for parameters
func greet(_ person: String, formal: Bool = false) {
    if formal {
        print("Welcome, \(person)!")
    } else {
        print("Hi, \(person)!")
    }
}

greet("Tim", formal: true)
greet("Taylor")

//Handling errors in functions
enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }
    
    if password == "12345" {
        throw PasswordError.obvious
    }
    
    if password.count < 10 {
        return "OK"
    } else {
        return "Good"
    }
}

let password = "12345"

do {
    let result = try checkPassword(password)
    print("Rating: \(result)")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error")
}
//I have the same combination on my luggage!

//Closures
let sayHello = {
    print("Hi there!")
}

sayHello() //Hi there!

let sayHello2 = { (name: String) -> String in
    "Hi \(name)"
}

let team = ["Gloria","Suzanne","Tiffany","Tasha"]
var onlyT = team.filter { (name: String) -> Bool in
    name.hasPrefix("T")
}

//Trailing closures and shorthand syntax
print(onlyT) //["Tiffany", "Tasha"]

onlyT = team.filter({ name in
    name.hasPrefix("T")
})

onlyT = team.filter{ name in
    name.hasPrefix("T")
}

onlyT = team.filter{
    $0.hasPrefix("T")
}

//Structs
struct Album {
    let title: String
    let artist: String
    var isReleased = true
    
    func printSummary() {
        print("\(title) by \(artist)")
    }
    
    mutating func removeFromSale() {
        isReleased = false
    }
}

let red = Album(title: "Red", artist: "Taylor Swift")
print(red.title) //Red
red.printSummary() //Red by Taylor Swift

//Computed properties
struct Employee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }
        
        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

//Property observers
struct Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var game = Game()
game.score += 10 //Score is now 10
game.score -= 3 //Score is now 7

//Custom Initializers
struct Player {
    let name: String
    let number: Int
    
    init(name: String) {
        self.name = name
        number = Int.random(in: 1...99)
    }
}

//Access control
struct BanckAccount {
    private(set) var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdway(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

//Static properties and methods
struct AppData {
    static let version = "1.3 beta 2"
    static let settings = "settings.json"
}

//Classes
class ClassEmployee {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

class Developer: ClassEmployee {
    func work() {
        print("I'm coding for \(hours) hours.")
    }
    
    override func printSummary() {
        print("I spend \(hours) hours a day searching Stack Overflow")
    }
}

let novall = Developer(hours: 8)
novall.work() //I'm coding for 8 hours.
novall.printSummary() //I work 8 hours a day.

class Vehicle {
    let isElectric: Bool
    
    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool
    
    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

class Singer {
    var name = "Adele"
}

var singer1 = Singer()
var singer2 = singer1
singer2.name = "Justin"
print(singer1.name) //Justin
print(singer2.name) //Justin

class User {
    let id: Int
    
    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }
    
    deinit {
        print("User \(id): I'm dead!")
    }
    
}

for i in 1...3 {
    let tempUser = User(id: i)
    print("User \(tempUser.id): I;m in control!")
}
/*
 User 1: I'm alive!
 User 1: I;m in control!
 User 1: I'm dead!
 User 2: I'm alive!
 User 2: I;m in control!
 User 2: I'm dead!
 User 3: I'm alive!
 User 3: I;m in control!
 User 3: I'm dead!
 */

class ExampleUser {
    var name = "Paul"
}

let exampleUser = ExampleUser()
exampleUser.name = "Taylor"
print(exampleUser.name) //Taylor

//Protocols
protocol VehicleProtocol {
    var name: String {get}
    var currentPassengers: Int {get set}
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct newCar: VehicleProtocol {
    var name: String
    
    var currentPassengers: Int
    
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance: Int) {
        print("I'm driving \(distance)km")
    }
}

func commute(distance: Int, using vehicle: VehicleProtocol) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("Too slow!")
    } else {
        vehicle.travel(distance: distance)
    }
}

let aCar = newCar(name: "Car", currentPassengers: 1)
commute(distance: 100, using: aCar) //I'm driving 100km

//Extensions
extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func trim() {
        self = self.trimmed()
    }
}

var quoteForExtension = "      The truth is rarely pure and never simple      "
let trimmed = quoteForExtension.trimmed()

quoteForExtension.trim()

extension String {
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
"""

print(lyrics.lines.count) //2

//Protocol extensions
extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

let guests = ["Mario","Luigi","Peach"]

if guests.isNotEmpty {
    print("Guest count: \(guests.count)") //Guest count: 3
}

//Optionals
let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"
]

let peachOpposite = opposites["Peach"]

if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}
//Mario's opposite is Wario

//Unwrapping optionals with guard
func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")
        return
    }
    print("\(number) x \(number) is \(number * number)")
}

//Nil Coalescing
let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
let favorite = tvShows.randomElement() ?? "None"

let input = ""
let num = Int(input) ?? 0
print(num) //0

//Optional chaining
let names = ["Arya","Bran","Robb","Sansa"]
let chosen = names.randomElement()?.uppercased()
print("Next in line: \(chosen ?? "No one")")

//Optional try?
enum UserError: Error {
    case badID, networkFailed
}

func getUser2(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let optionalUser = try? getUser2(id: 23) {
    print("User \(optionalUser)")
}
