//
//  ContentView.swift
//  GridSearchLBTA
//
//  Created by Dawid Kubicki on 21/11/2020.
//

import SwiftUI
import KingfisherSwiftUI


struct ContentView: View {
    
    @ObservedObject var vm = GridViewModel()
    
    @State var searchText = ""
    @State var isActiveSearch = false
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                
                HStack {
                    HStack {
                        TextField("Search item", text: $searchText)
                            .padding(.leading, 30)
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(12.0)
                    .padding(.horizontal)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Spacer()
                            
                            if isActiveSearch {
                                Button(action: { searchText = "" }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .padding(.vertical)
                                        .foregroundColor(.gray)
                                })
                            }
                            
                        }.padding(.horizontal, 32)
                    )
                    .onTapGesture(perform: {
                        isActiveSearch = true
                })
                    
                    if isActiveSearch {
                    
                        Button(action: {
                            
                            searchText = ""
                            isActiveSearch = false
                            
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            
                        }, label: {
                            Text("Cancel")
                                .padding(.trailing)
                                .padding(.leading, -7)
                        })
                        .padding(.trailing, 18)
                        .transition(.move(edge: .trailing))
                        .animation(.easeInOut)
                    
                    }
                }
                
                
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12, alignment: .top),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12, alignment: .top),
                    GridItem(.flexible(minimum: 100, maximum: 200), alignment: .top)
                ], alignment: .leading,spacing: 16, content: {
                      
                    ForEach(vm.results.filter({ "\($0)".contains(searchText) || searchText.isEmpty}), id: \.self) { app in
                        ItemView(appTitle: app.name, appReleaseDate: app.releaseDate, appCopyright: app.copyright, appImage: app.artworkUrl100)
                        
                    }
                    
                }).padding(.horizontal, 12)
            }.navigationTitle("Grid Search")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ItemView: View {
    
    var appTitle: String
    var appReleaseDate: String
    var appCopyright: String
    var appImage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
    
            KFImage(URL(string: appImage))
                .resizable()
                .scaledToFit()
                .cornerRadius(22.0)
                
    
            Text(appTitle)
                .font(.system(size: 10, weight: .semibold))
            Text(appReleaseDate)
                .font(.system(size: 9, weight: .regular))
            Text(appCopyright)
                .font(.system(size: 9, weight: .regular))
                .foregroundColor(.gray)
            Spacer()
        }
    }
}
