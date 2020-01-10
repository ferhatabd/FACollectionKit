//
//  CellConfig.swift
//  Pilates
//
//  Created by Ferhat Abdullahoglu on 8.01.2020.
//  Copyright © 2020 Ferhat Abdullahoglu. All rights reserved.
//

import UIKit

/// Main rules for `UICollectionViewCell` to be `FACollectionView` configurable
public protocol CellConfig where Self: UICollectionViewCell {
    
    /// Contained data type
    associatedtype CellData
    
    /// Cell data
    var cellData: CellData! { get set }
    
    /// Cell ident
    static var ident: String { get }
    
    
}
