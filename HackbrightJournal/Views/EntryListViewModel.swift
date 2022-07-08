//
//  EntryListViewModel.swift
//  HackbrightJournal
//
//  Created by Yuliya  on 7/6/22.
//

import Foundation

// Ensure that changes on this viewModel are ABLE to be Observed
class EntryListViewModel: ObservableObject {
    // SOT
    @Published var entries: [Entry] = []
    @Published var streak: Int = 0
    @Published var hasJournaled: Bool = false
//    [
//    Entry(title: "This is a test 1", body: "Bodr"),
//    Entry(title: "This is a test 2", body: "Bodr"),
//    Entry(title: "This is a test 3", body: "Bodr"),
//    Entry(title: "This is a test 4", body: "Bodr")
//
//    ]
    
    
    // MARK: - magic strings
    let dayStreakText = "DAY STREAK"
    let entriesText = "ENTRIES"
    static let emptyMessage = "You have not written any entries yet"
    
    //CRUD
    // func(keyword for function) functionName(argumentLabels: Parameters) -> Return Type { Body }
    func createEntry(_ entry: Entry) {
        entries.append(entry)
        // Save
        saveToPersistenceStore()
    }
    
    func update(_ entry: Entry, _ title: String, _ body: String) {
        guard let index = entries.firstIndex(of: entry) else { return }
        entries[index].title = title
        entries[index].body = body
        saveToPersistenceStore()
    
    }
    
    func removeEntry(indexSet: IndexSet) {
        entries.remove(atOffsets: indexSet)
        saveToPersistenceStore()
    }
    
    
    // MARK: - Dashboard
    func getStreak() {
        var localStreak: Int = 0
        var previousEntry: Entry?
        
        // loop through entries
        for entry in entries {
            // mke sure we have previous entry
            guard let previousEntryDate = previousEntry?.date else {
                localStreak += 1
                previousEntry = entry
                continue
            }
            //next compare entry 1 and entry 2
            let components = Calendar.current.dateComponents([.hour], from: previousEntryDate, to: entry.date)
            let hours = components.hour
            if let hours = hours, hours <= 24 {
                if Calendar.current.isDate(previousEntryDate, inSameDayAs: entry.date) {
                    continue
                } else {
                    localStreak += 1
                }
                
            } else {
                return self.streak = localStreak
            }
            previousEntry = entry
        }
        self.streak = localStreak
    }
    
    
    func hasJournaledToday() {
        let today = Date()
        for entry in entries {
            if Calendar.current.isDate(today, inSameDayAs: entry.date) {
                self.hasJournaled = true
                return
            } else {
                continue
            }
        }
        self.hasJournaled = false
    }
    
    
        //
    // MARK: - Persistence
    // create a place to store data, save data, load data
    func createPersistanceStore() -> URL {   //URL is an address in memory
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Entries777.json")
        return fileURL
    }
    
    func saveToPersistenceStore(){
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: createPersistanceStore())
            
        } catch {
            print("Error encoding.")
        }
    }
    
    func loadFromPersistanceStore(){
        do {
            let data = try Data(contentsOf: createPersistanceStore())
            //                             decode as  ,  decode from
            entries = try JSONDecoder().decode([Entry].self, from: data)
        }
        catch {
            print("Error decoding.")
        }
    }

}
