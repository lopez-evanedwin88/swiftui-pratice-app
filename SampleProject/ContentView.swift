//
//  ContentView.swift
//  SampleProject
//
//  Created by d&a-m-pro  on 5/9/23.
//

import SwiftUI

struct ContentView: View {
    
    //    @State private var email = ""
    //    @State private var password = ""
    @State private var showCreate = false
    @State private var toUpdate: Todo?
    
    @FetchRequest(fetchRequest: Todo.all())
    private var todos
    
    var provider = TodoProvider.shared
    
    @StateObject private var todoVM = TodoViewModel()
    @State private var todoVMM: [ATodo] = []
    @State private var joke: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    List{
                        ForEach(todoVMM) { todo in
                            //                        TodoRowView(provider: provider, todo: todo)
                            ATodoRowView(todo: todo)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            //                                        do {
                                            //                                            try delete(todo)
                                            //                                        } catch {
                                            //                                            print(error)
                                            //                                        }
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash").symbolVariant(.fill)
                                    }
                                    
                                    Button {
                                        withAnimation {
                                            //                                        toUpdate = todo
                                        }
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    .tint(.orange)
                                }
                            
                        }
                    }
                    .task {
                        do {
                            todoVMM = try await todoVM.fetchTodosViaModifier()
                        } catch {
                            print(error)
                        }
                    }
                    //                    .onAppear {
                    //                        todoVM.fetchTodos()
                    //                    }
                }
                
            }
            .navigationTitle("ToDo List")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showCreate.toggle()
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $showCreate, content: {
                NavigationStack {
                    CreateView(todoModel: .init(provider: provider))
                }
                .presentationDetents([.large])
            })
            .sheet(item: $toUpdate, onDismiss: {
                toUpdate = nil
            }, content: { todo in
                UpdateView(todo: todo)
            })
        }
        //        VStack {
        //            Text("Login Template")
        //                .font(.largeTitle).foregroundColor(Color.white)
        //                .padding([.top, .bottom], 40)
        //                .shadow(radius: 10.0, x: 20, y: 10)
        //
        //            VStack(alignment: .leading, spacing: 15) {
        //                TextField("Email", text: self.$email)
        //                    .padding()
        //                    .background(Color.themeTextField)
        //                    .cornerRadius(20.0)
        //                SecureField("Password", text: self.$password)
        //                    .padding()
        //                    .background(Color.themeTextField)
        //                    .cornerRadius(20.0)
        //                //            Button("Sign In") {}
        //            }.padding([.leading, .trailing], 27.5)
        //
        //            Button(action: {
        //                print("login tapped")
        //            }) {
        //                Text("Sign In")
        //                    .font(.headline)
        //                    .foregroundColor(.white)
        //                    .padding()
        //                    .frame(width: 300, height: 50)
        //                    .background(Color.green)
        //                    .cornerRadius(15.0)
        //                    .shadow(radius: 10.0, x: 20, y: 10)
        //            }.padding(.top, 25)
        //
        //            HStack(spacing: 0) {
        //                Text("Don't have an account? ")
        //                Button(action: {
        //                    print("login tapped")
        //                }) {
        //                    Text("Sign Up").foregroundColor(.white)
        //                }
        //            }.padding(.top, 20)
        //
        //        }.frame(maxHeight: .infinity)
        //        .background(
        //            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
        //                .edgesIgnoringSafeArea(.all))
        
        Text(joke)
        Button {
            Task {
                let (data, _) = try await URLSession.shared.data(from: URL(string:"https://api.chucknorris.io/jokes/random")!)
                let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
                joke = decodedResponse?.value ?? ""
            }
        } label: {
            Text("Fetch Joke")
        }
        
    }
}

private extension ContentView {
    
    func delete(_ todo: Todo) throws {
        let context = provider.viewContext
        let existingContact = try context.existingObject(with: todo.objectID)
        context.delete(existingContact)
        Task(priority: .background) {
            try await context.perform {
                try context.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let preview = TodoProvider.shared
        ContentView()
            .environment(\.managedObjectContext, preview.viewContext)
            .previewDisplayName("Mock Todo's")
            .onAppear {
                Todo.makePreview(count: 10, context: preview.viewContext)
            }
    }
}

extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}
