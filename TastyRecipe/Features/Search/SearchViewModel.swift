//
//  SearchViewModel.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 6.09.2024.
//

import Foundation

class SearchViewModel {
    weak var delegate: SearchViewDelegate?
    
    let httpClient: HTTPClient
    
    private(set) var recipes = [SearchRecipeResult]()
    
    init(httpClient: HTTPClient){
        self.httpClient = httpClient
    }
    
    var difficultyList = QueryList.difficultyList
    
    var dietsList = QueryList.dietsList
    
    var mealList = QueryList.mealList
    
    var cookingList = QueryList.cookingList
    
    var cuisine = QueryList.cuisine
    
    func search(query: String?, tags: String?) async{
        var queryItems: [URLQueryItem] = [
               URLQueryItem(name: "from", value: String(0)),
               URLQueryItem(name: "size", value: String(20)),
            ]
        
        if let query = query {
            queryItems = [
                URLQueryItem(name: "q", value: query),
            ]
        }
        
        if let item = tags {
            let str = item.replacingOccurrences(of: " ", with: "_").lowercased()
            let query = URLQueryItem(name: "tags", value: str)
            queryItems.append(query)
        }
        
        let url = URL(string: Constants.tastyURL)!
        let headers = Constants.authApiKey
        let resource  = Resource(url: url, path:.tastySearch , method: .get(queryItems), headers: headers, modelType: SearchRecipeDetailModel.self)
        
        do{
            let recipes = try await httpClient.load(resource)
            self.recipes = recipes.results!
            print(recipes)
            self.delegate?.refreshCollectionView(recipe: self.recipes)
        } catch {
            self.delegate?.showError(error)
        }
    }
}
