//
//  HomeViewModel.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import Foundation


class HomeViewModel {
    let httpClient: HTTPClient
    
    private(set) var recipes = [Recipe]()
    weak var delegate: HomeViewDelegate?
    
    init(httpClient: HTTPClient){
        self.httpClient = httpClient
    }
    
    func getRecipe(query: String?, numberOfItems: Int?) async{
        var queryItems: [URLQueryItem] =  [
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "number", value: "\(numberOfItems ?? 0)")
        ]
        
        if let query = query {
            queryItems.append(URLQueryItem(name: "query", value: query))
        }
        
        let url = URL(string: Constants.baseURL)!
        let headers = Constants.authApiKey
        let resource  = Resource(url: url, path: .searchRecipe, method: .get(queryItems), headers: headers, modelType: RecipeResponse.self)
        
        do{
            let recipes = try await httpClient.load(resource)
            self.recipes = recipes.results
            self.delegate?.refreshCollectionView(recipes: self.recipes)
        } catch {
            self.delegate?.showError(error)
        }
    }
    
    func getRecentRecipe(numberOfItems: Int?) async {
        var queryItems: [URLQueryItem] =  [
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "number", value: "\(numberOfItems ?? 0)")
        ]
        
        let url = URL(string: Constants.baseURL)!
        let headers = Constants.authApiKey
        let resource  = Resource(url: url, path: .searchRecipe, method: .get(queryItems), headers: headers, modelType: RecipeResponse.self)
        
        do{
            let recipes = try await httpClient.load(resource)
            self.recipes = recipes.results
            self.delegate?.refreshRecentCollectionView(recipes: self.recipes)
        } catch {
            self.delegate?.showError(error)
        }
    }
}
