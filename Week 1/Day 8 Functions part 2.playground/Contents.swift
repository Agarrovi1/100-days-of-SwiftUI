import Cocoa

func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 20)
printTimesTables(for: 8)

var characters = ["Lana", "Pam", "Ray", "Sterling"]
/*
print(characters.count) //4
characters.removeAll()
print(characters.count) //0
*/

print(characters.count) //4
characters.removeAll(keepingCapacity: true)
print(characters.count) //0

//How to handle errors in functions
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
    
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

//ex of handling an error
/*
do {
    try someRiskyWork()
} catch {
    print("Handle errors here")
}
*/

let string = "12345"
do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error.")
}

//Checkpoint 4

/*
 Write a function that accepts an integer from 1 - 10000 and returns the integer of the square root of that number
 - Can’t use built in square root func
 - If input is less than one or greater than 10,000 then throw “out of bounds” error
 - Only consider integer square roots
 - If you can’t find a square root return a “no root” error

 */

enum SqrtError: Error {
    case outOfBounds, noRoot
}

func findSqRt(num: Int) throws -> Int {
    for i in 1...100 {
        if (i * i) == num {
            return i
        }
        if (i * i) > num {
            throw SqrtError.noRoot
        }
    }
    throw SqrtError.noRoot
}

func sqareRoot(for number: Int) throws -> Int {
    var result: Int = 0
    do {
        if number < 1 {
            throw SqrtError.outOfBounds
        }
        if number > 10_000 {
            throw SqrtError.outOfBounds
        }
        
        result = try findSqRt(num: number)
    } catch SqrtError.outOfBounds {
        print("Out of Bounds")
    } catch SqrtError.noRoot {
        print("No Root")
    }
    return result
}


