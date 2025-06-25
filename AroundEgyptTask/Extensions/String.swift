//
//  String.swift
//  MovieExplorer
//
//  Created by Mostafa Elemam on 16/06/2025.
//

import Foundation

extension String {
    var removedSemiColon : String {
        //remove semiColon from string to get the error description ( used for alamofire)
        let index = self.firstIndex(of: ":")

        if let index = index {
            let removedString = self[self.index(after: index)...]
            return String(removedString).trimmed
        } else {
            return self
        }
    }
    var titleCase : String {
        //        removes underscore from String and return capitalized words
        if self.contains("_") {
            
            let words = self.components(separatedBy: "_")
            let capitalizedWords = words.map { $0.capitalized }
            return capitalizedWords.joined(separator: " ")
        }
        return self
    }
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    /// SwifterSwift: Check if the given string contains only white spaces or empty string.
    var isEmptyOrWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    var intValue: Int? {
        return Int(self)
    }
    var url: URL? {
        return URL(string: self)
    }
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var isNumeric: Bool {
        return !isEmpty && rangeOfCharacter(from: .decimalDigits) == startIndex..<endIndex
    }
    var formattedFromDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        if let date = formatter.date(from: self) {
            formatter.dateFormat = "dd MMM, yyyy"
            return formatter.string(from: date)
        }
        return self
    }
    //Methods
    
    /// - Returns: true if string ends with substring.
    func ends(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }
    /// - Returns: Date from string if applicable.
    func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    /// - Returns: `true` if string matches the pattern.
    func matches(pattern: String) -> Bool {
            return range(of: pattern, options: .regularExpression, range: nil, locale: nil) != nil
        }
    
}
