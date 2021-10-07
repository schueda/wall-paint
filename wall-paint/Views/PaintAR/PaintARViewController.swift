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
        
    }
    
    lazy var shotButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appShotButton
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ARWorldTrackingConfiguration.isSupported {
            ARView.session.run(sessionConfiguration, options: [.removeExistingAnchors, .resetTracking])
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
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
}

extension PaintARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard focalNode == nil else { return }
        let node = FocalNode()
        ARView.scene.rootNode.addChildNode(node)
        self.focalNode = node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let focalNode = focalNode else { return }
        let hit = ARView.hitTest(screenCenter, types: .existingPlane)
        guard let positionColumn = hit.first?.worldTransform.columns.3 else { return }
        focalNode.position = SCNVector3(x: positionColumn.x, y: positionColumn.y, z: positionColumn.z)
    }
}
