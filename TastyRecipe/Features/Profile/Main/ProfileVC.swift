//
//  ProfileVC.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 4.09.2024.
//

import UIKit

class ProfileVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, MenuControllerDelegate {
    
    let menuController = MenuController(collectionViewLayout: UICollectionViewFlowLayout())
    fileprivate var colors: [UIColor] = [.red, .blue, .green]
    var profileView = ProfileView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        menuController.delegate = self
        
        menuController.collectionView.selectItem(at: [0,0], animated: true, scrollPosition: .centeredHorizontally)
        
        setupCollectionView()
        
        setupLayout()
    }
    
    fileprivate func setupNavBar() {
        let image = UIImage(named: "gear")?.withRenderingMode(.alwaysOriginal).resizeImage(targetSize: .init(width: 20, height: 20))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showSettings))
    }
    
    fileprivate func setupCollectionView() {
        view.backgroundColor = ThemeColor.bgColor
        collectionView.backgroundColor = ThemeColor.bgColor
        
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.identifier)
        collectionView.register(CookbookProfileCell.self, forCellWithReuseIdentifier: CookbookProfileCell.identifier)
        collectionView.register(ActivityProfileCell.self, forCellWithReuseIdentifier: ActivityProfileCell.identifier)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc func showSettings() {
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let offset = x / 3
        menuController.menuBar.transform = CGAffineTransform(translationX: offset, y: 0)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let item = x / view.frame.width
        let indexPath = IndexPath(item: Int(item), section: 0)
        menuController.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        menuController.collectionView.allowsMultipleSelection = false
    }
    
    func didTapMenuItem(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func setupLayout() {
        let menuView = menuController.view!
        
        view.addSubview(profileView)
        view.addSubview(menuView)
        view.addSubview(collectionView)
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        menuView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(menuView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as! MainCell
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CookbookProfileCell.identifier, for: indexPath) as! CookbookProfileCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityProfileCell.identifier, for: indexPath) as! ActivityProfileCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
}
