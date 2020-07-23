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
    
    @State var newTask = "" //-> stores user's new tasks
    
    //for testing the UI design/implementation
    var simpleTasks : [String] = [
    "Task one", "Task two","Task three"]
    
    var body: some View {
        List{
            //creating one view for every element
            ForEach(simpleTasks, id: \.self) { item in
                HStack {
                    Text(item)
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
            }.frame(height: rowHeight)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
