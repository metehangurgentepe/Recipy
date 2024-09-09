//
//  RecipeDetailVC.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 4.09.2024.
//

import UIKit

class RecipeDetailVC: UIViewController, UIGestureRecognizerDelegate {
    var id: Int?
    let viewModel: RecipeDetailViewModel?
    var recipe: RecipeDetailModel?
    var tableView = UITableView()
    var similarRecipes = [RecipeDetailModel]()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return UIImageView()
    }()
    
    init(viewModel: RecipeDetailViewModel, id:Int) {
        self.id = id
        self.viewModel = RecipeDetailViewModel(httpClient: .init(session: .shared),id: id)
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel!.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task{
            await viewModel?.getRecipe()
            await viewModel?.getSimilarRecipe()
        }
        
        configure()
    }
    
    func configure() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .always
        
        setupNavigationBar()
        setupNavBarItems()
        setupTableView()
    }
    
    func setupNavigationBar() {
        let titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline).withSize(14),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
    }
    
    
    func setupNavBarItems() {
        let backButtonImage = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let shareButtonImage = UIImage(named: "share")?.withRenderingMode(.alwaysOriginal)
        let calendarButtonImage = UIImage(named: "calendar")?.withRenderingMode(.alwaysOriginal)
        let bookmarkButtonImage = UIImage(named: "bookmark")?.withRenderingMode(.alwaysOriginal)
        
        let shareButton = UIBarButtonItem(image: shareButtonImage, style: .done, target: self, action: #selector(shareButtonTapped))
        let calendarButton = UIBarButtonItem(image: calendarButtonImage, style: .done, target: self, action: #selector(shareButtonTapped))
        let bookmarkButton = UIBarButtonItem(image: bookmarkButtonImage, style: .done, target: self, action: #selector(shareButtonTapped))
        
        navigationItem.rightBarButtonItems = [bookmarkButton,calendarButton,shareButton]
    }
    
    func setupTableHeaderView() {
        let ratio = imageView.image!.size.width / imageView.image!.size.height
        
        imageView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.width / ratio )
        imageView.layer.cornerRadius = 4
        tableView.tableHeaderView = imageView
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = ThemeColor.bgColor
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = ThemeColor.lightBackgroundColor
        
        tableView.showsVerticalScrollIndicator = false
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: IngredientTableViewCell.identifier)
        tableView.register(SimilarCollectionTableViewCell.self, forCellReuseIdentifier: SimilarCollectionTableViewCell.identifier)
        
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func shareButtonTapped() {
        
    }
}

extension RecipeDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let recipe = recipe{
            return recipe.extendedIngredients!.count + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let recipe = recipe {
            if indexPath.row == recipe.extendedIngredients!.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: SimilarCollectionTableViewCell.identifier, for: indexPath) as! SimilarCollectionTableViewCell
                cell.configure(recipes: similarRecipes, delegate: self)
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.identifier, for: indexPath) as! IngredientTableViewCell
                
                let model = recipe.extendedIngredients![indexPath.row]
                cell.configure(ingredient: model)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let recipe = recipe {
            if indexPath.row == recipe.extendedIngredients!.count {
                return 250
            }
        }
        return 44
    }
}

extension RecipeDetailVC: RecipeDetailViewDelegate {
    func didSelectRecipe(recipeId: Int) {
        let vm = RecipeDetailViewModel(httpClient: HTTPClient(session: .shared), id: recipeId)
        let vc = RecipeDetailVC(viewModel: vm, id: recipeId)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getSimilarRecipes(recipes: [RecipeDetailModel]) {
        DispatchQueue.main.async {
            self.similarRecipes = recipes
            self.tableView.reloadData()
        }
    }
    
    func getDetail(recipe: RecipeDetailModel) {
        DispatchQueue.main.async {
            self.recipe = recipe
            
            self.title = recipe.title
            
            if let url = recipe.image{
                self.imageView.kf.setImage(with: URL(string: url)) { result in
                    switch result {
                    case .success(_):
                        self.setupTableHeaderView()
                    case .failure(let error):
                        self.showError(error)
                    }
                }
            }
            
            self.tableView.reloadData()
            
            let preparationView = PreparationView(recipe: recipe)
            preparationView.frame.size.width = self.tableView.bounds.width
            
            preparationView.setNeedsLayout()
            preparationView.layoutIfNeeded()
            
            let height = preparationView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height + 10
            
            let footerFrame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: height)
            footerFrame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
            preparationView.frame = footerFrame
            self.tableView.tableFooterView = preparationView
        }
    }
    
    private func calculateFooterHeight(for view: UIView) -> CGFloat {
        view.layoutIfNeeded()
        return view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async{
            let ac = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            ac.addAction(UIAlertAction(title: "Cancel", style:  .cancel))
            self.present(ac,animated: true)
        }
    }
}
