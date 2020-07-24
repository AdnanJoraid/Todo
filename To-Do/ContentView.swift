//
//  ContentView.swift
//  To-Do
//
//  Created by Adnan Joraid on 2020-07-22.
//  Copyright © 2020 Adnan Joraid. All rights reserved.
//

import SwiftUI

var rowHeight : CGFloat = 50 //-> the height for the dynamic rows

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext //accessing device's internal storage
    @FetchRequest(entity: Tasks.entity() , sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.dateCreated, ascending: false)], predicate: NSPredicate(format: "taskDone = %d", false))
     var fetchedItems : FetchedResults<Tasks>
    
    @State var newTask = "" //-> stores user's new tasks
   
    
    var body: some View {
        NavigationView{
            List{
                //creating one view for every element
                ForEach(fetchedItems, id: \.self) { item in
                    HStack {
                        Text(item.taskTitle ?? "Empty")
                        Spacer()
                        Image(systemName: "square")
                            .imageScale(.large)
                            .foregroundColor(.gray)
                    }
                } .frame(height: rowHeight)
                
                HStack {
                    TextField("Add task...", text: $newTask, onCommit: {print("new Task titles entered")})
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                }.frame(height: rowHeight)
                
                Text("tasks done")
                    .frame(height: rowHeight)
                
            }
            .navigationBarTitle(Text("To-Do"))
            .listStyle(GroupedListStyle()) //remove the separators below the last line
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
        
        return
            ContentView().environment(\.managedObjectContext, context)
    }
}
