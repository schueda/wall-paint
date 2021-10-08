//
//  PaintARViewController.swift
//  wall-paint
//
//  Created by André Schueda on 07/10/21.
//

import UIKit
import ARKit

class PaintARViewController: UIViewController {
    var focalNode: SCNNode?
    var screenCenter = CGPoint(x: 0, y: 0)
    
    lazy var ARView: ARSCNView = {
        let sceneView = ARSCNView()
        
        sceneView.delegate = self
        sceneView.session = ARSession()
        sceneView.automaticallyUpdatesLighting = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.preferredFramesPerSecond = 60
        
        return sceneView
    }()
    
    let sessionConfiguration: ARWorldTrackingConfiguration = {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .vertical
        return config
    }()
    
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(clickedBack), for: .touchUpInside)
        return button
    }()
    
    @objc func clickedBack() {
        navigationController?.popViewController(animated: true)
    }
    
    lazy var backButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appBackButton
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    lazy var shotButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(clickedShot), for: .touchUpInside)
        return button
    }()
    
    @objc func clickedShot() {
        let sceneImage = ARView.snapshot()
        shotImageView.image = sceneImage
        
        UIView.animate(withDuration: 0.5) {
            self.shotImageView.alpha = 1
            self.checkButton.alpha = 1
            self.xButton.alpha = 1
            self.shotButton.alpha = 0
            self.backButton.alpha = 0
        }
    }
    
    lazy var shotButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appShotButton
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var shotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.alpha = 0
        return imageView
    }()
    
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(clickedCheck), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    @objc func clickedCheck() {
        //todo: salvar a imagem
        //      fazer o feedback de que a imagem foi salva na galeria
        UIView.animate(withDuration: 0.5) {
            self.shotImageView.alpha = 0
            self.checkButton.alpha = 0
            self.xButton.alpha = 0
            self.shotButton.alpha = 1
            self.backButton.alpha = 1
        }
        
    }
    
    lazy var checkButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appCheckButton
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var xButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(clickedX), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    @objc func clickedX() {
        UIView.animate(withDuration: 0.5) {
            self.shotImageView.alpha = 0
            self.checkButton.alpha = 0
            self.xButton.alpha = 0
            self.shotButton.alpha = 1
            self.backButton.alpha = 1

        }
    }
    
    lazy var xButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appXButton
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ARWorldTrackingConfiguration.isSupported {
            ARView.session.run(sessionConfiguration)
        } else {
            print("Sorry, your device doesn't support ARKit")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ARView.session.pause()
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appLightGolden
        screenCenter = view.center
        
        setupARView()
        setupBackButton()
        setupShotButton()
        
        setupShotImageView()
        setupCheckButton()
        setupXButton()
        
        setupNavigationBar()
    }
    
    func setupARView() {
        view.addSubview(ARView)
        ARView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupBackButton() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        backButton.addSubview(backButtonImageView)
        backButtonImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupShotButton() {
        view.addSubview(shotButton)
        shotButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        shotButton.addSubview(shotButtonImageView)
        shotButtonImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupShotImageView() {
        view.addSubview(shotImageView)
        shotImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(shotButton.snp.centerY)
            make.height.equalTo(view.bounds.height * 0.8)
            make.width.equalTo(view.bounds.width * 0.8)
        }
    }
    
    func setupCheckButton() {
        view.addSubview(checkButton)
        checkButton.snp.makeConstraints { make in
            make.centerY.equalTo(shotImageView.snp.bottom)
            make.leading.equalTo(shotImageView).offset(32)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        checkButton.addSubview(checkButtonImageView)
        checkButtonImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupXButton() {
        view.addSubview(xButton)
        xButton.snp.makeConstraints { make in
            make.centerY.equalTo(shotImageView.snp.bottom)
            make.trailing.equalTo(shotImageView).offset(-32)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        xButton.addSubview(xButtonImageView)
        xButtonImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
}

extension PaintARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        let plane = Plane(anchor: planeAnchor, in: ARView)
        if node.childNodes.isEmpty {
            node.addChildNode(plane)
        }
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // Update only anchors and nodes set up by `renderer(_:didAdd:for:)`.
        guard let planeAnchor = anchor as? ARPlaneAnchor,
              let plane = node.childNodes.first as? Plane
        else { return }
        
        // Update ARSCNPlaneGeometry to the anchor's new estimated shape.
        if let planeGeometry = plane.meshNode.geometry as? ARSCNPlaneGeometry {
            planeGeometry.update(from: planeAnchor.geometry)
        }
        
        // Update extent visualization to the anchor's new bounding rectangle.
        if let extentGeometry = plane.extentNode.geometry as? SCNPlane {
            extentGeometry.width = CGFloat(planeAnchor.extent.x)
            extentGeometry.height = CGFloat(planeAnchor.extent.z)
            plane.extentNode.simdPosition = planeAnchor.center
        }
        
        // Update the plane's classification and the text position
        if #available(iOS 12.0, *),
           let classificationNode = plane.classificationNode,
           let classificationGeometry = classificationNode.geometry as? SCNText {
            let currentClassification = planeAnchor.classification.description
            if let oldClassification = classificationGeometry.string as? String, oldClassification != currentClassification {
                classificationGeometry.string = currentClassification
                classificationNode.centerAlign()
            }
        }
    }
}
