//
//  HomeVC.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import UIKit

protocol HomeVCDelegate: AnyObject {
    func didSelectMovie(movieId: Int)
}

class HomeVC: UIViewController {
    let viewModel: HomeViewModel
    
    var tableView = UITableView(frame: .zero, style: .grouped)
    
    var weeknightFavRecipes = [Recipe]()
    var community = [Recipe]()
    var trendingRecipes = [Recipe]()
    var popularRecipes = [Recipe]()
    var shuffledAppetizers = [Recipe]()
    
    
    enum Section: CaseIterable {
        case weeknightFav
        case community
        case trending
        case popular
        case shuffledAppetizers
        
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
            await viewModel.getRecipe(query: nil)
        }
        
    }
    
    func design() {
        view.backgroundColor = ThemeColor.bgColor
        self.navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = ThemeColor.bgColor
        
        setupHomeTitleView()
        setupHeaderView()
        setupTableView()
    }
    
    func setupHomeTitleView() {
        let chatbotImage = UIImage(named: "chatbot_image")
        let resizedImage = chatbotImage?.resizeImage(targetSize: CGSize(width: 30, height: 30))
        
        let button = UIButton(type: .custom)
        button.setImage(resizedImage, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButtonItem
        
        let searchBar = HomeSearchBar(frame: .zero)
        
        searchBar.backgroundColor = ThemeColor.bgColor
        searchBar.layer.backgroundColor = ThemeColor.bgColor.cgColor
        
        self.navigationItem.titleView = searchBar
    }
    
    func setupHeaderView() {
        
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

extension HomeVC: HomeVCDelegate {
    func didSelectMovie(movieId: Int) {
        print("navigate")
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
//        case 0:
            
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
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as! CollectionViewTableViewCell
            if !weeknightFavRecipes.isEmpty {
                cell.configure(recipes: weeknightFavRecipes, delegate: self)
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
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        case 1:
            return 300
        default:
            return 180
        }
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
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else { return }
            print(recipes)
            
            self.weeknightFavRecipes = recipes
            self.community = recipes
            self.trendingRecipes = recipes
            self.popularRecipes = recipes
            self.shuffledAppetizers = recipes
            
            self.tableView.reloadData()
        }
    }
}


