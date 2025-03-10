import Cocoa

//Variables and Constants
//2 ways of storing data depending on whether you want them to change over time

//variable - it varies and can change over time
var greeting = "Hello, playground"

var currentChapter = "One"
currentChapter = "Two"
currentChapter = "Three"
//when run currentChapter = "Three"

//constant - doesn't change value
let character = "Daphne"
//character = "Eloise"
//character = "Francesca"
//trying change a constant gives error "Cannot assign to value: 'character' is a 'let' constant"

var playerName = "Roy"
print(playerName)

playerName = "Dani"
print(playerName)

playerName = "Sam"
print(playerName)

//Swift uses the convention of camel case for naming data
let managerName = "Michael Scott"
let dogBreed = "Samoyed"
let meaningOfLife = "How many roads must a man walk down"

//Strings, text-like data, begins and end with Double quotes
let actor = "Denzel Washington"
let filename = "paris.jpg"
let result = "⭐️ You win! ⭐️"

//can use backslash before each quotation to put double quotes in string
let quote = "Then he tapped a sign saying \"Believe\" and walked away."

//Swift doesn't like line breaks in strings, below will give error
/*
 let movie = "A day in
 the life of an
 Apple engineer"
 */

//to create a string across multiple lines use 3 double quotes
let movie = """
A day in
the life of an
Apple engineer
"""

//There are some functionality with strings
//can find the length, how many characters in a string
print(actor.count)

let nameLength = actor.count
print(nameLength)

//can make the text uppercased
print(result.uppercased())

//can tell you if a string starts with some letters of our choosing:
print(movie.hasPrefix("A day"))

//and the opposite, see if a string ends with letters of our choosing
print(filename.hasSuffix(".jpg"))

//Integers, Int, for when you use whole numbers
let score = 10

//can write big numbers

//let reallyBig = 100000000

//can use underscores "_" to make it visually easier to read
let reallyBig = 100_000_000

//swift doesn't care how many underscores you put, you can write it like this if you want, same number
//let reallyBig = 1_00__00___00____00

//can create integers from other integers using arithmetic operators + addition,- subtraction,* multiplication,/ division
let lowerScore = score - 2
let higherScore = score + 10
let doubledScore = score * 2
let squaredScore = score * score
let halvedScore = score / 2
print(score)

//don't have to keep making new constants, Swift has special operations to adjust an int
var counter = 10
counter = counter + 5

//compund assignment operators
counter += 5
print(counter)

counter *= 2
print(counter)
counter -= 10
print(counter)
counter /= 2
print(counter)

//Int like String has useful functionality attached
let number = 120
print(number.isMultiple(of: 3))

//can use on number directly
print(120.isMultiple(of: 3))

//Decimals or Double
let decimalNumber = 0.1 + 0.2
print(number)

//can't mix Int and Double
let a = 1
let b = 2.0
//let c = a + b
//gives error "Binary operator '+' cannot be applied to operands of type 'Int' and 'Double'"

//swift won't let it run because of type safety so types aren't mixed accidentally

//need to tell Swift explicitly to treat the Double as an Int
let c = a + Int(b)

//or treat Int as a Double
let d = Double(a) + b

//Swift decides wheter you wanted to create an Int or Double based on the number you provide

let double1 = 3.1
let double2 = 3131.3131
let double3 = 3.0
let int1 = 3

//once swift decides what data a variable or constant holds it must always hold that same data type

//this is ok
var name = "Nicolas Cage"
name = "John Travolta"

//this is not
//name = 57
//gets error: Cannot assign value of type 'Int' to type 'String'

//decimals has the same range of operators as integers
var rating = 5.0
rating *= 2

