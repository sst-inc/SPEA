//
//  ContentView.swift
//  SPEA
//
//  Created by Javius Loh on 30/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading = true
    var body: some View {
        ZStack {
            // Main content view with TabView
            TabView {
                FeedView()
                    .tabItem {
                        Label("Newsletters", systemImage: "newspaper.fill")
                    }
                EventsView()
                    .tabItem {
                        Label("Events", systemImage: "calendar")
                    }
                AnnouncementView()
                    .tabItem {
                        Label("Announcer", systemImage: "megaphone.fill")
                    }
                MembershipView()
                    .tabItem {
                        Label("Membership", systemImage: "person.2.fill")
                    }
            }
            .opacity(isLoading ? 0 : 1)
            .accentColor(.red)

            // Loading view
            if isLoading {
                AnimatedLoadingView()
            }
        }
        .onAppear() {
            // Simulate a network request or some loading task
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.isLoading = false
            }
        }
    }
}

#Preview {
    ContentView()
}
