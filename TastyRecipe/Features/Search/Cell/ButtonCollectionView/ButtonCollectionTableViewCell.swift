//
//  ButtonCollectionTableViewCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 7.09.2024.
//

import UIKit

protocol ButtonCollectionTableViewCellDelegate: AnyObject {
    func buttonClicked(with title: String)
}

class ButtonCollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "ButtonTableCell"
    
    var collectionView: UICollectionView!
    
    var query: [String] = []
    weak var delegate: ButtonCollectionTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionViewContentHeight() -> CGFloat {
        return collectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    func setupCollectionView() {
        let layout = CollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
        
        collectionView.backgroundColor = ThemeColor.bgColor
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = query[indexPath.item]
        delegate?.buttonClicked(with: title)
    }
    
    func configure(with items: [String]) {
        self.query = items
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return query.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier, for: indexPath) as! ButtonCollectionViewCell
        let item = query[indexPath.item]
        cell.configure(title: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = query[indexPath.row]
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:17)]).width + 25
        return CGSize(width: cellWidth, height: 32)
    }
}
