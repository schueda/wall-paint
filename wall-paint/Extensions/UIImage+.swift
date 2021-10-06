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
    
    open class var systemChevron: UIImage { get {
        UIImage(systemName: "chevron")!
    }}
    
    open class var systemXmark: UIImage { get {
        UIImage(systemName: "xmark")!
    }}
    
    open class var systemCheckmark: UIImage { get {
        UIImage(systemName: "checkmark")!
    }}
    
    open class var systemCircle: UIImage { get {
        UIImage(systemName: "circle")!
    }}
    
    open class var systemBrush: UIImage { get {
        UIImage(systemName: "paintbrush")!
    }}
}
