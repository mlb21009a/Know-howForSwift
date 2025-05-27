//
//  Know_howForSwiftApp.swift
//  Know-howForSwift
//
//  Created by R on 2025/05/23.
//

import SwiftUI

@main
struct Know_howForSwiftApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                List {
                    Section(header: Text("SwiftUI")) {
                        NavigationLink("List") {
                            ContentView()
                        }
                    }


                    Section(header: Text("UIKit")) {
                        NavigationLink("CollectionView") {
                            CollectionView()
                                .tapCell {
                                    print("aaa")
                                }
                        }
                    }

                    Section(header: Text("Other")) {
                        NavigationLink("WebAPI") {
                            WeatherView()
                        }
                    }
                }
                .listStyle(.plain)
                .navigationBarTitle("Know-how", displayMode: .inline)
            }

        }
    }
}
