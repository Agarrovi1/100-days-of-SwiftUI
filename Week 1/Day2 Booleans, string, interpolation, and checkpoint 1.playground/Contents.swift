import Cocoa

//Booleans
let goodDogs = true
var gameOver = false

let isMultiple = 120.isMultiple(of: 3)

//Booleans has an operator "!" which means "not", flips a booleans value from true to false or false to true
var isAuthenticated = false
isAuthenticated = !isAuthenticated
print(isAuthenticated) //true
isAuthenticated = !isAuthenticated
print(isAuthenticated) //false

//booleans has some functionality .toggle() that flips a booleans value
print(gameOver) //false
gameOver.toggle()
print(gameOver) //true

//How to join Strings together
let firstPart = "Hello, "
let secondPart = "world!"
let greeting = firstPart + secondPart //"Hello, world!"

let people = "Haters"
let action = "hate"
let lyric = people + " gonna " + action //"Haters gonna hate"
print(lyric)

let luggageCode = "1" + "2" + "3" + "4" + "5"
//swift adds and makes new string one at a time and can be wasteful
//"12" -> "123" -> "1234" ...

//string interpolation
let name = "Taylor"
let age = 26
let message = "Hello, my name is \(name) and I'm \(age) years old."
print(message) //Hello, my name is Taylor and I'm 26 years old."

let number = 11
//let missionMessage = "Apollo " + number + " landed on the moon"
//gets an error

let missonMessage = "Apollo " + String(number) + " landed on the moon"
let missionMessage2 = "Apollo \(number) landed on the moon"

//can use calculations inside string interpolation too
print("5 x 5 is \(5 * 5)") //5 * 5 is 25

//Checkpoint 1
/*
 1. Create a constant holding any temperature in Celsius
 2. converts it Fahrenheit by multiplying by 9, deviding by 5 then add 32
 print the result for the user showing both the Celsius and Fahrenheit values
 */

let celsius: Double = 22
let fahrenheit = (celsius * 9.0 / 5.0) + 32.0
print("The temperature is \(celsius)°C / \(fahrenheit)°F")
