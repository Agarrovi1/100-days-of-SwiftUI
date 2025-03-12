import Cocoa

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for os in platforms {
    print("Swift works great on \(os).")
}

/*
 prints
 Swift works great on iOS.
 Swift works great on macOS.
 Swift works great on tvOS.
 Swift works great on watchOS.
 */

for name in platforms {
    print("Swift works great on \(name)")
}

for rubberChicken in platforms {
    print("Swift works great on \(rubberChicken)")
}

for i in 1...12 {
    print("5 x \(i) is \(5 * i)")
}

/*
 prints
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

for i in 1...12 {
    print("The \(i) times table:")
    for j in 1...12 {
        print("  \(j) x \(i) is \(j * i)")
    }
    
    print()
}

/*
 The 1 times table:
   1 x 1 is 1
   2 x 1 is 2
   3 x 1 is 3
   4 x 1 is 4
   5 x 1 is 5
   6 x 1 is 6
   7 x 1 is 7
   8 x 1 is 8
   9 x 1 is 9
   10 x 1 is 10
   11 x 1 is 11
   12 x 1 is 12

 The 2 times table:
   1 x 2 is 2
   2 x 2 is 4
   3 x 2 is 6
   4 x 2 is 8
   5 x 2 is 10
   6 x 2 is 12
   7 x 2 is 14
   8 x 2 is 16
   9 x 2 is 18
   10 x 2 is 20
   11 x 2 is 22
   12 x 2 is 24
 
 and so on
 */

for i in 1...5 {
    print("Counting from 1 through 5: \(i)")
}

/*
 Counting from 1 through 5: 1
 Counting from 1 through 5: 2
 Counting from 1 through 5: 3
 Counting from 1 through 5: 4
 Counting from 1 through 5: 5
 */

print()

for i in 1..<5 {
    print("Counting 1 up to 5: \(i)")
}

/*
 Counting 1 up to 5: 1
 Counting 1 up to 5: 2
 Counting 1 up to 5: 3
 Counting 1 up to 5: 4
 */

var lyric = "Haters gonna"

for _ in 1...5 {
    lyric += " hate"
}

print(lyric) // Haters gonna hate hate hate hate hate

//How to use a while loop to repeat work
var countdown = 10

while countdown > 0 {
    print("\(countdown)...")
    countdown -= 1
}

print("Blast off!")
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
 Blast off!
 */

let id = Int.random(in: 1...1000)
let amount = Double.random(in: 0...1)

//create an integer to store our roll
var roll = 0

//carry on looping until we reach 20

/*
while roll != 20 {
    //roll a new dice and print what it was
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}
*/

//if we're here it means the loop ended - we got a 20!
print("Critical hit!")

//How to skip loop items with break and continue
let filenames = ["me.jpg", "work.txt","sophie.jpg","logo.psd"]

for filename in filenames {
    if filename.hasSuffix(".jpg") == false {
        continue
    }
    
    print("Found picture: \(filename)")
}

let number1 = 4
let number2 = 14
var multiples = [Int]()

for i in 1...100_000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)
        
        if multiples.count == 10 {
            break
        }
    }
}

//Checkpoint 3
/*
 Fizz buzz
 1. if it's a multiple of 3, print "Fizz"
 2. if it's a multiple of 5 print "Buzz"
 3. if it's a multiple of 2 and 5 print "FizzBuzz"
 4. Otherwise just print the number
 */

for number in 1...100 { 
    switch true {
    case number.isMultiple(of: 3) && number.isMultiple(of: 5):
        print("FizzBuzz")
    case number.isMultiple(of: 3):
        print("Fizz")
    case number.isMultiple(of: 5):
        print("Buzz")
    default:
        print("\(number)")
    }
}
