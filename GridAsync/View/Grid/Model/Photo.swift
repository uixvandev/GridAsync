//
//  Photo.swift
//  GridAsync
//
//  Created by irfan wahendra on 20/07/24.
//

import Foundation

struct PhotoModel: Identifiable, Decodable {
    let id: Int
    let title: String
    let thumbnailUrl: String
}
