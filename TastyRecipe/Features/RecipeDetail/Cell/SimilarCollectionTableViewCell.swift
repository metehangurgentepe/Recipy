//
//  SimilarCollectionTableViewCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 6.09.2024.
//

import UIKit

class SimilarCollectionTableViewCell: UITableViewCell {

    static let identifier = "SimilarCollectionTableViewCell"
    
    var recipesArr: [RecipeDetailModel] = []
    var title: String?
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    
    weak var delegate: RecipeDetailViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let height = 1170 / 200
        
        layout.itemSize = CGSize(width: 780 / height, height: 225)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) 
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SimilarRecipeCollectionViewCell.self, forCellWithReuseIdentifier: SimilarRecipeCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = ThemeColor.bgColor
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    public func configure(recipes: [RecipeDetailModel], delegate: RecipeDetailViewDelegate) {
        self.recipesArr = recipes
        self.delegate = delegate
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
    }
}

extension SimilarCollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarRecipeCollectionViewCell.identifier, for: indexPath) as! SimilarRecipeCollectionViewCell
        let model = recipesArr[indexPath.row]
        cell.configure(recipe: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = recipesArr[indexPath.row].id
        delegate?.didSelectRecipe(recipeId: id!)
    }
}
