//
//  UIImage+.swift
//  wall-paint
//
//  Created by André Schueda on 06/10/21.
//

import Foundation
import UIKit

extension UIImage {
    open class var appBlueCube: UIImage { get {
        UIImage(named: "BlueCube")!
    }}
    
    open class var appGoldenCube: UIImage { get {
        UIImage(named: "GoldenCube")!
    }}
    
    open class var appBackButton: UIImage { get {
        UIImage(named: "BackButton")!
    }}
    
    open class var appShotButton: UIImage { get {
        UIImage(named: "ShotButton")!
    }}
    
    open class var appCheckButton: UIImage { get {
        UIImage(named: "CheckButton")!
    }}
    
    open class var appXButton: UIImage { get {
        UIImage(named: "XButton")!
    }}
    
    open class var systemBrush: UIImage { get {
        UIImage(systemName: "paintbrush")!
    }}
}
