//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 07/03/2024.
//

import Foundation

extension Date {
    
//    func convertToMonthYearFormat() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM d, yyyy"
//        
//        return dateFormatter.string(from: self) // "Jan 2013" format
//    }
    
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())                  // Jan 2008 format
       // return formatted(.dateTime.month(.wide).year(.twoDigits)) // January 08 format
       // return formatted(.dateTime.month(.twoDigits).year())      // 01/2008 format
    }
    
}
