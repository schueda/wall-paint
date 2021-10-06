//
//  HomeContentView.swift
//  wall-paint
//
//  Created by André Schueda on 06/10/21.
//

import UIKit

class HomeContentView: UIView {
    lazy var bigBlueCube: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appBlueCube
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var smallBlueCube: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appBlueCube
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var bigGoldenCube: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appGoldenCube
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var smallGoldenCube: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appGoldenCube
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var brushStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        return stack
    }()
    
    lazy var buttonLabel: UILabel = {
        let label = UILabel()
        label.text = "Paint!"
        label.font = .systemFont(ofSize: 45, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var brushButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupGradientView()
        
        setupBigBlueCube()
        setupSmallBlueCube()
        setupBigGoldenCube()
        setupSmallGoldenCube()
        setupBrushStack()
    }
    
    func setupGradientView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: -0.5, y: 0.4)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.colors = [UIColor.appLightGolden.cgColor, UIColor.appDarkGolden.cgColor]
        
        view.layer.insertSublayer(gradient, at: 0)
        addSubview(view)
    }
    
    func setupBigBlueCube() {
        let side = UIScreen.main.bounds.width * 1
        
        addSubview(bigBlueCube)
        bigBlueCube.snp.makeConstraints { make in
            make.centerX.equalTo(snp.leading).offset(32)
            make.centerY.equalTo(snp.bottom).offset(-64)
            make.width.equalTo(side)
            make.height.equalTo(side)
        }
    }
    
    func setupSmallBlueCube() {
        let side = UIScreen.main.bounds.width * 0.3
        
        addSubview(smallBlueCube)
        smallBlueCube.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-32)
            make.width.equalTo(side)
            make.height.equalTo(side)
        }
    }
    
    func setupBigGoldenCube() {
        let side = UIScreen.main.bounds.width * 1
        
        addSubview(bigGoldenCube)
        bigGoldenCube.snp.makeConstraints { make in
            make.centerX.equalTo(snp.trailing).offset(-50)
            make.centerY.equalTo(snp.top).offset(64)
            make.width.equalTo(side)
            make.height.equalTo(side)
        }
    }
    
    func setupSmallGoldenCube() {
        let side = UIScreen.main.bounds.width * 0.2
        
        addSubview(smallGoldenCube)
        smallGoldenCube.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(-16)
            make.centerY.equalTo(bigGoldenCube).offset(64)
            make.width.equalTo(side)
            make.height.equalTo(side)
        }
    }
    
    func setupBrushStack() {
        addSubview(brushStack)
        brushStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(170)
        }
        
        [
            buttonLabel,
            brushButton
        ].forEach { brushStack.addArrangedSubview($0) }
        
        brushButton.snp.makeConstraints { make in
            make.height.equalTo(170)
        }
        let brushButtonView = BrushButtonView()
        brushButton.addSubview(brushButtonView)
        brushButtonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
