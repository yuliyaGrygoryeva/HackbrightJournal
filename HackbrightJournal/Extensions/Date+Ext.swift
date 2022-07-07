//
//  Date+Ext.swift
//  HackbrightJournal
//
//  Created by Yuliya  on 7/7/22.
//

import Foundation
extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMM d")
        return dateFormatter.string(from: self)
    }
}
