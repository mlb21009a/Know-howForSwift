//
//  Know_howForSwiftApp.swift
//  Know-howForSwift
//
//  Created by R on 2025/05/23.
//

import SwiftUI

@main
struct Know_howForSwiftApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

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

import UIKit
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    // 必要に応じて処理を追加
}
