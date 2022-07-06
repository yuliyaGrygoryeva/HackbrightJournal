//
//  DetailView.swift
//  HackbrightJournal
//
//  Created by Yuliya  on 7/6/22.
//

import SwiftUI

struct DetailView: View {
    
    var entry: Entry?
    
    @State var entryTitleText: String = ""
    @State var entryBodyText: String = "Write somethong"
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                Text("Title")
                TextField("Placeholder", text: $entryTitleText)
            }.padding()
            
            VStack(alignment: .leading){
                HStack {
                Text("Body")
                    Spacer()
                    Button {
                        entryBodyText = ""
                    } label: {
                            Image(systemName: "xmark.circle.fill")
                        }
                    }
                TextEditor(text: $entryBodyText)
            }.padding()
            
            Spacer()
            
              Button {
                    //Action
                  //Stopping point
                  // Save entry
                    print(entryTitleText)
                    print(entryBodyText)
                
              } label: {
                    ZStack{
                    Rectangle().fill(.ultraThinMaterial)
                        .cornerRadius(12)
                    Text("Tap me")
                }
                
        }.frame(width: UIScreen.main.bounds.width - 40, height: 55)
        }.navigationTitle("Detail View")
            .onAppear{
                if let entry = entry {
                    
                    entryTitleText = entry.title
                    entryBodyText = entry.body
                }
            }
        }
}


struct DetailView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
        DetailView()
        }
    }
}

