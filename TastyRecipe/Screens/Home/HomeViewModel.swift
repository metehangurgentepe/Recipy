//
//  HomeViewModel.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import Foundation

protocol HomeViewDelegate: AnyObject {
    func refreshCollectionView(recipes: [Recipe])
    func showError(_ error: Error)
}

class HomeViewModel {
    
    let httpClient: HTTPClient
    private(set) var recipes = [Recipe]()
    weak var delegate: HomeViewDelegate?
    
    init(httpClient: HTTPClient){
        self.httpClient = httpClient
    }
    
    func getRecipe() async{
//        let queryItems
        let url = URL(string: Constants.baseURL)!
        let headers = Constants.authApiKey
        let resource  = Resource(url: url, path: .searchRecipe,headers: headers, modelType: RecipeResponse.self)
        print(resource.url)
        
        do{
            let recipes = try await httpClient.load(resource)
            self.recipes = recipes.results
            self.delegate?.refreshCollectionView(recipes: self.recipes)
        } catch {
            self.delegate?.showError(error)
        }
    }
}
