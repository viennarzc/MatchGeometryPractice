//
//  MatchGeometryPracticeApp.swift
//  MatchGeometryPractice
//
//  Created by Viennarz Curtiz on 7/21/22.
//

import SwiftUI

@main
struct MatchGeometryPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Text("Profile card")
                    }
                ListCardView()
                    .tabItem {
                        Text("List Card")
                    }
            
            }
        }
    }
}
