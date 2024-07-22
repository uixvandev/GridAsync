//
//  PhotosViewModel.swift
//  GridAsync
//
//  Created by irfan wahendra on 20/07/24.
//

import SwiftUI

@MainActor
class PhotosViewModel: ObservableObject {
    @Published var photos: [PhotoModel] = []
    @Published var imageToShare: UIImage?
    @Published var showOptions:Bool = false
    
    func fetcPhotos() async {
        do {
            let loadedPhotos = try await loadPhotos()
            self.photos = loadedPhotos
        }
        
        catch {
            print(error)
        }
    }
    
    private func loadPhotos() async throws -> [PhotoModel] {
        // 1. Validasi URL
        guard let photosURL = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            throw URLError(.badURL)
        }
        
        // 2. Data
        let (data, _) = try await URLSession.shared.data(from: photosURL)
        
        // 3. Decode Data
        let photos = try JSONDecoder().decode([PhotoModel].self, from: data)
        return photos
    }
    
    // Download
    func downloadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else {return nil}
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print("error downloading image: \(error.localizedDescription)")
            return nil
        }
    }
    //Prepare untuk muncul di sheet
    func prepareImageAndShowSheet(from urlString: String) async {
        imageToShare = await downloadImage(from: urlString)
        showOptions = true
    }
}
