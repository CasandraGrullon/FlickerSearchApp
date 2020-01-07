//
//  PhotoAPIClient.swift
//  FlickerSearchApp
//
//  Created by casandra grullon on 1/7/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct PhotoAPIClient {
    static func getSearchResults(for search: String, completion: @escaping (Result<[Photo], AppError>) -> ()) {
        
        let searchQuery = search.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "dog"
        
        let endpointURL = " https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Secrets.apiKey)&text=\(searchQuery)&radius=32&extras=url_m&per_page=&format=json&nojsoncallback=1"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let photoResults = try JSONDecoder().decode(Flicker.self, from: data)
                    let photos = photoResults.photos
                    completion(.success(photos))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
