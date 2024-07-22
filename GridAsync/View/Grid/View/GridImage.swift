//
//  GridImage.swift
//  GridAsync
//
//  Created by irfan wahendra on 20/07/24.
//

import SwiftUI

struct GridImage: View {
    @StateObject private var photoVM = PhotosViewModel()
    
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 100), spacing: 10)]
    
//    var gridItemLayout = [
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(photoVM.photos){ photo in
                    Group{
                        let url = URL(string: photo.thumbnailUrl)
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable().scaledToFit()
                                
                            case .failure(let error):
                                VStack{
                                    Image(systemName: "photo.fill")
                                    Text("Error loading image: \(error.localizedDescription)")
                                }
                            @unknown default:
                                fatalError()
                            }
                        }
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .sheet(isPresented: $photoVM.showOptions){
                        Group{
                            let defaultText = "Share this image"
                            if let imageToShare = photoVM.imageToShare{
                                ActivityView(activityItems: [defaultText, imageToShare])
                            } else {
                                ActivityView(activityItems: [defaultText])
                            }
                        }
                        .presentationDetents([.medium, .large])
                    }
                    
                    .contextMenu {
                        Button{
                            Task{
                                await photoVM.prepareImageAndShowSheet(from: photo.thumbnailUrl)
                            }
                        } label: {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                    }
                }
            }
            .padding()
        }
        .task {
            await photoVM.fetcPhotos()
        }
    }
}

#Preview {
    GridImage()
}
