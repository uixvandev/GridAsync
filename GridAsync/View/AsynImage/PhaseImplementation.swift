//
//  PhaseImplementation.swift
//  GridAsync
//
//  Created by irfan wahendra on 19/07/24.
//

import SwiftUI

struct PhaseImplementation: View {
    let imageUrl = URL(string: "https://res.cloudinary.com/moyadev/image/upload/v1701927368/LKA_h6qbro.jpg")
    
    let transition = Transaction(animation: .easeInOut(duration: 0.5))
    
    var body: some View {
        AsyncImage(url: imageUrl, transaction: transition) { phase in
            switch phase {
            case .empty:
                ProgressView()
                
            case .success(let image):
                image.resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .padding()
                
            case .failure(let error):
                Text("Error: \(error.localizedDescription)")
                
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    PhaseImplementation()
}
