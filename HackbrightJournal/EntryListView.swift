//
//  EntryListView.swift
//  HackbrightJournal
//
//  Created by Yuliya  on 7/6/22.
//

import SwiftUI

struct EntryListView: View {
    
   @State var viewModel = EntryListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section("My entries ") {
                    ForEach(viewModel.entries) { entry in
                    
                        NavigationLink {
                            // Destination
                            DetailView(entry: entry)
                            
                        } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(entry.title)
                                .bold()
                                .font(.headline)
                            Text(entry.body)
                                .font(.system(size: 14))
                        }.padding()
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Dream Journal")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink{
                       DetailView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
}

struct EntryListView_Preview: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}
