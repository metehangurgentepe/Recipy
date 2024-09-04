//
//  SplashVC.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import UIKit
import SnapKit

class SplashVC: UIViewController {
    
    var appName: String = "Recipy"
    
    var appNameLabel: UILabel = {
        let label  = UILabel()
        label.font = .preferredFont(forTextStyle: .headline).withSize(40)
        label.text = "Recipy"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupAppLogo()
    }
    
    func setupAppLogo() {
        view.addSubview(appNameLabel)
        
        appNameLabel.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 10, animations: {
            self.appNameLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
        }) { _ in
            self.navigate()
        }
    }
    
    func navigate() {
        let vm = HomeViewModel(httpClient: HTTPClient(session: .shared))
        let vc = HomeVC(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
