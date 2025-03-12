import Cocoa

//How to store ordered data in arrays
var beatles = ["John", "Paul", "George", "Ringo"]
let numbers = [4,8,15,16,23,42]
var temperatures = [25.3, 26.2,26.4]

print(beatles[0]) //John
print(numbers[1]) //8
print(temperatures[2]) //26.4

beatles.append("Adrian")

beatles.append("Allen")
beatles.append("Adrian")
beatles.append("Novall")
beatles.append("Vivian")

//arrays can only contain one type of data
//temperatures.append("Chris") //gets error

let firstBeatle = beatles[0]
let firstNumber = numbers[0]
//let notAllowed = firstBeatle + firstNumber
//gets error

//Array that holds Integers
var scores = Array<Int>()
scores.append(100)
scores.append(80)
scores.append(85)
print(scores[1]) //80

var albums = Array<String>()
albums.append("Folklore")
albums.append("Fearless")
albums.append("Red")

//arrays are common so there are other ways to create it
var albums2 = [String]()
albums2.append("Folklore")
albums2.append("Fearless")
albums2.append("Red")

//swift needs to know what type of data its holding when creating array, but it can figure it out on its own with an initial value
var albums3 = ["Folklore"]
albums3.append("Fearless")
albums3.append("Red")

//there are additional functionality with arrays
print(albums.count) //3

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count) //4

characters.remove(at: 2)
print(characters.count) //3

characters.removeAll()
print(characters.count) //0

let bondMovies = ["Casino Royale", "Spector", "No Time to Die"]
print(bondMovies.contains("Frozen")) //false

let cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted()) //["Budapest","London","Rome","Tokyo"]
//returns a new array with the items sorted in ascending alphabetacal order

let presidents = ["Bush","Obama","Trump","Biden"]
let reversedPresidents = presidents.reversed()
print(reversedPresidents)


//How to store and find data in dictionaries
var employee = ["Taylor Swift", "Singer", "Nashville"]
print("Name: \(employee[0])")
print("Job title: \(employee[1])")
print("Location: \(employee[2])")

//cant be sure what item at a specific index or if the index exists leading to crashes
print("Name: \(employee[0])")
employee.remove(at: 1)
print("Job title: \(employee[1])") //Job title: Nashville
//print("Location: \(employee[2])") error

let employee2 = ["name": "Taylor Swift", "job": "Singer", "location": "Nashville"]

//or can write it like this
//left is keys, right is values
let employee3 = [
    "name": "Taylor Swift",
    "job": "Singer",
    "location": "Nashville"
]

print(employee2["name"])
print(employee2["job"])
print(employee2["location"])

print(employee2["password"])
print(employee2["status"])
print(employee2["manager"])

//optionals because the existance of the data is optional, it might be there it might be not

//can provide a default value
print(employee2["name", default: "Unknown"])
print(employee2["job", default: "Unknown"])
print(employee2["location", default: "Unknown"])

//can use other data types in keys and values
let hasGraduated = [
    "Eric": false,
    "Maeve": true,
    "Otis": false,
]

let olymics = [
    2012: "London",
    2016: "Rio de Janeiro",
    2020: "Tokyo",
]

print(olymics[2012, default: "Unknown"])
var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["Lebron James"] = 206

var archEnemies = [String: String]()
archEnemies["Batman"] = "The Joker"
archEnemies["Superman"] = "Lex Luthor"

//can rewrite a value
archEnemies["Batman"] = "Penguin"

//How to use sets for fast data lookup
var people = Set(["Denzel Washington", "Tom Cruise", "Nicholas Cage", "Samuel L Jackson"])
print(people)
//might be out of order, sets don't care for what order its items come in

people.insert("Denzel Washington")
people.insert("Tom Cruise")
people.insert("Nicolas Cage")
people.insert("Samuel L Jackson")

//Set use .insert() instead of .append() because the set will store the items inwhatever order it wants

//How to create and use enums
var selected = "Monday"
selected = "Tuesday"

selected = "January"
selected = "Friday "

enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

var day = Weekday.monday
day = Weekday.tuesday
day = Weekday.friday

//can write like this with many cases
enum Weekday2 {
    case monday, tuesday, wednesday, thursday, friday
}

day = .tuesday
day = .friday
