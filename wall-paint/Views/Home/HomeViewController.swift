//
//  HomeViewController.swift
//  wall-paint
//
//  Created by André Schueda on 05/10/21.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    lazy var homeContentView: HomeContentView = {
        let view = HomeContentView(navigationController: navigationController)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentView()
        setupNavigation()
    }
    
    func setupContentView() {
        view.addSubview(homeContentView)
        homeContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupNavigation() {
    }
}
