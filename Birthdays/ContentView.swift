//
//  ContentView.swift
//  Birthdays
//
//  Created by Scholar on 8/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query private var friends: [Friend]
    @Environment(\.modelContext) private var context
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    var body: some View {
        NavigationStack {
            List { // for each friend that we input, we will be able to input the date of their birthday
                ForEach(friends) { friend in
                    HStack {
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                    }
            }
                .onDelete(perform: deleteFriend)
            } // end of list
            
            .navigationTitle("Birthdays")
            
            // Section where the input takes place :3
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    // makes it so you can't put a date in the future
                    DatePicker(selection: $newBirthday, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name",text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        context.insert(newFriend)
                        newName = ""
                        newBirthday = .now
                    }
                    .bold()
                } // end of VStack
                .padding()
                .background(.bar)
            }
        } // end of navigation stack
    }
    func deleteFriend(at offsets:IndexSet) {
        for index in offsets {
            let friendToDelete = friends[index]
            context.delete(friendToDelete)
        }
    }
}// end of contentview

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
