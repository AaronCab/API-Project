//
//  APIClient.swift
//  RickandMorty
//
//  Created by Aaron Cabreja on 1/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class APIClient {
    
    static func getCharacters(pageCount: String, completionHandler: @escaping (AppError?, [Result]?) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character/?page=\(pageCount)"

        NetworkHelper.performDataTask(urlString: urlString, httpMethod: "GET") { (error, data, response) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    let characterData = try JSONDecoder().decode(CharacterData.self, from: data)
                    // closure captures value from network response
                    completionHandler(nil, characterData.results)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}
