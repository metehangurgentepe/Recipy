//
//  ProfileViewModel.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 11.09.2024.
//

import Foundation

protocol ProfileViewModelProtocol: AnyObject {
    func fetchSavedRecipes(recipes: [Recipe])
    func showError(_ error: Error)
}

class ProfileViewModel {
    weak var delegate: ProfileViewModelProtocol?
    
    private(set) var savedRecipes: [Recipe] = []
    
    func fetchSavedRecipes() {
        let imageURL = "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&resize=556,505"
        
        let recipe1 = Recipe(id: 21, title: "recipe", image: imageURL, imageType: "jpg")
        let recipe2 = Recipe(id: 22, title: "recipe", image: imageURL, imageType: "jpg")
        let recipe3 = Recipe(id: 23, title: "recipe", image: imageURL, imageType: "jpg")
        let recipe4 = Recipe(id: 24, title: "recipe", image: imageURL, imageType: "jpg")
        
        delegate?.fetchSavedRecipes(recipes: [recipe1, recipe2, recipe3, recipe4])
    }
}
