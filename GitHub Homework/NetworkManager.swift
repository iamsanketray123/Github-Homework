//
//  NetworkManager.swift
//  GitHub Homework
//
//  Created by Sanket Ray on 12/18/20.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let searchUrl = "https://api.github.com/search/repositories"
    private init() {}
    
    fileprivate func generateRepositories(_ items: [[String : AnyObject]], _ respositories: inout [Repository]) throws {
        for item in items {
            let description = item["description"] as? String
            var repOwner: Owner? = nil
            var repLicense: License? = nil
            let language = item["language"] as? String
            
            guard let name = item["name"] as? String, let stars = item["stargazers_count"] as? Int, let lastUpadatedAt = item["updated_at"] as? String else {
                throw GHError.invalidData
            }
            
            if let owner = item["owner"] as? [String: AnyObject] {
                guard let name = owner["login"] as? String, let avatarUrlString = owner["avatar_url"] as? String else {
                    throw GHError.invalidData
                }
                repOwner = Owner(loginName: name, avatarString: avatarUrlString)
            }
            
            if let license = item["license"] as? [String: AnyObject] {
                let urlString = license["url"] as? String
                guard let name = license["name"] as? String else {
                    throw GHError.invalidData
                }
                repLicense = License(name: name, urlString: urlString)
            }
            
            let repository = Repository(name: name, stars: stars, owner: repOwner, description: description, language: language, license: repLicense, lastUpdated: lastUpadatedAt)
            respositories.append(repository)
            
        }
    }
    
    func fetchRepository(with name: String, completion: @escaping (Result<[Repository], GHError>) -> Void) {
        
        let endpoint = searchUrl + "?q=\(name)"

        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidResponse))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.unableToComplete))
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            let parsedResult : [String:AnyObject]!
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
            } catch {
                print("error parsing data", error.localizedDescription,"🥤")
                completion(.failure(.invalidData))
                return
            }
            
            guard let items = parsedResult["items"] as? [[String: AnyObject]] else {
                completion(.failure(.invalidData))
                return
            }
            
            var respositories = [Repository]()
            do {
                try self.generateRepositories(items, &respositories)
            } catch {
                completion(.failure(.invalidData))
            }
            
            respositories.count > 0 ? completion(.success(respositories)) : completion(.failure(.noResults))
            
        }.resume()
        
    }
    
}
