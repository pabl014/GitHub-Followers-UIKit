//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 07/03/2024.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter.string(from: self) // "Jan 2013" format
    }
    
}
