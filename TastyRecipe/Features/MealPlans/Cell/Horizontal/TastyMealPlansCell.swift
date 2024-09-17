//
//  TastyMealPlansCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 17.09.2024.
//

import UIKit

class TastyMealPlansCell: UITableViewCell {
    static let identifier = "TastyMealPlansCell"
        
    var recipesArr: [Recipe] = []
    var title: String?
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    weak var delegate: MealPlansVCProtocol?
    
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
        
        layout.itemSize = CGSize(width: ScreenSize.width / 2.5, height: 200)
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TastyMealPlansCollectionViewCell.self, forCellWithReuseIdentifier: TastyMealPlansCollectionViewCell.identifier)
        
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
    
    public func configure(recipes: [Recipe], delegate: MealPlansVCProtocol) {
        self.recipesArr = recipes
        self.delegate = delegate
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
    }
}

extension TastyMealPlansCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TastyMealPlansCollectionViewCell.identifier, for: indexPath) as! TastyMealPlansCollectionViewCell
        let model = recipesArr[indexPath.row]
        cell.configure(recipe: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = recipesArr[indexPath.row].id
//        delegate?.didSelectRecipe(recipeId: id)
    }
}
