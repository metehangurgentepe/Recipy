//
//  RecentTableViewCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 9.09.2024.
//

import UIKit
import SnapKit

class RecentTableViewCell: UITableViewCell {
    
    enum Section {
        case main
    }
    
    static let identifier = "RecentCollectionTableViewCell"
    
    var recipesArr: [Recipe] = []
    var collectionView: UICollectionView!
    weak var delegate: HomeVCDelegate?
    var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>!
    private var numberOfItemsPerSection = 10

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let height = 1170 / 200
        layout.itemSize = CGSize(width: 780 / height, height: 225)
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecentCollectionViewCell.self, forCellWithReuseIdentifier: RecentCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = ThemeColor.bgColor
        collectionView.showsHorizontalScrollIndicator = false
        //        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    public func configure(recipes: [Recipe], delegate: HomeVCDelegate, addNumberItems: Int = 10) {
        self.delegate = delegate
        self.recipesArr = recipes
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            delegate?.loadMoreData()
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension RecentTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = recipesArr[indexPath.row].id
        delegate?.didSelectRecipe(recipeId: id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 4
        let itemsPerRow: CGFloat = 2
        let totalPadding = padding * (itemsPerRow + 1)
        let availableWidth = collectionView.bounds.width - totalPadding
        let widthPerItem = availableWidth / itemsPerRow
        
        let recipe = recipesArr[indexPath.item]
        let estimatedHeight = estimatedHeightForText(recipe.title, width: widthPerItem)
        
        let height = 130 + 10 + estimatedHeight + 30 + 10
        return CGSize(width: widthPerItem, height: height)
    }
    
    private func estimatedHeightForText(_ text: String, width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .headline).withSize(16)
        ]
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return estimatedFrame.height
    }
}


extension RecentTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionViewCell.identifier, for: indexPath) as! RecentCollectionViewCell
        cell.configure(recipe: recipesArr[indexPath.row])
        return cell
    }
}
