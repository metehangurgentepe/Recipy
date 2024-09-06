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
    
    func getRecipe(query: String?) async{
        var queryItems: [URLQueryItem]?
        
        if let query = query {
            queryItems = [
                URLQueryItem(name: "query", value: query)
            ]
        }
        
        let url = URL(string: Constants.baseURL)!
        let headers = Constants.authApiKey
        let resource  = Resource(url: url, path: .searchRecipe, method: .get(queryItems ?? []), headers: headers, modelType: RecipeResponse.self)
        
        do{
            let recipes = try await httpClient.load(resource)
            self.recipes = recipes.results
//            self.recipes = []
            self.delegate?.refreshCollectionView(recipes: self.recipes)
        } catch {
            self.delegate?.showError(error)
        }
    }
}
