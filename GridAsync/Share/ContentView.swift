//
//  ContentView.swift
//  GridAsync
//
//  Created by Hidayat Abisena on 07/02/24.
//

import SwiftUI

struct ContentView: View {
    private let url = URL(string: "https://iswift.mayar.linl")!
    
    private let photo = Image(.thecat3)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ShareLink(
                item: url,
                subject: Text("Check out this link"),
                message: Text("If you want to upgrade your skills, take a look at this course.")
            ) {
                Label("Tap to share", systemImage: "square.and.arrow.up")
            }
            
            ShareLink(item: photo, preview: SharePreview("The Cat", image: photo)) {
                Label("Tap again", systemImage: "square.and.arrow.up")
            }
        }
    }
}

#Preview {
    ContentView()
}
