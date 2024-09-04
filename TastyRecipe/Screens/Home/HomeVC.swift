//
//  HomeVC.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import UIKit

class HomeVC: UIViewController {

    var collectionView: UICollectionView!
    let viewModel: HomeViewModel
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>!
    
    enum Section {
        case main
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        
        Task{
            await viewModel.getRecipe()
        }
        
    }
    
    func design() {
        view.backgroundColor = .systemBackground
        title = "Recipe"
        
        self.navigationItem.hidesBackButton = true
        
        setupCollectionView()
        configureDataSource()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 250)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.identifier)
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    func updatedData(on recipes: [Recipe]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
        snapshot.appendSections([.main])
        snapshot.appendItems(recipes)
        DispatchQueue.main.async{
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.identifier, for: indexPath) as! RecipeCell
            let recipe = self.viewModel.recipes[indexPath.row]
            cell.configure(recipe: recipe)
            return cell
        })
    }
}

extension HomeVC: HomeViewDelegate {
    func showError(_ error: Error) {
        DispatchQueue.main.async{
            let ac = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            ac.addAction(UIAlertAction(title: "Cancel", style:  .cancel))
            self.present(ac,animated: true)
        }
    }
    
    
    func refreshCollectionView(recipes: [Recipe]) {
        DispatchQueue.main.async{
            self.updatedData(on: recipes)
            self.collectionView.reloadData()
        }
    }
}


