//
//  DetailView.swift
//  HackbrightJournal
//
//  Created by Yuliya  on 7/6/22.
//

import SwiftUI

struct DetailView: View {
    // MARK: - Landing pad
    var entry: Entry?
    
    // state variables
    @State var entryTitleText: String = ""
    @State var entryBodyText: String = "Write somethong"
    
    
    @Environment(\.dismiss) private var dismiss
    
    // View model
    @ObservedObject var entryViewModel: EntryListViewModel // Required
    
    
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                Text("Title")
                    .font(.system(size: 18, weight: .heavy, design: .monospaced))
                    .foregroundColor(.secondary)
                TextField("Placeholder", text: $entryTitleText)
            }.padding()
            
            HStack {
                Rectangle().fill(.secondary).frame(width: 2)
                VStack(alignment: .leading){
                    HStack {
                    Text("Body")
                            .font(.system(size: 18, weight: .heavy, design: .monospaced))
                            .foregroundColor(.secondary)
                        Spacer()
                        Button {
                            entryBodyText = ""
                        } label: {
                                Image(systemName: "xmark.circle.fill")
                            }
                        }
                    TextEditor(text: $entryBodyText)
                }.padding()
            }.padding()
            
            Spacer()
            
            VStack {
                HStack (spacing: 0) {
                    Text("Created on ")
                    if let entry = entry {
            //            Text(entry.date.formatDate())
                    }
                    else {
              //          Text(Date().formatDate())
                    }
                }.font(.caption)
                    .foregroundColor(.secondary)
                    Button {
                      if entry == nil {
                      
                      prepareForCreateEntry(title: entryTitleText, body: entryBodyText)
                      }
                      else {
                          //prepare update
                          prepareForUpdateEntry()
                      }
                          
                          
                          // dismiss
                          
                      dismiss()
                      
                      //Action
                      //Stopping point
                      // Save entry
                        print(entryTitleText)
                        print(entryBodyText)
                    
                  } label: {
                        ZStack{
                            // very bottom
                        Rectangle().fill(.ultraThinMaterial)
                            .cornerRadius(12)
                            // very top
                            Text(entry == nil ? "Save" : "Update")
                    }
                    
              }.frame(width: UIScreen.main.bounds.width - 40, height: 55)
            }
        }.navigationTitle("Detail View")
            .onAppear{
                if let entry = entry {
                    
                    entryTitleText = entry.title
                    entryBodyText = entry.body
                }
            }
        }

    func prepareForCreateEntry(title: String?, body: String?) {
        
        // make sure that we have necessery component
        guard let title = title, !title.isEmpty,
              let body = body, !body.isEmpty else { return }
        // create that entry
        
        let entry = Entry(title: title, body: body)
        
        entryViewModel.createEntry(entry)
    }

    func prepareForUpdateEntry() {
        let title = entryTitleText
        let body = entryBodyText
        guard !title.isEmpty, !body.isEmpty else { return }
        if let entry = entry {
            entryViewModel.update(entry, title, body)
        }
    }
    
}


struct DetailView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
        DetailView(entryViewModel: EntryListViewModel())
        }
    }
}

