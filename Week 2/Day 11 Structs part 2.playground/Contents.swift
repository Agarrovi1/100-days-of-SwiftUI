import Cocoa

//How to limit access to internal data using access control

struct BankAccount {
    private var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)
if success {
    print("Withdew money successfully")
} else {
    print("Failed to get the money")
}
//Failed to get the money

//funds is exposed to us externally so nothing stopping you from touching it
//account.funds -= 1000

//added private to property funds in struct
//account.funds
//'funds' is inaccessible due to 'private' protection level

//Static properties and methods
struct School {
    static var studenCount = 0
    
    static func add(student: String) {
        print("\(student) joined the school.")
        studenCount += 1
    }
}

School.add(student: "Taylor Swift") //Taylor Swift joined the school.
print(School.studenCount) //1

struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}

print(AppData.version) //1.3 beta 2
struct Employee {
    let username: String
    let password: String
    
    static let example = Employee(username: "cfederighi", password: "hairforceone")
}

//Checkpoint 6
/*
 Create a struct to store information about a car
 Include model, number of seats, and current gear
 Add a method to change gears up or down
 */

struct Car {
    let model: String
    let numberOfSeats: Int
    var currentGear: Int = 0 {
        didSet {
            print("Current gear is \(currentGear)")
        }
    }
    
    init(model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
    }
    
    enum GearChange {
        case up, down
    }
    
    mutating func changeGear(direction: GearChange) {
        switch direction {
        case .up:
            if currentGear == 10 {
                print("Already on highest gear")
            } else {
                currentGear += 1
            }
        case .down:
            if currentGear == 0 {
                print("Already on lowest gear")
            } else {
                currentGear -= 1
            }
        }
    }
}

var car = Car(model: "Subaru", numberOfSeats: 7)
print(car.model) //Subaru
print(car.numberOfSeats) //7
car.changeGear(direction: .down) //Already on lowest gear
car.changeGear(direction: .up) //Current gear is 1
