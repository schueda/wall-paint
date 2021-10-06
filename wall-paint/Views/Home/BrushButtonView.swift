//
//  BrushButtonView.swift
//  wall-paint
//
//  Created by André Schueda on 06/10/21.
//

import UIKit

class BrushButtonView: UIView {
    lazy var underBlueCube: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.7
        imageView.image = .appBlueCube
        imageView.contentMode = .scaleAspectFit
        imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        return imageView
    }()
    
    lazy var brush: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .systemBrush
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var overBlueCube: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.7
        imageView.image = .appBlueCube
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        
        setupUnderBlueCube()
        setupBrush()
        setupOverBlueCube()
    }
    
    func setupUnderBlueCube() {
        addSubview(underBlueCube)
        underBlueCube.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupBrush() {
        addSubview(brush)
        brush.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-32)
        }
    }
    
    func setupOverBlueCube() {
        addSubview(overBlueCube)
        overBlueCube.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
