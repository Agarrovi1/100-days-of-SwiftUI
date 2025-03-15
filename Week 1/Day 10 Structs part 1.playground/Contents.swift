import Cocoa

//How to create your own structs
struct Album {
    let title: String
    let artist: String
    let year: Int
    
    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}

let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title) //Red
print(wings.artist) //BTS

red.printSummary() //Red (2012) by Taylor Swift
wings.printSummary() //Wings (2016) by BTS

struct Employee {
    let name: String
    var vacationRemaining: Int = 14
    
    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
archer.takeVacation(days: 5)
//I'm going on vacation
//Days remaining: 9
print(archer.vacationRemaining) //9

var archer1 = Employee(name: "Sterling Archer", vacationRemaining: 14)
var archer2 = Employee.init(name: "Sterling Archer", vacationRemaining: 14)
//the above 2 are the same

let a = 1
let b = 2.0
let c = Double(a) + b

let kane = Employee(name: "Lana Kane")
let poovey = Employee(name: "Pam Poovey", vacationRemaining: 35)

//How to compute property values dynamically

struct Employee2 {
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

/*
 var archer3 = Employee2(name: "Sterling Archer", vacationRemaining: 14)
 archer3.vacationRemaining -= 5
 print(archer3.vacationRemaining) //9
 archer3.vacationRemaining -= 3
 print(archer3.vacationRemaining) //6
 */

var archer3 = Employee2(name: "Sterling Archer", vacationAllocated: 14)
archer3.vacationTaken += 4
print(archer3.vacationRemaining) //10
archer3.vacationTaken += 4
print(archer3.vacationRemaining) //6

var archer4 = Employee2(name: "Sterling Archer", vacationAllocated: 14)
archer4.vacationTaken += 4
archer4.vacationRemaining = 5
print(archer4.vacationAllocated) //9

//How to take action when a property changes
struct Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var game = Game()
game.score += 10
game.score -= 3
game.score += 1

/*
 Score is now 10
 Score is now 7
 Score is now 8
 */

struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be \(newValue)")
        }
        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value has \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")

/*
 Current value is: []
 New value will be ["Adrian E"]
 There are now 1 contacts.
 Old value has []
 Current value is: ["Adrian E"]
 New value will be ["Adrian E", "Allen W"]
 There are now 2 contacts.
 Old value has ["Adrian E"]
 Current value is: ["Adrian E", "Allen W"]
 New value will be ["Adrian E", "Allen W", "Ish S"]
 There are now 3 contacts.
 Old value has ["Adrian E", "Allen W"]
 */

//How to create custom initializer
struct Player {
    let name: String
    let number: Int
    
    init(name: String) {
        self.name = name
        number = Int.random(in: 1...99)
    }
}

let player = Player(name: "Megan R")
print(player.number)
