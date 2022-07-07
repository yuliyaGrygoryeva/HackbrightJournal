//
//  Entry.swift
//  HackbrightJournal
//
//  Created by Yuliya  on 7/6/22.
//

import Foundation

// What is a struct?
// Struct is like a class, BUT
    // -- Structs cannot inherit things from other structs ( Classes can )
    // -- Classes can have a deinitializer
    // -- Structs have memberwise initializer
    // -- Structs are VALUE types ( Classes are Reference type )
    // -- Structs are LIGHT WEIGHT

struct Entry: Identifiable, Codable, Equatable {
    var title:String
    var body: String
    var date = Date()
    var id = UUID()
    
}
