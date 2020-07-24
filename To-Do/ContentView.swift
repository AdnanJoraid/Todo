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
    
    @State var newTaskTitle = "" //-> stores user's new tasks
    
    
    
    var body: some View {
        NavigationView{
            List{
                //creating one view for every element
                ForEach(fetchedItems, id: \.self) { item in
                    HStack {
                        Text(item.taskTitle ?? "Empty")
                        Spacer()
                        Button(action: {self.markDoneTasks(at: self.fetchedItems.firstIndex(of: item)!)}){
                            Image(systemName: "square")
                                .imageScale(.large)
                                .foregroundColor(.gray)
                            
                        }
                        
                    }
                } .frame(height: rowHeight)
                
                HStack {
                    TextField("Add task...", text: $newTaskTitle, onCommit: {self.saveTasks()})
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
    
    func saveTasks(){
        //preventing the user from adding a task with a null title. 
        guard self.newTaskTitle != "" else {
            return
        }
        let newTaskItem = Tasks(context: self.managedObjectContext)
        newTaskItem.taskTitle = self.newTaskTitle
        newTaskItem.dateCreated = Date()
        newTaskItem.taskDone = false
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
        self.newTaskTitle = ""
    }
    
    func markDoneTasks(at index: Int){
        let item = fetchedItems[index]
        item.taskDone = true
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
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
