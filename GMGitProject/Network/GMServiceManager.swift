//
//  GMServiceManager.swift
//  GMGitProject
//
//  Created by Satish on 17/01/21.
//

import Foundation

enum GMError: Error {
    case noDataAvailable
    case inValidData
}

class GMServiceManager {
    let resourceURL: String
    
    init(_ urlString: String) {
        self.resourceURL = urlString
    }
    
    func getCommentsData(completion: @escaping (Result<GMCommits, GMError>) -> ()) {
        guard let url = URL(string: resourceURL) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                if let responseData = data {
                    let commitsData = try JSONDecoder().decode(GMCommits.self, from: responseData)
                    completion(.success(commitsData))
                }
            }catch {
                completion(.failure(.inValidData))
            }
        }.resume()
    }
}
