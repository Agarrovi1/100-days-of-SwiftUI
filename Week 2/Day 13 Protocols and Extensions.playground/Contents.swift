import Cocoa



protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car: Vehicle {
    var name: String
    
    var currentPassengers: Int
    
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }
    
    func openSunroof() {
        print("It's a nice day!")
    }
}
struct Train {
    
}
struct Bus {
    
}

func commute(distance: Int, using vehicle: Car) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car(name: "Car", currentPassengers: 1)
commute(distance: 100, using: car) //I'm driving 100km.

func commute(distance: Int, using vehicle: Train) {
    //lots of code here
}
func commute(distance: Int, using vehicle: Bus) {
    //lots of code here
}

func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

struct Bicycle: Vehicle {
    var name: String
    
    var currentPassengers: Int
    
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }
    
    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}

let bike = Bicycle(name: "Bicycle", currentPassengers: 1)
commute(distance: 50, using: bike) //I'm cycling 50km.

func getTravelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}

getTravelEstimates(using: [car,bike], distance: 150)
//Car: 3 hours to travel 150km
//Bicycle: 15 hours to travel 150km

//How to use opaque return types
func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomNumber() == getRandomNumber())

//How to create and use extensions
var quote = "     The truth is rarely pure and never simple     "
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    mutating func trim() {
        self = self.trimmed()
    }
    
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}

let easierTrimmed = quote.trimmed()

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""

print(lyrics.lines.count) //4

struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

let lotr = Book(title: "Lord of the Rings", pageCount: 1178, readingHours: 24)

extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

//How to create and use protocol extensions
let guests = ["Mario", "Luigi","Peach"]
if guests.isEmpty == false {
    print("Guest count: \(guests.count)") //Guest count: 3
}

if !guests.isEmpty {
    print("Guest count: \(guests.count)") //Guest count: 3
}

extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

if guests.isNotEmpty {
    print("Guest count: \(guests.count)") //Guest count: 3
}

protocol Person {
    var name: String { get }
    func sayHello()
}

extension Person {
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}

struct Employee: Person {
    let name: String
}

let taylor = Employee(name: "Taylor Swift")
taylor.sayHello() //Hi, I'm Taylor Swift

//How to get the most from protocols and extensions

//extension Int {
//    func squared() -> Int {
//        self * self
//    }
//}
extension Numeric {
    func squared() -> Self {
        self * self
    }
}
let wholeNumber = 5
print(wholeNumber.squared()) //25

struct User: Comparable { //comparable inherits from equatable so no need to add Equatable
    let name: String
}
func <(lhs: User, rhs: User) -> Bool {
    lhs.name < rhs.name
}

let user1 = User(name: "Link")
let user2 = User(name: "Zelda")
print(user1 == user2) //false
print(user1 != user2) //true

print(user1 < user2) //true
print(user1 <= user2) //true
print(user1 > user2) //false
print(user1 >= user2) //false

//Checkpoint 8
/*
 Make a protocol that describes a building
    Property storing how many rooms it has
    Property storing how much it costs as an integer
    Property storing the name of the estate agent responsible for selling the building
    A method printing the sales summary of the building, describing what it is along with its other properties
 Have structs House and Office conform to the protocol
 */

protocol Building {
    var rooms: Int {get}
    var costs: Int {get}
    var estateAgent: String {get}
    var buildingDescription: String {get}
}

extension Building {
    func printSaleSummary() {
        print("""
This building is a \(buildingDescription).
There are \(rooms) rooms.
It costs $\(costs).
Estate Agent to contact: \(estateAgent)
""")
    }
}

struct House: Building {
    var buildingDescription: String
    
    var rooms: Int
    
    var costs: Int
    
    var estateAgent: String
}

struct Office: Building {
    var buildingDescription: String
    
    var rooms: Int
    
    var costs: Int
    
    var estateAgent: String
}

let redHouse = House(buildingDescription: "Housing Unit", rooms: 4, costs: 250_000_000, estateAgent: "George M.")
let blueOffice = Office(buildingDescription: "Office Space", rooms: 7, costs: 500_000_000, estateAgent: "Albert G.")
redHouse.printSaleSummary()
/*
 This building is a Housing Unit.
 There are 4 rooms.
 It costs $250000000.
 Estate Agent to contact: George M.
 */
blueOffice.printSaleSummary()
/*
 This building is a Office Space.
 There are 7 rooms.
 It costs $500000000.
 Estate Agent to contact: Albert G.
 */
