//
//  String+Ext.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 07/03/2024.
//

import Foundation

// NOT NECESSARY FILE SINCE LINE decoder.dateDecodingStrategy = .iso8601 WAS ADDED IN NetworkManager.swift

// previously  user.createdAt: String
// String                 -> Date                             -> String
// user.createdAt: String -> func convertToDate() -> Date? {} -> func convertToMonthYearFormat() -> String {} in Date+Ext

// NOW user.createdAt: Date
// Date                 -> String
// user.createdAt: Date -> func convertToMonthYearFormat() -> String {} in Date+Ext

// https://www.nsdateformatter.com
//
//extension String {
//    
//    func convertToDate() -> Date? {
//        
//        let dateFormatter           = DateFormatter()
//        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
//        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
//        dateFormatter.timeZone      = .current
//        
//        return dateFormatter.date(from: self) // "2008-12-19T22:41:55Z" date in string format
//        //return Date() // -> returns current date
//    }
//    
//    func convertToDisplayFormat() -> String {
//        guard let date = self.convertToDate() else { return "N/A" }
//        return date.convertToMonthYearFormat()
//    }
//}
