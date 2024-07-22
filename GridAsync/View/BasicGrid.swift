//
//  ContentView.swift
//  GridAsync
//
//  Created by Hidayat Abisena on 07/02/24.
//

import SwiftUI

struct BasicGrid: View {
    let symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "printer.dotmatrix", "scanner", "macpro.gen1", "pc", "macstudio", "flipphone"]
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: 10)
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ShareObject()
                    .frame(height: 360)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowBackground(Color.clear)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(symbols, id: \.self) { symbol in
                            Image(systemName: symbol)
                                .padding()
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                                .frame(width: 100, height: 100)
                                .background(LinearGradient(gradient: Gradient(colors: [Color("Color01"), Color("Color02")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                    .padding(.top, 16)
                    .listRowInsets(EdgeInsets(top: 12, leading:8, bottom: 12, trailing: 4))
                    
                }
                .navigationTitle("Symbols")
                .toolbar {
                    Button {
                        downloadImage()
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                    }
                    .tint(.black)
                }
                .listRowBackground(Color.clear)
            }
             .listStyle(GroupedListStyle())
        }
    }
    
    private func downloadImage() {
        let url = "https://res.cloudinary.com/moyadev/image/upload/v1700293752/iSwift/cat-fish_gwivqa.jpg?uuid=\(UUID().uuidString)"
        guard let imageURL = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 2)
            let _ = try? Data(contentsOf: imageURL)
            
            DispatchQueue.main.async {
                print(imageURL)
            }
        }
    }
}

#Preview {
    BasicGrid()
//        .preferredColorScheme(.dark)
}
