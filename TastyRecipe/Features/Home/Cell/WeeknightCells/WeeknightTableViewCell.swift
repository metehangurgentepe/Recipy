//
//  WeeknightTableViewCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 5.09.2024.
//

import UIKit

class WeeknightTableViewCell: UITableViewCell {

    static let identifier = "WeeknightTableViewCell"
    
    var recipesArr: [Recipe] = []
    var title: String?
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    
    weak var delegate: HomeVCDelegate?
    
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
        
        let height = 1170 / 150
        
        layout.itemSize = CGSize(width: 780 / height, height: 150)
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeeknightCollectionViewCell.self, forCellWithReuseIdentifier: WeeknightCollectionViewCell.identifier)
        
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
    
    public func configure(recipes: [Recipe], delegate: HomeVCDelegate) {
        self.recipesArr = recipes
        self.delegate = delegate
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
    }
}

extension WeeknightTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeknightCollectionViewCell.identifier, for: indexPath) as! WeeknightCollectionViewCell
        let model = recipesArr[indexPath.row]
        cell.configure(recipe: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = recipesArr[indexPath.row].id
        delegate?.didSelectRecipe(recipeId: id)
    }
}
