//
//  HomeContentView.swift
//  wall-paint
//
//  Created by André Schueda on 06/10/21.
//

import UIKit

class HomeContentView: UIView {
    let navigationController: UINavigationController?
    
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
        button.addTarget(self, action: #selector(clickedBrush), for: .touchUpInside)
        return button
    }()
    
    @objc func clickedBrush(sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            sender.frame = CGRect(x: sender.bounds.minX, y: sender.bounds.midY + 10, width: sender.bounds.width, height: sender.bounds.height)
        }, completion: { (value: Bool) in
            UIView.animate(withDuration: 0.3, animations: {
                sender.frame = CGRect(x: sender.bounds.minX, y: sender.bounds.midY - 10, width: sender.bounds.width, height: sender.bounds.height)
            }) { _ in
                self.navigationController?.pushViewController(ViewController(), animated: true)
            }
        })
    }
    
    init(frame: CGRect = .zero, navigationController: UINavigationController?) {
        self.navigationController = navigationController
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
        
        UIView.animate(withDuration: 4, delay: 0, options: [.autoreverse, .repeat]) {
            self.bigBlueCube.frame = CGRect(x: self.bigBlueCube.frame.origin.x, y: self.bigBlueCube.frame.origin.y - 15, width: self.bigBlueCube.frame.size.width, height: self.bigBlueCube.frame.size.height)
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
        
        UIView.animate(withDuration: 3, delay: 0, options: [.autoreverse, .repeat]) {
            self.smallBlueCube.frame = CGRect(x: self.smallBlueCube.frame.origin.x, y: self.smallBlueCube.frame.origin.y - 15, width: self.smallBlueCube.frame.size.width, height: self.smallBlueCube.frame.size.height)
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
        
        UIView.animate(withDuration: 4, delay: 0, options: [.autoreverse, .repeat]) {
            self.bigGoldenCube.frame = CGRect(x: self.bigGoldenCube.frame.origin.x, y: self.bigGoldenCube.frame.origin.y + 15, width: self.bigGoldenCube.frame.size.width, height: self.bigGoldenCube.frame.size.height)
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
        
        UIView.animate(withDuration: 3, delay: 0, options: [.autoreverse, .repeat]) {
            self.smallGoldenCube.frame = CGRect(x: self.smallGoldenCube.frame.origin.x, y: self.smallGoldenCube.frame.origin.y + 15, width: self.smallGoldenCube.frame.size.width, height: self.smallGoldenCube.frame.size.height)
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
