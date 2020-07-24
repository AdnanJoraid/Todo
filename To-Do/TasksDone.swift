//
//  TasksDone.swift
//  To-Do
//
//  Created by Adnan Joraid on 2020-07-24.
//  Copyright © 2020 Adnan Joraid. All rights reserved.
//

import SwiftUI

struct TasksDone: View {
    //accessing managedObjectContext:
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Tasks.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.dateCreated, ascending: false)], predicate: NSPredicate(format: "taskDone = %d", true))
    
    var fetchedItems: FetchedResults<Tasks>
    
    var body: some View {
        List {
            ForEach(fetchedItems, id: \.self) { item in
                HStack{
                    Text(item.taskTitle ?? "Empty")
                    Spacer()
                    Image(systemName: "checkmark.square.fill")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                    
                }
                .frame(height: rowHeight)
            }
            .onDelete(perform: removeDoneTasks)
            
            
            
            
        }
        .navigationBarTitle(Text("tasks done"))
        .listStyle(GroupedListStyle())
    }
    
    func removeDoneTasks(offset: IndexSet){
        for index in offset {
            let item = fetchedItems[index]
            managedObjectContext.delete(item)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct TasksDone_Previews: PreviewProvider {
    static var previews: some View {
        TasksDone()
    }
}
