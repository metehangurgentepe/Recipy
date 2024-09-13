//
//  HomeVC.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import UIKit

protocol HomeVCDelegate: AnyObject {
    func didSelectRecipe(recipeId: Int)
    func loadMoreData()
}

class HomeVC: UIViewController {
    let viewModel: HomeViewModel
    let searchBar = HomeSearchBar(frame: .zero)
    
    lazy var searchVC: SearchVC = {
        return SearchVC(viewModel: SearchViewModel(httpClient: HTTPClient(session: .shared)), homeVC: self)
    }()
    
    var tableView = UITableView(frame: .zero, style: .grouped)
    
    var weeknightFavRecipes = [Recipe]()
    var community = [Recipe]()
    var trendingRecipes = [Recipe]()
    var popularRecipes = [Recipe]()
    var shuffledAppetizers = [Recipe]()
    var numberOfRecipe: Int = 10
    
    
    enum Section: CaseIterable {
        case weeknightFav
        case community
        case trending
        case popular
        case shuffledAppetizers
        case recents
        
        var name: String {
            switch self {
            case .weeknightFav:
                "Weeknight Favorites"
            case .community:
                "What Our Community is Cooking"
            case .trending:
                "Trending"
            case .popular:
                "Popular Recipes This Week"
            case .shuffledAppetizers:
                "Shuffled Appetizers"
            case .recents:
                "Recents"
            }
        }
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
        view.backgroundColor = .systemGray6
        
        design()
        
        Task{
            await viewModel.getRecipe(query: nil, numberOfItems: numberOfRecipe)
        }
    }
    
    func design() {
        view.backgroundColor = ThemeColor.bgColor
        self.navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = ThemeColor.bgColor
        
        setupHomeTitleView()
        setupTableView()
    }
    
    private func createButton(withImageName imageName: String, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        let image = UIImage(named: imageName)?.resizeImage(targetSize: CGSize(width: 30, height: 30))
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    private func createBarButtonItem(withButton button: UIButton) -> UIBarButtonItem {
        return UIBarButtonItem(customView: button)
    }
    
    func setupHomeTitleView() {
        let button = createButton(withImageName: "chatbot_image", action: #selector(buttonTapped))
        let barButtonItem = createBarButtonItem(withButton: button)
        self.navigationItem.leftBarButtonItem = barButtonItem
        
        searchBar.backgroundColor = ThemeColor.bgColor
        searchBar.layer.backgroundColor = ThemeColor.bgColor.cgColor
        searchBar.searchBarDelegate = self
        
        self.navigationItem.titleView = searchBar
    }
    
    func navigate() {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.view.addSubview(self.searchVC.view)
        }, completion: nil)
        
        let button = createButton(withImageName: "exit", action: #selector(exitButtonTapped))
        self.navigationItem.leftBarButtonItem = createBarButtonItem(withButton: button)
    }
    
    @objc func exitButtonTapped() {
        searchVC.view.removeFromSuperview()
        
        let button = createButton(withImageName: "chatbot_image", action: #selector(buttonTapped))
        let barButtonItem = createBarButtonItem(withButton: button)
        self.navigationItem.leftBarButtonItem = barButtonItem
        self.navigationItem.titleView?.resignFirstResponder()
        searchBar.searchTextField.text = ""
        
        searchVC.exitButtonTapped()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = ThemeColor.bgColor
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(WeeknightTableViewCell.self, forCellReuseIdentifier: WeeknightTableViewCell.identifier)
        
        tableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: CommunityTableViewCell.identifier)
        
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        tableView.register(RecentTableViewCell.self, forCellReuseIdentifier: RecentTableViewCell.identifier)
        
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height * 0.6))
        tableView.tableHeaderView = headerView
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupLayout() {
        setupTableView()
    }
    
    
    @objc func buttonTapped() {
        
    }
}

extension HomeVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - 50 {
            loadMoreData()
        }
    }
}


extension HomeVC: HomeVCDelegate {
    func loadMoreData() {
        numberOfRecipe += 4
        
        Task {
            await viewModel.getRecentRecipe(numberOfItems: numberOfRecipe)
            //            tableView.reloadData()
        }
        
        print(numberOfRecipe, "numberOfRecipe")
        print(CGFloat((numberOfRecipe / 2) * 50), "height")
    }
    
    
    func didSelectRecipe(recipeId: Int) {
        let vc = RecipeDetailVC(viewModel: RecipeDetailViewModel(httpClient: .init(session: .shared), id: recipeId), id: recipeId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeeknightTableViewCell.identifier, for: indexPath) as! WeeknightTableViewCell
            
            if !weeknightFavRecipes.isEmpty {
                cell.configure(recipes: weeknightFavRecipes, delegate: self)
            }
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTableViewCell.identifier, for: indexPath) as! CommunityTableViewCell
            
            if !weeknightFavRecipes.isEmpty {
                cell.configure(recipes: weeknightFavRecipes, delegate: self)
            }
            
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentTableViewCell.identifier, for: indexPath) as! RecentTableViewCell
            
            if !shuffledAppetizers.isEmpty {
                cell.configure(recipes: shuffledAppetizers, delegate: self, addNumberItems: numberOfRecipe)
            }
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as! CollectionViewTableViewCell
            if !weeknightFavRecipes.isEmpty {
                cell.configure(recipes: weeknightFavRecipes, delegate: self)
                cell.backgroundColor = .red
            }
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return Header(title: Section.allCases[0].name)
        case 1:
            return Header(title: Section.allCases[1].name)
        case 2:
            return Header(title: Section.allCases[2].name)
        case 3:
            return Header(title: Section.allCases[3].name)
        case 4:
            return Header(title: Section.allCases[4].name)
        case 5:
            return Header(title: Section.allCases[5].name)
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section  {
        case 0:
            return 10
        case 1:
            return 40
        case 5:
            return 40
        default:
            return 35
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
            
        case 1:
            return 300
            
        case 5:
            let numberOfItems = shuffledAppetizers.count
            let itemsPerRow: CGFloat = 2
            let rows = ceil(CGFloat(numberOfItems) / itemsPerRow)
            
            let itemHeight: CGFloat = 200
            let totalHeight = max(rows * itemHeight, 400)
            return totalHeight
            
            
        default:
            return 200
        }
    }
}

extension HomeVC: HomeSearchBarDelegate {
    func showTableView() {
        searchVC.exitButtonTapped()
    }
    
    func didTapReturn(query: String?) {
        searchVC.search(query: query)
    }
}

extension HomeVC: HomeViewDelegate {
    func refreshRecentCollectionView(recipes: [Recipe]) {
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else { return }
            
            self.shuffledAppetizers = recipes
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async{
            let ac = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            ac.addAction(UIAlertAction(title: "Cancel", style:  .cancel))
            self.present(ac,animated: true)
        }
    }
    
    
    func refreshCollectionView(recipes: [Recipe]) {
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else { return }
            
            self.weeknightFavRecipes = recipes
            self.community = recipes
            self.trendingRecipes = recipes
            self.popularRecipes = recipes
            
            self.tableView.reloadData()
        }
    }
}

struct ProductViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            HomeVC(viewModel: HomeViewModel(httpClient: .init(session: .shared)))
        }
    }
}

import Foundation
import SwiftUI

struct ViewControllerPreview: UIViewControllerRepresentable {
    
    var viewControllerBuilder: () -> UIViewController
    
    init(_ viewControllerBuilder: @escaping () -> UIViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        viewControllerBuilder()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Nothing to do here
    }
}

