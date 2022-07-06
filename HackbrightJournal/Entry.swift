//
//  Entry.swift
//  HackbrightJournal
//
//  Created by Yuliya  on 7/6/22.
//

import Foundation
struct Entry: Identifiable {
    var title:String
    var body: String
    var data = Data()
    var id = UUID()
    
}
