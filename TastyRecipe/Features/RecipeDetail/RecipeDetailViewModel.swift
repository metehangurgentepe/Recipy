//
//  RecipeDetailViewModel.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 4.09.2024.
//

import Foundation

class RecipeDetailViewModel {
    let httpClient: HTTPClient
    
    private(set) var recipe: RecipeDetailModel?
    var id: Int?
    weak var delegate: RecipeDetailViewDelegate?
    
    init(httpClient: HTTPClient, id: Int){
        self.httpClient = httpClient
        self.id = id
    }
    
    func getRecipe() async{
        let url = URL(string: Constants.baseURL)!
        let headers = Constants.authApiKey
        let resource  = Resource(url: url, path: .detailRecipe("\(self.id!)"), headers: headers, modelType: RecipeDetailModel.self)
        
        do{
            let recipe = try await httpClient.load(resource)
            self.recipe = recipe
            self.delegate?.getDetail(recipe: self.recipe!)
        } catch {
            self.delegate?.showError(error)
        }
    }
    
    func getSimilarRecipe() async {
        let url = URL(string: Constants.baseURL)!
        let headers = Constants.authApiKey
        let resource  = Resource(url: url, path: .similarRecipe("\(self.id!)"), headers: headers, modelType: [SimilarRecipeDetailModel].self)
        
        do{
            let idArr = try await httpClient.load(resource)
            var similarRecipes: [RecipeDetailModel] = []
            
            try await withThrowingTaskGroup(of: RecipeDetailModel?.self) { group in
                for id in idArr {
                    group.addTask {
                        return await self.fetchRecipeDetail(for: id.id)
                    }
                }
                
                for try await result in group {
                    if let recipe = result {
                        similarRecipes.append(recipe)
                    }
                }
            }
            
            self.delegate?.getSimilarRecipes(recipes: similarRecipes)
        } catch {
            self.delegate?.showError(error)
        }
    }
    
    func fetchRecipeDetail(for id: Int) async -> RecipeDetailModel? {
        let url = URL(string: Constants.baseURL)!
        let headers = Constants.authApiKey
        let resource = Resource(url: url, path: .detailRecipe("\(id)"), headers: headers, modelType: RecipeDetailModel.self)
        
        do {
            let recipeDetail = try await httpClient.load(resource)
            return recipeDetail
        } catch {
            return nil
        }
    }
}

