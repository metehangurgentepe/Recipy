//
//  SearchVC.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 4.09.2024.
//

import UIKit
import SwiftUI


class SearchVC: UIViewController, UIScrollViewDelegate {
    enum Section: CaseIterable {
        case popular
        case difficulty
        case diets
        case meal
        case cookingStyle
        case cuisine
        
        var name: String {
            switch self {
            case .popular:
                "Popular"
            case .difficulty:
                "Difficulty"
            case .diets:
                "Diets"
            case .meal:
                "Meal"
            case .cookingStyle:
                "Cooking Style"
            case .cuisine:
                "Cuisine"
            }
        }
    }
    
    var collectionView: UICollectionView!
    
    var tableView = UITableView(frame: .zero, style: .grouped)
    let viewModel: SearchViewModel
    var isSearchActive = false
    var searchedRecipes = [SearchRecipeResult]()
    let labelStackView = UIStackView()
    var selectedTags: String?
    let homeVC: HomeVC
    
    let label = UILabel()
    
    init(viewModel: SearchViewModel, homeVC: HomeVC) {
        self.viewModel = viewModel
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (ScreenSize.width - 30) / 2, height: 300)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        self.homeVC = homeVC
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ThemeColor.bgColor
        
        setupTableView()
        
        collectionView.isHidden = true
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
    
    @objc func showTableView() {
        collectionView.isHidden = true
        tableView.isHidden = false
    }
    
    @objc func handleQueryNotification(_ notification: Notification) {
        if let query = notification.object as? String {
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = ThemeColor.bgColor
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
        
        view.addSubview(tableView)
        
        tableView.register(PopularCollectionTableViewCell.self, forCellReuseIdentifier: PopularCollectionTableViewCell.identifier)
        tableView.register(ButtonCollectionTableViewCell.self, forCellReuseIdentifier: ButtonCollectionTableViewCell.identifier)
        
        tableView.keyboardDismissMode = .onDrag
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = ThemeColor.bgColor
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(200)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
        }
    }
    
    private func setupCapsuleButton(title: String) {
        let capsuleButton = CapsuleLabel(text: title,
                                         image: UIImage(named: "x.circle.fill")!)
        
        capsuleButton.backgroundColor = ThemeColor.buttonBgColor
        capsuleButton.isUserInteractionEnabled = true
        
        let includeLabel = UILabel()
        includeLabel.text = "Include:"
        includeLabel.font = .preferredFont(forTextStyle: .headline).withSize(14)
        includeLabel.textColor = .white
        includeLabel.textAlignment = .left
        
        labelStackView.addArrangedSubview(includeLabel)
        labelStackView.addArrangedSubview(capsuleButton)
        
        view.addSubview(labelStackView)
        
        labelStackView.axis = .horizontal
        labelStackView.distribution = .equalSpacing
        labelStackView.spacing = 5
        labelStackView.distribution = .fillProportionally
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        capsuleButton.addGestureRecognizer(tapGesture)
        
        Task{
            selectedTags = title
            await viewModel.search(query: nil, tags: title)
        }
    }
    
    @objc func labelTapped() {
        for view in labelStackView.arrangedSubviews {
            labelStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        labelStackView.removeFromSuperview()
        collectionView.isHidden = true
        tableView.isHidden = false
    }
    
    func searchButtonPressed() {
        isSearchActive = true
        tableView.isHidden = true
        collectionView.isHidden = false
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func exitButtonTapped() {
        collectionView.isHidden = true
        tableView.isHidden = false
        labelStackView.removeFromSuperview()
        selectedTags = nil
    }
    
    func search(query: String?) {
        setupCollectionView()
        searchButtonPressed()
        Task{
            await viewModel.search(query: query ?? "", tags: selectedTags ?? nil)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 350
        case 1...3:
            return 130
        case 4:
            return 160
        case 5:
            return 160
        default:
            return 180
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PopularCollectionTableViewCell.identifier, for: indexPath) as! PopularCollectionTableViewCell
            cell.delegate = self
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCollectionTableViewCell.identifier, for: indexPath) as! ButtonCollectionTableViewCell
            cell.configure(with: viewModel.difficultyList)
            cell.delegate = self
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCollectionTableViewCell.identifier, for: indexPath) as! ButtonCollectionTableViewCell
            cell.configure(with: viewModel.dietsList)
            cell.delegate = self
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCollectionTableViewCell.identifier, for: indexPath) as! ButtonCollectionTableViewCell
            cell.configure(with: viewModel.mealList)
            cell.delegate = self
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCollectionTableViewCell.identifier, for: indexPath) as! ButtonCollectionTableViewCell
            cell.configure(with: viewModel.cookingList)
            cell.delegate = self
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCollectionTableViewCell.identifier, for: indexPath) as! ButtonCollectionTableViewCell
            cell.configure(with: viewModel.cuisine)
            cell.delegate = self
            return cell
            
        default:
            return UITableViewCell()
        }
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
        return 30
    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 4
        let itemsPerRow: CGFloat = 2
        
        let totalPadding = padding * (itemsPerRow + 1)
        let availableWidth = collectionView.bounds.width - totalPadding
        let widthPerItem = availableWidth / itemsPerRow
        
        let recipe = searchedRecipes[indexPath.item]
        let estimatedHeight = estimatedHeightForText(recipe.name!, width: widthPerItem)
        
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


extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        
        cell.configure(recipe: searchedRecipes[indexPath.item])
        return cell
    }
}

//extension SearchVC: SearchVCDelegate {
//    func didTapReturnSearch(with query: String?) {
//        searchButtonPressed()
//        Task{
//            await viewModel.search(query: query ?? "", tags: selectedTags ?? nil)
//        }
//    }
//}

extension SearchVC: SearchViewDelegate {
    func didSelect() {
        
    }
    
    func refreshCollectionView(recipe: [SearchRecipeResult]) {
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else { return }
            
            self.searchedRecipes = recipe
            self.collectionView.reloadData()
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
}

extension SearchVC: ButtonCollectionTableViewCellDelegate {
    func buttonClicked(with title: String) {
        setupCapsuleButton(title: title)
        
        setupCollectionView()
        
        collectionView.isHidden = false
        tableView.isHidden = true
    }
}


//struct SearchViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewControllerPreview {
//            SearchVC(viewModel: SearchViewModel(httpClient: HTTPClient(session: .shared)))
//        }
//    }
//}

