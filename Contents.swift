import UIKit
import Foundation

@propertyWrapper
struct Trimmed {
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set {
            value = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                .replacingOccurrences(of: "[\\s]+", with: " ", options: .regularExpression, range: nil)
        }
    }
    
    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}

struct TrimmedString {
    @Trimmed var str: String
}

var testTrimmedString = TrimmedString(str: " Need  to check   ")
print(testTrimmedString.str)

@propertyWrapper
struct UpperCase {
    private(set) var value: String = ""
    private var isLastDot = true
    
    var wrappedValue: String {
        get { value }
        set {
            guard newValue.count >= 2
            else {
                value = newValue
                return
            }
            
            for i in 0...newValue.count - 1 {
                let index = newValue.index(newValue.startIndex, offsetBy: i)
                guard i >= 1
                else {
                    value.append(newValue[index])
                    continue
                }
                let prevIndex = newValue.index(newValue.startIndex, offsetBy: i - 1)
                if !newValue[index].isWhitespace && isLastDot {
                    if i > 0{
                        if newValue[prevIndex] == "." {
                            value.append(newValue[index])
                            continue
                        }
                    }
                    value.append(newValue[index].uppercased())
                    isLastDot = false
                } else {
                    if newValue[index] == "." {
                        isLastDot = true
                    }
                    value.append(newValue[index])
                }
            }
        }
    }
    
    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}

struct UpperCaseString {
    @UpperCase var str: String
}

var upperCaseTest = UpperCaseString(str: ".ffefef.   fsdjie.rjeiwjfs")
print(upperCaseTest.str)

@propertyWrapper
struct DateFormat {
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyy HH:mm"
            let dateString = dateFormatter.string(from: Date())
            print("At: \(dateString)")
            return value
        }
        set {  }
    }
    
    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}

struct DateFormatString {
    @DateFormat var str: String
}

var testDate = DateFormatString(str: "Check")
var check = testDate.str

