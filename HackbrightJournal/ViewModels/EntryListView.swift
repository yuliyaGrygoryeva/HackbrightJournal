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
                VStack {
                    HStack{
                    // day streak tile
                    ZStack {
                        Rectangle().fill(.ultraThinMaterial)
                        VStack {
                            Text(String(viewModel.streak))
                                .font(.title)
                                .bold()
                            Text("DAY STREAK")
                                .font(.headline)
                        }
                    }.cornerRadius(12)
                    
                        ZStack {
                            Rectangle().fill(.ultraThinMaterial)
                            VStack {
                                Text(String(viewModel.entries.count))
                                    .font(.title3)
                                    .bold()
                                Text("ENTRIES")
                                    .font(.caption)
                            }
                        }.cornerRadius(12)
                       
                        ZStack {
                            Rectangle().fill(.ultraThinMaterial)
                            VStack {
                                Image(systemName: viewModel.hasJournaled ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    
                                Text("JOURNALED TODAY")
                                    .font(.caption2)
                            }
                        }.cornerRadius(12)
                    
                    }
                }.padding(.horizontal)
                    .frame(height: 140)
                
                // List of entries
                
                
                List {
                    Section("My entries ") {
                        ForEach(viewModel.entries) { entry in
                            
                            NavigationLink {
                                // Destination
                                DetailView(entry: entry, entryViewModel: viewModel)
                                
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(entry.title)
                                        .bold()
                                        .font(.headline)
                                    Text(entry.body)
                                        .font(.system(size: 14))
                                        .lineLimit(2)
                                }.padding()
                                    .frame(maxHeight: 115)
                            }
                        }
                    }
                }
                .frame(height: CGFloat(viewModel.entries.count * 115 + 25))
                .background(.red)
                .listStyle(.plain)
            
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
