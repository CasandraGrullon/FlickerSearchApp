//
//  Flicker.swift
//  FlickerSearchApp
//
//  Created by casandra grullon on 1/7/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct Flicker: Codable {
    let photos: [Photo]
}
struct Photo: Codable {
    let title: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "url_m"
    }
}
