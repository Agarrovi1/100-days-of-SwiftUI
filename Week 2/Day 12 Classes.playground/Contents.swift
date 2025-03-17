import Cocoa

//How to create your own classes
class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10 //Score is now 10

//How to make one class inherit from another
class Employee {
    let hours: Int
    
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
    
    init(hours: Int) {
        self.hours = hours
    }
}

class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    
    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
    }
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work() //I'm writing code for 8 hours.
joseph.work() //I'm going to meetings for 10 hours.

let novall = Developer(hours: 8)
novall.printSummary() //I work 8 hours a day.
//now it prints:
//I'm a developer who will sometimes work 8 hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.

//How to add initializers for classes
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
        //before adding super.init gets error: 'super.init' isn't called on all paths before returning from initializer
        super.init(isElectric: isElectric)
    }
}

let car = Car(isElectric: true, isConvertible: false)

//How to copy classes
class User {
    var username = "Anonymous"
    
    func copy() -> User {
        let user = User()
        user.username = username
        return user //creates a unique instance with the same starting data
    }
}

var user1 = User()
var user2 = user1
user2.username = "Taylor"

print(user1.username) //Taylor
print(user2.username) //Taylor

//How to create a deinitializer for a class
class DeInitUserExample {
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
    let user = DeInitUserExample(id: i)
    print("User \(user.id): I'm in control!")
}

/*
 User 1: I'm alive!
 User 1: I'm in control!
 User 1: I'm dead!
 User 2: I'm alive!
 User 2: I'm in control!
 User 2: I'm dead!
 User 3: I'm alive!
 User 3: I'm in control!
 User 3: I'm dead!
 */

print()

var users = [DeInitUserExample]()

for i in 1...3 {
    let user = DeInitUserExample(id: i)
    print("User \(user.id): I'm in control!")
    users.append(user)
}

print("Loop is finished!")
users.removeAll()
print("Array is clear!")
/*
 User 1: I'm alive!
 User 1: I'm in control!
 User 2: I'm alive!
 User 2: I'm in control!
 User 3: I'm alive!
 User 3: I'm in control!
 Loop is finished!
 User 1: I'm dead!
 User 2: I'm dead!
 User 3: I'm dead!
 Array is clear!
 */

//How to work with variables inside classes
class VariableUserExample {
    var name = "Paul"
}

var user = VariableUserExample()
user.name = "Taylor"
print(user.name) //Taylor

user = VariableUserExample()
print(user.name) //Paul

//Checkpoint 7
/*
 Make a class hierarchy for animals
 Start with Animal on top
    Animal should have a leg integer property that tracks how many legs the animal has
 Then Dog and Cat as subclasses
    - Dog should have speak() method that prints a generic dog barking string
    - Each subclass should print something different
    - Cat should have a matching speak() method, each subclass have different strings too
    - Cat class should have an isTame Bool property provided using an initializer
 Then Corgi and Poodle as subclass of Dog
 Persian and Lion as subclasses of Cat
 */

class Animal {
    var numberOfLegs: Int
    init(numberOfLegs: Int) {
        self.numberOfLegs = numberOfLegs
    }
}

class Dog: Animal {
    func speak() {
        print("Bark!")
    }
}

class Cat: Animal {
    let isTame: Bool
    
    func speak() {
        print("Meow!")
    }
    
    init(numberOfLegs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(numberOfLegs: numberOfLegs)
    }
}

class Corgi: Dog {
    override func speak() {
        print("Arf!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Woof!")
    }
}

class Persian: Cat {
    override func speak() {
        print("Mrrrow!")
    }
}

class Lion: Cat {
    override func speak() {
        print("Roar!")
    }
}

let corgi = Corgi(numberOfLegs: 4)
corgi.speak() //Arf!
let poodle = Poodle(numberOfLegs: 4)
poodle.speak() //Woof!
let persian = Persian(numberOfLegs: 4, isTame: true)
persian.speak() //Mrrrow!
let lion = Lion(numberOfLegs: 4, isTame: false)
lion.speak() //Roar!
