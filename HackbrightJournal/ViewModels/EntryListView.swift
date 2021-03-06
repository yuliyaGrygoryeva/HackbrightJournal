//
//  EntryListView.swift
//  HackbrightJournal
//
//  Created by Yuliya  on 7/6/22.
//

import SwiftUI

struct EntryListView: View {
    
   @ObservedObject var viewModel = EntryListViewModel()
    
    var body: some View {
        NavigationView {
            // Dashboard
            ScrollView {
               
                JournalDashBoard(viewModel: viewModel)
                .padding(.horizontal)
                    .frame(height: 140)
                
                
                if viewModel.entries.isEmpty {
                   EmptyJournalTile()
                    .padding(.top)
                    } else {
                
                // List of entries
                List {
                    Section("My entries ") {
                        ForEach(viewModel.entries) { entry in
                            
                            NavigationLink {
                                // Destination
                                DetailView(entry: entry, entryViewModel: viewModel)
                                
                            } label: {
                               JournalRowView(entry: entry)
                                .padding()
                                    .frame(maxHeight: 115)
                            }
                        }
                        .onDelete(perform: viewModel.removeEntry(indexSet:))
                    }
                }
                .frame(height: CGFloat(viewModel.entries.count * 115 + 25))
                .background(.red)
                .listStyle(.plain)
            
            }
            }
            .navigationTitle("Dream Journal")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink{
                       DetailView(entryViewModel: viewModel)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear{
                setupView()
            }
            
        }
    }
    func setupView() {
        viewModel.loadFromPersistanceStore()
        viewModel.getStreak()
        viewModel.hasJournaledToday()
    }
    
    
}

struct EntryListView_Preview: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}

struct EmptyJournalTile: View {
    var body: some View {
        VStack(spacing: 24){
        Divider()
        
        ZStack {
            Rectangle().fill(.ultraThinMaterial)
            Text(EntryListViewModel.emptyMessage)
                    .font(.caption)
                    .padding()
                    .font(.system(.caption, design: .monospaced))
        }.cornerRadius(12)
            .frame(width: UIScreen.main.bounds.width - 40)
        }
    }
    
}

struct JournalRowView: View {
    var entry: Entry
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(entry.title)
                .bold()
                .font(.headline)
            Text(entry.body)
                .font(.system(size: 14))
                .lineLimit(2)
        }
    }
    
    
}



struct JournalDashBoard: View {
    @ObservedObject var viewModel: EntryListViewModel
    var body: some View {
        VStack {
            HStack{
                // day streak tile
                DayStreakTile(viewModel: viewModel)
                
                VStack {
                    TotalEntriesTile(viewModel: viewModel)
                    
                    JournalTodayTile(viewModel: viewModel)
                }
            }
        }
    }
}



struct DayStreakTile: View {
    @ObservedObject var viewModel: EntryListViewModel
    var body: some View{
        ZStack {
            Rectangle().fill(.ultraThinMaterial)
            VStack {
                Text(String(viewModel.streak))
                    .font(.title)
                    .bold()
                Text(viewModel.dayStreakText)
                    .font(.headline)
            }
        }.cornerRadius(12)
    }
}


struct TotalEntriesTile: View {
    @ObservedObject var viewModel: EntryListViewModel
    var body: some View{
        ZStack {
            Rectangle().fill(.ultraThinMaterial)
            VStack {
                Text(String(viewModel.entries.count))
                    .font(.title3)
                    .bold()
                Text(viewModel.entriesText)
                    .font(.caption)
            }
        }.cornerRadius(12)
    }
}

struct JournalTodayTile: View {
    @ObservedObject var viewModel: EntryListViewModel
    var body: some View {
        ZStack {
            Rectangle().fill(.ultraThinMaterial)
            VStack {
                Image(systemName: viewModel.hasJournaled ? "checkmark.circle.fill" : "xmark.circle.fill")
                    
                Text("JOURNALED TODAY")
                    .font(.caption2)
            }
        }.cornerRadius(12)
    }
}
