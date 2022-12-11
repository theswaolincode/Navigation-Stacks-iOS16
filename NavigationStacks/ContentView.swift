//
//  ContentView.swift
//  NavigationStacks
//
//  Created by Daniel Ayala on 10/11/22.
//

import SwiftUI

import SwiftUI

// MARK: - PRIOR iOS 16 NAVIGATION

/*struct ContentView: View {
    var body: some View {
        NavigationView {
            List(Fruit.fruits) { fruit in
                NavigationLink(fruit.name) {
                    Text(fruit.name)
                }
            }
            .navigationTitle("Fruits")
        }
    }
}*/

// MARK: - SIMPLE NAVIGATION STACK

/*struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(Fruit.fruits) { fruit in
                NavigationLink(fruit.name, value: fruit)
            }
            .navigationTitle("Fruits")
            .navigationDestination(for: Fruit.self) { fruit in
                Text(fruit.name)
            }
        }
    }
}*/

// MARK: - NAVIGATION STACK WITH MULTIPLE NAVIGATION DESTINATIONS

/*struct ContentView: View {
    let developer: Developer = .init(name: "MR. Expert")
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink(developer.name, value: developer)
                }
                Section {
                    List(Fruit.fruits) { fruit in
                        NavigationLink(fruit.name, value: fruit)
                    }
                    .navigationTitle("Fruits")
                    .navigationDestination(for: Fruit.self) { fruit in
                        Text(fruit.name)
                    }
                }
            }
            .navigationDestination(for: Developer.self) { developer in
                VStack {
                    Image(systemName: "laptopcomputer")
                    Text(developer.name)
                }
                .font(.largeTitle)
            }
                
        }
    }
}*/

// MARK: - NAVIGATION STACK WITH A SIMPLE PATH

/*struct ContentView: View {
    @State private var path = [Fruit.fruits[7], Fruit.fruits[0]]
    let developer: Developer = .init(name: "MR. Expert")
    
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section {
                    List(Fruit.fruits) { fruit in
                        NavigationLink(fruit.name, value: fruit)
                    }
   
                }
            }
            .navigationTitle("Fruits")
            .navigationDestination(for: Fruit.self) { fruit in
                Text(fruit.name)
            }
        }
    }
}*/

// MARK: - NAVIGATION STACK WITH NAVIGATIONPATH (NAVIGATION HICHERACY)

/*struct ContentView: View {
    @State private var path = NavigationPath()
    let developer: Developer = .init(name: "MR. Expert")
    
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section {
                    NavigationLink(developer.name, value: developer)
                }
                Section {
                    List(Fruit.fruits) { fruit in
                        NavigationLink(fruit.name, value: fruit)
                    }
   
                }
            }
            .navigationTitle("Fruits")
            .navigationDestination(for: Fruit.self) { fruit in
                Text(fruit.name)
            }
            .navigationDestination(for: Developer.self) { developer in
                VStack {
                    Image(systemName: "laptopcomputer")
                    Text(developer.name)
                }
                .font(.largeTitle)
            }
        }
        .onAppear {
            path = NavigationPath([Fruit.fruits[7], Fruit.fruits[0]])
            path.append(developer)
        }
    }
}*/

// MARK: - NAVIGATION STACK WITH NAVIGATIONPATH (NAVIGATION HICHERACY) WITH POP TO ROOT

/*struct ContentView: View {
    @State private var path = [Fruit.fruits[7], Fruit.fruits[0]]
    let developer: Developer = .init(name: "MR. Expert")
    
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section {
                    NavigationLink(developer.name, value: developer)
                }
                Section {
                    List(Fruit.fruits) { fruit in
                        NavigationLink(fruit.name, value: fruit)
                    }
   
                }
            }
            .navigationTitle("Fruits")
            .navigationDestination(for: Fruit.self) { fruit in
                VStack {
                    Text(fruit.name)
                    Button("Back to Root View") {
                        path.removeAll()
                    }
                    .padding(.top, 12)
                    .buttonStyle(.borderedProminent)
                    .font(.body)
                }
            }
            .navigationDestination(for: Developer.self) { developer in
                VStack {
                    Image(systemName: "laptopcomputer")
                    Text(developer.name)
                }
                .font(.largeTitle)
            }
        }
    }
}*/

// MARK: - NAVIGATION STACK WITH SCREEN TYPES
struct ContentView: View {
    var body: some View {
        NavigationStack() {
            List {
                Section("DEVELOPERS"){
                    ForEach(Developer.developers) { developer in
                        NavigationLink(value: Screen.developer(developer)) {
                            Text("\(developer.name)")
                        }
                    }
                }
                Section("FRUITS") {
                    ForEach(Fruit.fruits) { fruit in
                        NavigationLink(value: Screen.fruit(fruit)) {
                            Text("\(fruit.name)")
                        }
                    }
                    
                }
            }
            .navigationDestination(for: Screen.self, destination: { screen in
                switch screen {
                case let .fruit(fruit):
                    VStack {
                        Text(fruit.name)
                        .padding(.top, 12)
                        .buttonStyle(.borderedProminent)
                        .font(.body)
                    }
                case let .developer(developer):
                    VStack {
                        Image(systemName: "laptopcomputer")
                        Text(developer.name)
                    }
                    .font(.largeTitle)
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - DATA MODELS

struct Fruit: Hashable, Identifiable {
    var id = UUID()
    var name: String
    
   static var fruits: [Fruit] = [
        .init(name:"🍊 Orange"),
        .init(name:"🍏 Apple"),
        .init(name:"🍒 Cherries"),
        .init(name:"🍌 Banana"),
        .init(name:"🍓 Strawberry"),
        .init(name:"🍉 Watermelon"),
        .init(name:"🍋 Lemon"),
        .init(name:"🫐 Blueberries")
    ]
}

struct Developer: Hashable, Identifiable {
    let id = UUID()
    let name: String
    
    static var developers: [Developer] = [
    .init(name: "SwiftLee"),
    .init(name: "Paul Hudson")
    ]
}


enum Screen: Hashable {
    case fruit(Fruit)
    case developer(Developer)
}

