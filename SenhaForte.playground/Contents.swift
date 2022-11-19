import Foundation

let password1 = Password(value: "p1as2sword3") // inválida critério 1
let password2 = Password(value: "P1AS2SWORD3") // inválida critério 2
let password3 = Password(value: "Password") // inválida critério 3
let password4 = Password(value: "1Pas2sword3") // inválida critério 4
let password5 = Password(value: "Pas2sword3@") // inválida critério 5
let password6 = Password(value: "Password123") // inválida critério 6
let password7 = Password(value: "1Pa2") // inválida critério 7
let thePerfectPassword = Password(value: "Perfect1")

let passwords = [password1, password2, password3, password4, password5, password6, password7, thePerfectPassword]

for password in passwords {
    print(password.value, password.isPasswordValid())
}

struct Password {
    let value: String

    func isPasswordValid() -> Bool {
        isSizeValid() && hasCharUpperCased() && hasCharLowerCased() && hasNumber() && isFirstLetterUpperCased() && hasNotSpecialCharacteres() && hasNoSequenceNumbers()
    }

    private func isSizeValid() -> Bool {
        value.count > 5 && value.count < 15
    }

    private func hasCharUpperCased() -> Bool {
        for char in value {
            if !isANumber(char) {
                let upperCasedChar = char.uppercased().first
                if isEqual(char, upperCasedChar) { return true }
            }
        }
        return false
    }

    private func hasCharLowerCased() -> Bool {
        for char in value {
            if !isANumber(char) {
                let lowerCasedChar = char.lowercased().first
                if isEqual(char, lowerCasedChar) { return true }
            }
        }
        return false
    }

    private func hasNumber() -> Bool {
        for char in value {
            if isANumber(char) { return true }
        }
        return false
    }

    private func isFirstLetterUpperCased() -> Bool {
        let firstChar = value.first
        let upperCasedChar = value.uppercased().first

        return isEqual(upperCasedChar, firstChar) && !isANumber(firstChar)
    }

    private func hasNotSpecialCharacteres() -> Bool {
        let asciiValues = value.asciiValues

        for asciiValue in asciiValues {
            if !isAValidCharacter(asciiValue) { return false }
        }
        return true
    }

    private func hasNoSequenceNumbers() -> Bool {
        var valueCopy = value
        var lastChar = valueCopy.popLast()
        var penultimateChar = valueCopy.popLast()

        for _ in 0...valueCopy.count-1 {
            if lastChar == nil { break }
            if isANumber(lastChar) && isANumber(penultimateChar) { return false }

            lastChar = valueCopy.popLast()
            penultimateChar = valueCopy.popLast()
        }
        return true
    }

    private func isEqual(_ char1: Character?, _ char2: Character?) -> Bool {
        return char1 == char2
    }

    private func isANumber(_ char: Character?) -> Bool {
        char == "1" || char == "2" || char == "3" || char == "4" || char == "5" || char == "6" || char == "7" || char == "8" || char == "9" || char == "0"
    }

    private func isAValidCharacter(_ asciiValue: UInt8) -> Bool {
        (asciiValue >= 48 && asciiValue <= 57) || (asciiValue >= 65 && asciiValue <= 90) || (asciiValue >= 97 && asciiValue <= 122)
    }
}

extension StringProtocol {
    var asciiValues: [UInt8] { compactMap(\.asciiValue) }
    /*
     0-9 = 48 a 57
     A-Z = 65 a 90
     a-z = 97 a 122

     func explore() {
         let array = ["a", "z", "0", "9", "A", "Z"]
         for i in array {
             print(i.asciiValues)
         }
     }
     */
}

